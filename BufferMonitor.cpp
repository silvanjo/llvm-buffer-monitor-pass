#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Verifier.h"
#include "llvm/IR/Constant.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"


#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/LLVMContext.h>
#include <map>
#include <set>
#include <string>
#include <cstdint>
#include <iostream>

// Print on console only when in debug mode
#ifdef DEBUG
    #define DEBUG_PRINT(x)       std::cout << x << std::endl
    #define DEBUG_PRINT_INFO(x)  std::cout << "\033[34m" << x << "\033[0m" << std::endl  // Text color blue
    #define DEBUG_PRINT_WARN(x)  std::cout << "\033[33m" << x << "\033[0m" << std::endl  // Text color yellow
    #define DEBUG_PRINT_ERROR(x) std::cout << "\033[31m" << x << "\033[0m" << std::endl  // Text color red
#else
    #define DEBUG_PRINT(x)
    #define DEBUG_PRINT_INFO(x)
    #define DEBUG_PRINT_WARN(x)
    #define DEBUG_PRINT_ERROR(x)
#endif

using namespace llvm;

namespace 
{

// Node of a linked list used to store information about allocated buffer (static and dynamic)
// The linked list becomes instrumented into the transformed target program
// to have access to the buffer sizes at runtime
struct BufferNode 
{
    uint64_t BufferID;                  // Unique ID of this buffer
    uint64_t highestAccessedIndex;      // The highest accessed index of this buffer during program execution

    void* bufferAddr;                   // Address of the allocated buffer
    size_t bufferSize;                  // Size of the buffer

    struct BufferNode* next;            // Pointer to the next node
};


struct BufferMonitor : public ModulePass
{
    static char ID;

    // Head of the linked list storing address and size of dynamically allocated buffers
    StructType* BufferNodeTy;
    GlobalVariable* BufferListHead; 

    Module* module;

    std::unique_ptr<IRBuilder<>> builder;

    Function* fopenFunc;
    Function* mallocFunc;
    Function* fprintfFunc;
    Function* mainFunction;
    Function* printfFunction;

    // Custom LLVM functions
    Function* writeToFileFunction;
    Function* getBufferSizeFunction;
    Function* printBufferListFunction;

    Value* mode;
    Value* filename;
    Value* file_ptr;

    // Globals
    GlobalVariable* globalFilePtr;

    // Functions to be skipped
    std::set<Function*> skipFunctions;

    BufferMonitor() : ModulePass(ID)
    {
        
    }

    bool init(Module& M) 
    {
        this->module = &M;

        // Get context, module and create IRBuilder for instrumentations
        LLVMContext& context = M.getContext();
        builder = std::make_unique<IRBuilder<>>(context);

        // Create the first node of the linked list
        BufferNodeTy = StructType::create(context, "BufferNode");

        // Define the types of the fields in BufferNode
        std::vector<Type*> BufferNodeFields;
        BufferNodeFields.push_back(Type::getInt64Ty(context));                      // BufferID
        BufferNodeFields.push_back(Type::getInt64Ty(context));                      // highestAccessedIndex
        BufferNodeFields.push_back(PointerType::get(Type::getInt8Ty(context), 0));  // bufferAddr
        BufferNodeFields.push_back(Type::getInt64Ty(context));                      // bufferSize
        BufferNodeFields.push_back(PointerType::get(BufferNodeTy, 0));              // next pointer set to NULL
        
        // Set the fields for BufferNodeTy
        BufferNodeTy->setBody(BufferNodeFields);
        
        // Get the global variable BufferListHead
        // Create it if it does not exist
        this->BufferListHead = module->getGlobalVariable("BufferListHead");
        if (!this->BufferListHead) 
        {
            DEBUG_PRINT_INFO("Create BufferList");

            // Create the head of the linked list
            BufferListHead = new GlobalVariable(
                *module,                                                        // Module
                PointerType::get(BufferNodeTy, 0),                              // Type
                false,                                                          // isConstant
                GlobalVariable::ExternalLinkage,                                // Make it available to all modules
                ConstantPointerNull::get(PointerType::get(BufferNodeTy, 0)),    // Initializer
                "BufferListHead"                                                // Name
            );
        }

        // Get main function
        mainFunction = module->getFunction("main");
        if (!mainFunction) 
        {
            DEBUG_PRINT_WARN("No main function found");
        }

        // Open the file for writing in the beginning of the main function
        builder->SetInsertPoint(&mainFunction->getEntryBlock().front());
        
        // Get printf function
        std::vector<Type*> printfArgsTypes;
        printfArgsTypes.push_back(Type::getInt8PtrTy(context));
        FunctionType* printfFunctionType = FunctionType::get(builder->getInt32Ty(), printfArgsTypes, true);
        
        printfFunction = module->getFunction("printf");
        if (!printfFunction) 
        {
            printfFunction = Function::Create(printfFunctionType, Function::ExternalLinkage, "printf", module);
        }

        // Create Global Variable for file pointer
        this->globalFilePtr = module->getGlobalVariable("globalFilePtr");
        if (!this->globalFilePtr)
        {
            this->globalFilePtr = new GlobalVariable(
                *module,
                Type::getInt8PtrTy(context),
                false,
                GlobalVariable::ExternalLinkage,
                Constant::getNullValue(Type::getInt8PtrTy(context)),
                "globalFilePtr"
            );
        }

        // Get or insert fopen function for file IO
        FunctionType* FT = FunctionType::get(Type::getInt8PtrTy(context), { Type::getInt8PtrTy(context), Type::getInt8PtrTy(context) }, false);
        FunctionCallee fopenFuncCallee = module->getOrInsertFunction("fopen", FT);
        fopenFunc = cast<Function>(fopenFuncCallee.getCallee());  

        // Get or insert the fprint function for file IO
        FunctionType* fprintfType = FunctionType::get(Type::getInt32Ty(context), { Type::getInt8PtrTy(context), Type::getInt8PtrTy(context) }, true);
        FunctionCallee fprintfFuncCallee = module->getOrInsertFunction("fprintf", fprintfType);
        fprintfFunc = cast<Function>(fprintfFuncCallee.getCallee());

        // Open the file for writing in the beginning of the main function
        filename = builder->CreateGlobalStringPtr("output.txt");
        mode = builder->CreateGlobalStringPtr("w");
        file_ptr = builder->CreateCall(fopenFunc, {filename, mode});

        // Store the file pointer in the global variable
        builder->CreateStore(file_ptr, globalFilePtr);

        // Get or insert the malloc function
        mallocFunc = module->getFunction("malloc");
        if (!mallocFunc) 
        {
            std::vector<Type*> mallocArgTypes;
            mallocArgTypes.push_back(Type::getInt64Ty(context));
            FunctionType* mallocFuncType = FunctionType::get(Type::getInt8PtrTy(context), mallocArgTypes, false);
            mallocFunc = Function::Create(mallocFuncType, Function::ExternalLinkage, "malloc", module);
        }

        this->getBufferSizeFunction = CreateBufferSizeFunction();

        // Check if function is correct after transformations
        if (verifyFunction(*this->getBufferSizeFunction, &llvm::errs())) 
        {
            DEBUG_PRINT_ERROR("getBufferSizeFunction Function verification failed after transformations!");
            #ifdef DEBUG
                this->getBufferSizeFunction->dump();
            #endif
        }

        // Create the printBufferList function
        this->printBufferListFunction = CreatePrintBufferListFunction();

        // Check if function is correct after transformations
        if (verifyFunction(*this->printBufferListFunction, &llvm::errs())) 
        {
            DEBUG_PRINT_ERROR("printBufferListFunction Function verification failed after transformations!");
            #ifdef DEBUG
                this->printBufferListFunction->dump();
            #endif
        }

        // Create the writeToFile function
        this->writeToFileFunction = CreateWriteToFileFunction();

        if (verifyFunction(*this->writeToFileFunction, &llvm::errs())) 
        {
            DEBUG_PRINT_ERROR("writeToFileFunction Function verification failed after transformations!");
            #ifdef DEBUG
                this->writeToFileFunction->dump();
            #endif
        }

        // Add functions to skip
        skipFunctions.insert(this->writeToFileFunction);
        skipFunctions.insert(this->getBufferSizeFunction);
        skipFunctions.insert(this->printBufferListFunction);

        return true;
    }

    // Creates LLVM function for searching for the buffer with the given ID in the linked list, return null if buffer is not in the list 
    Function* CreateGetBufferFunction()
    {
        LLVMContext& context = this->module->getContext();

        // Get pointer type of BufferNode* using the default address space (0)
        PointerType* bufferNodePtrType = PointerType::get(BufferNodeTy, 0); 

        // The function returns a BufferNode* and gets a i8* (the address of the buffer). It's not a variadic function
        FunctionType* functionType = FunctionType::get( bufferNodePtrType, 
                                                        Type::getInt8PtrTy(context), 
                                                        false);

        Function* getBufferFunction = Function::Create( functionType, 
                                                        Function::ExternalLinkage,
                                                        "getBuffer",
                                                        module);

        // Set the name of the arguement
        getBufferFunction->arg_begin()->setName("bufferAddress");

        // Define the function body
        BasicBlock* entry = BasicBlock::Create(context, "entry", getBufferFunction);
        this->builder->SetInsertPoint(entry);

        // Load BufferListHead
        GlobalVariable* bufferListHead = this->module->getNamedGlobal("BufferListHead");
        Value* head = this->builder->CreateLoad(bufferListHead->getType()->getPointerElementType(), bufferListHead, "current");

        // Create an alloca instruction to store the current node
        AllocaInst* currentNodeAlloca = builder->CreateAlloca(head->getType(), 0, "currentNodeAlloca");
        builder->CreateStore(head, currentNodeAlloca);

        // Create loop condition, loop body, and exit blocks
        BasicBlock* checkIfHeadIsNull = BasicBlock::Create(context, "checkIfHeadIsNull", getBufferFunction);
        BasicBlock* loopBody = BasicBlock::Create(context, "loopBody", getBufferFunction);
        BasicBlock* exitBlock = BasicBlock::Create(context, "exitBlock", getBufferFunction);

        this->builder->CreateBr(checkIfHeadIsNull);
        this->builder->SetInsertPoint(checkIfHeadIsNull);

        // Loop condition: check if current node is null
        Type* bufferNodeType = head->getType();
        Constant* nullConstant = Constant::getNullValue(bufferNodeType);
        Value* headIsNull = this->builder->CreateICmpEQ(head, nullConstant, "isEnd");
        this->builder->CreateCondBr(headIsNull, exitBlock, loopBody);

        // Loop body: Check buffer address and traverse the list
        this->builder->SetInsertPoint(loopBody);

        // Load the current node from memory
        Value* current = builder->CreateLoad(currentNodeAlloca->getType()->getPointerElementType(), currentNodeAlloca, "current");

        Value* nodeDataAddr = this->builder->CreateStructGEP(BufferNodeTy, current, 2, "nodeDataAddr");
        Value* nodeData = this->builder->CreateLoad(nodeDataAddr->getType()->getPointerElementType(), nodeDataAddr, "nodeData");
        Value* isMatch = this->builder->CreateICmpEQ(nodeData, getBufferSizeFunction->arg_begin(), "isMatch");
    
        // Create blocks for the two possible cases
        // 1. The current node is a match
        // 2. The current node is not a match
        BasicBlock* nodeFound = BasicBlock::Create(context, "nodeFound", getBufferSizeFunction);
        BasicBlock* nextIteration = BasicBlock::Create(context, "nextIteration", getBufferSizeFunction);
        this->builder->CreateCondBr(isMatch, nodeFound, nextIteration);

        // If node was found return it
        this->builder->SetInsertPoint(nodeFound);
        this->builder->CreateRet(current);

        // Move to next node
        this->builder->SetInsertPoint(nextIteration);
        Value* nextNodeAddr = this->builder->CreateStructGEP(BufferNodeTy, current, 4, "nextNodeAddr");
        Value* nextNode = this->builder->CreateLoad(nextNodeAddr->getType()->getPointerElementType(), nextNodeAddr, "nextNode");
       
        // Store nextNode to access is it in the next iteration
        builder->CreateStore(nextNode, currentNodeAlloca);

        // Check if node is null (end of list)
        Value* isEnd = this->builder->CreateICmpEQ(nextNode, nullConstant, "isEnd");
        this->builder->CreateCondBr(isEnd, exitBlock, loopBody);
        
        // Exit block: If buffer not found return nullptr of type BufferNode*
        this->builder->SetInsertPoint(exitBlock);
        Value* nullptrBufferNode = Constant::getNullValue(bufferNodePtrType); 
        this->builder->CreateRet(nullptrBufferNode);

        return getBufferFunction;
    }

    Function* CreateBufferSizeFunction()
    {
        LLVMContext& context = this->module->getContext();

        // Define the function signature
        FunctionType* functionType = FunctionType::get( Type::getInt64Ty(context), 
                                                        Type::getInt8PtrTy(context), 
                                                        false);

        // Create the function
        Function* getBufferSizeFunction = Function::Create( functionType, 
                                                            Function::ExternalLinkage, 
                                                            "getBufferSize", 
                                                            module);

        // Set function argument name
        getBufferSizeFunction->arg_begin()->setName("bufferAddress");

        // Define the function body
        BasicBlock* entry = BasicBlock::Create(context, "entry", getBufferSizeFunction);
        this->builder->SetInsertPoint(entry);

        // Load BufferListHead
        GlobalVariable* bufferListHead = this->module->getNamedGlobal("BufferListHead");
        Value* head = this->builder->CreateLoad(bufferListHead->getType()->getPointerElementType(), bufferListHead, "current");

        // Create an alloca instruction to store the current node
        AllocaInst* currentNodeAlloca = builder->CreateAlloca(head->getType(), 0, "currentNodeAlloca");
        builder->CreateStore(head, currentNodeAlloca);

        // Create loop condition, loop body, and exit blocks
        BasicBlock* checkIfHeadIsNull = BasicBlock::Create(context, "checkIfHeadIsNull", getBufferSizeFunction);
        BasicBlock* loopBody = BasicBlock::Create(context, "loopBody", getBufferSizeFunction);
        BasicBlock* exitBlock = BasicBlock::Create(context, "exitBlock", getBufferSizeFunction);

        this->builder->CreateBr(checkIfHeadIsNull);
        this->builder->SetInsertPoint(checkIfHeadIsNull);

        // Loop condition: check if current node is null
        Type* bufferNodeType = head->getType();
        Constant* nullConstant = Constant::getNullValue(bufferNodeType);
        Value* headIsNull = this->builder->CreateICmpEQ(head, nullConstant, "isEnd");
        this->builder->CreateCondBr(headIsNull, exitBlock, loopBody);

        // Loop body: Check buffer address and traverse the list
        this->builder->SetInsertPoint(loopBody);

        // Load the current node from memory
        Value* current = builder->CreateLoad(currentNodeAlloca->getType()->getPointerElementType(), currentNodeAlloca, "current");

        Value* nodeDataAddr = this->builder->CreateStructGEP(BufferNodeTy, current, 2, "nodeDataAddr");
        Value* nodeData = this->builder->CreateLoad(nodeDataAddr->getType()->getPointerElementType(), nodeDataAddr, "nodeData");
        Value* isMatch = this->builder->CreateICmpEQ(nodeData, getBufferSizeFunction->arg_begin(), "isMatch");
    
        // Create blocks for the two possible cases
        // 1. The current node is a match
        // 2. The current node is not a match
        BasicBlock* sizeFound = BasicBlock::Create(context, "sizeFound", getBufferSizeFunction);
        BasicBlock* nextIteration = BasicBlock::Create(context, "nextIteration", getBufferSizeFunction);
        this->builder->CreateCondBr(isMatch, sizeFound, nextIteration);

        // If size is found, extract size and return
        this->builder->SetInsertPoint(sizeFound);
        Value* dataSizeAddr = this->builder->CreateStructGEP(BufferNodeTy, current, 3, "dataSizeAddr");
        Value* dataSize = this->builder->CreateLoad(dataSizeAddr->getType()->getPointerElementType(), dataSizeAddr, "dataSize");
        this->builder->CreateRet(dataSize);

        // Move to next node
        this->builder->SetInsertPoint(nextIteration);
        Value* nextNodeAddr = this->builder->CreateStructGEP(BufferNodeTy, current, 4, "nextNodeAddr");
        Value* nextNode = this->builder->CreateLoad(nextNodeAddr->getType()->getPointerElementType(), nextNodeAddr, "nextNode");
       
        // Store nextNode to access is it in the next iteration
        builder->CreateStore(nextNode, currentNodeAlloca);

        // Check if node is null (end of list)
        Value* isEnd = this->builder->CreateICmpEQ(nextNode, nullConstant, "isEnd");
        this->builder->CreateCondBr(isEnd, exitBlock, loopBody);
        
        // Exit block: If buffer not found, return -1
        this->builder->SetInsertPoint(exitBlock);
        Value* notFoundValue = ConstantInt::get(Type::getInt64Ty(context), -1, true);
        this->builder->CreateRet(notFoundValue);

        return getBufferSizeFunction;
    }

    Function* CreateWriteToFileFunction()
    {
        LLVMContext& context = this->module->getContext();

        std::vector<Type*> paramTypes = {
            Type::getInt8PtrTy(context),  // pointer to int8 (basePtr)
            Type::getInt64Ty(context),    // int64 (accessedBytes)
            Type::getInt64Ty(context)     // another int64 (bufferSize)
        };

        FunctionType* writeToFileFunctionType = FunctionType::get(Type::getVoidTy(context), 
                                                                    paramTypes, 
                                                                    false);

        Function* writeToFileFunction = Function::Create(writeToFileFunctionType, 
                                                            Function::ExternalLinkage, 
                                                            "writeToFile", 
                                                            module);

        BasicBlock* entry = BasicBlock::Create(context, "entry", writeToFileFunction);

        builder->SetInsertPoint(entry);

        // Get values from arguments
        Value* basePtr = writeToFileFunction->arg_begin();          // Get base pointer
        Value* accessedByte = writeToFileFunction->arg_begin() + 1; // Get accessed byte
        Value* bufferSize = writeToFileFunction->arg_begin() + 2;   // Get buffer size

        // Check if the buffer size is known
        // If not, don't write buffer access to file if not in debug mode

        #ifdef DEBUG

            // Create output string for the file
            std::string outputString = "Buffer access %p: %d of size: %d\n";
            Value* formatString = this->builder->CreateGlobalStringPtr(outputString.c_str());
            Value* loadedFilePtr = this->builder->CreateLoad(globalFilePtr->getType()->getPointerElementType(), globalFilePtr);
            builder->CreateCall(fprintfFunc, { loadedFilePtr, formatString, basePtr, accessedByte, bufferSize });

        #else

    
            Value* bufferSize64 = this->builder->CreateIntCast(bufferSize, Type::getInt64Ty(context),  true);

            // Compare bufferSize with 0
            Value* conditionSGE = this->builder->CreateICmpSGE(bufferSize64, ConstantInt::get(Type::getInt64Ty(context), 0), "BufferSizeSGEZero");

            // Create a basic block for the printf call
            BasicBlock* thenBlockSGE = BasicBlock::Create(context, "then_buffer_found", writeToFileFunction);
            // Create a basic block for continuation after printf
            BasicBlock* continueBlockSGE = BasicBlock::Create(context, "continue_buffer_not_found", writeToFileFunction);

            // Create a conditional branch
            this->builder->CreateCondBr(conditionSGE, thenBlockSGE, continueBlockSGE);

            // Insert printf inside thenBlock
            this->builder->SetInsertPoint(thenBlockSGE);
        
            // Create output string for the file
            std::string outputString = "Buffer access %p: %d of size: %d\n";
            Value* formatString = this->builder->CreateGlobalStringPtr(outputString.c_str());
            Value* loadedFilePtr = this->builder->CreateLoad(globalFilePtr->getType()->getPointerElementType(), globalFilePtr);
            this->builder->CreateCall(fprintfFunc, { loadedFilePtr, formatString, basePtr, accessedByte, bufferSize });
        
            // Jump to the continue block after printf
            this->builder->CreateBr(continueBlockSGE);

            // Set the insert point back to the continue block
            this->builder->SetInsertPoint(continueBlockSGE);
    
        #endif

        builder->CreateRetVoid();

        return writeToFileFunction;
    }

    Function* CreatePrintBufferListFunction()
    {
        LLVMContext& context = this->module->getContext();

        // Create the printBufferList function
        FunctionType* printBufferListType = FunctionType::get(Type::getVoidTy(context), false);
        
        Function* printBufferList = Function::Create(printBufferListType, 
                                                        Function::ExternalLinkage, 
                                                        "printBufferList", 
                                                        this->module);

        // Create the entry basic block
        BasicBlock *entry = BasicBlock::Create(context, "entry", printBufferList);
        builder->SetInsertPoint(entry);

        // Load BufferListHead
        GlobalVariable* bufferListHead = this->module->getNamedGlobal("BufferListHead");
        Value* head = this->builder->CreateLoad(bufferListHead->getType()->getPointerElementType(), bufferListHead, "head");

        // Create an alloca instruction to store the current node
        AllocaInst* currentNodeAlloca = builder->CreateAlloca(head->getType(), 0, "currentNodeAlloca");
        builder->CreateStore(head, currentNodeAlloca);

        // Create loop condition, loop body, and exit blocks
        BasicBlock* checkIfHeadIsNull = BasicBlock::Create(context, "checkIfHeadIsNull", printBufferList);
        BasicBlock* loopBody = BasicBlock::Create(context, "loopBody", printBufferList);
        BasicBlock* exit = BasicBlock::Create(context, "exit", printBufferList);

        builder->CreateBr(checkIfHeadIsNull);
        builder->SetInsertPoint(checkIfHeadIsNull);

        // Check if head node is null 
        Type* bufferNodeType = head->getType();
        Constant* nullConstant = Constant::getNullValue(bufferNodeType);
        Value* headIsNull = this->builder->CreateICmpEQ(head, nullConstant, "isEnd");
        this->builder->CreateCondBr(headIsNull, exit, loopBody);

        builder->SetInsertPoint(loopBody);

        // Load the current node from memory
        Value* current = builder->CreateLoad(currentNodeAlloca->getType()->getPointerElementType(), currentNodeAlloca, "current");

        // Fetch the data from the buffer node
        Value *dataPtr = builder->CreateStructGEP(this->BufferNodeTy, current, 2, "dataPtr");
        Value *data = builder->CreateLoad(dataPtr->getType()->getPointerElementType(), dataPtr, "data");
        
        // Print buffer address
        std::string formatAddrString = "%p\n";
        Value* formatAddrStringGlobal = builder->CreateGlobalStringPtr(formatAddrString, "formatAddrString", 0, module);
        builder->CreateCall(printfFunction, {formatAddrStringGlobal, data});

        // Fetch the dataSize 
        Value *dataSizePtr = builder->CreateStructGEP(this->BufferNodeTy, current, 3, "dataSizePtr");
        Value *dataSize = builder->CreateLoad(dataSizePtr->getType()->getPointerElementType(), dataSizePtr, "dataSize");
        
        // print bufferSize
        std::string formatSizeString = "Size: %ld\n";
        Value* formatSizeStringGlobal = builder->CreateGlobalStringPtr(formatSizeString, "formatSizeString", 0, module);
        builder->CreateCall(printfFunction, {formatSizeStringGlobal, dataSize});

        // Move to next node
        Value *nextNodeAddr = this->builder->CreateStructGEP(this->BufferNodeTy, current, 4, "nextNodeAddr");
        Value *nextNode = this->builder->CreateLoad(nextNodeAddr->getType()->getPointerElementType(), nextNodeAddr, "nextNode");

        // Store nextNode to access is it in the next iteration
        builder->CreateStore(nextNode, currentNodeAlloca);

        // Check if node is null (end of list)
        Value* isEnd = this->builder->CreateICmpEQ(nextNode, nullConstant, "isEnd");
        this->builder->CreateCondBr(isEnd, exit, loopBody);

        // Create the exit basic block and return instruction
        builder->SetInsertPoint(exit);
        builder->CreateRetVoid();

        return printBufferList;
    }

    // Insert buffer to linked list
    void InsertBufferToList(Value* bufferAddress, Value* bufferSize)
    {
        LLVMContext& context = this->module->getContext();

        // Unique buffer id for each newly inserted buffer
        static uint64_t BufferID = 0;
        BufferID += 1;
        Value* bufferIDValue = ConstantInt::get(Type::getInt64Ty(context), BufferID);

        Value* zeroConstant = ConstantInt::get(Type::getInt64Ty(context), 0);

        // Get data layout of the module to exactly determine the size of the BufferNode struct
        const DataLayout& DL = module->getDataLayout();

        // Get null pointer of type BufferNodeTy
        Value* nullPtr = ConstantPointerNull::get(PointerType::get(BufferNodeTy, 0));       

        // Determine size of BufferNode struct for malloc instruction
        uint64_t size = DL.getTypeAllocSize(BufferNodeTy);
        ConstantInt* sizeofBufferNode = ConstantInt::get(Type::getInt64Ty(context), size);

        // Create malloc call to create new BufferNode storing address and size of a dynamically allocated buffer
        Value* newNode = builder->CreateCall(mallocFunc, sizeofBufferNode);

        // Cast the return value of malloc to BufferNodeTy
        newNode = builder->CreateBitCast(newNode, PointerType::getUnqual(BufferNodeTy));

        // Initialize the new node
        builder->CreateStore(bufferIDValue, builder->CreateStructGEP(this->BufferNodeTy, newNode, 0));  // Store BufferID
        builder->CreateStore(zeroConstant,  builder->CreateStructGEP(this->BufferNodeTy, newNode, 1));  // Initialize highest accessed index with zero
        builder->CreateStore(bufferAddress, builder->CreateStructGEP(this->BufferNodeTy, newNode, 2));  // Store address
        builder->CreateStore(bufferSize,    builder->CreateStructGEP(this->BufferNodeTy, newNode, 3));  // Store size
        builder->CreateStore(nullPtr,       builder->CreateStructGEP(this->BufferNodeTy, newNode, 4));  // Set next to nullptr

        // Insert the new node at the beginning of the linked list
        Value* currentHead = builder->CreateLoad(BufferListHead->getType()->getPointerElementType(), BufferListHead, "currentHead");
        builder->CreateStore(newNode, BufferListHead);                                              // Update the head of the list to point to the new node
        builder->CreateStore(currentHead, builder->CreateStructGEP(BufferNodeTy, newNode, 4));      // Set next node of the new node to previous head           
    }

    // Returns true if the alloca instruction is a multi-dimensional array
    bool IsMultiDimensionalArray(AllocaInst* alloca)
    {
        if (!alloca) 
            return false;
        
        llvm::Type* allocatedType = alloca->getAllocatedType();
            
        // Check if the allocated type is an ArrayType
        if (ArrayType* arrayType = dyn_cast<ArrayType>(allocatedType)) 
        {
            // Now, check if the element of this array itself is an ArrayType
            if(isa<ArrayType>(arrayType->getElementType())) 
            {
                return true;
            }
        }

        return false;
    }

    // Returns true if the gep instruction is performed on a multi-dimensional array
    bool IsMultiDimensionalArray(GetElementPtrInst *gep) 
    {
        if(!gep) 
            return false;

        // Get base pointer of the buffer
        Value* basePtr = gep->getPointerOperand();

        // Check if the base pointer is a stack-allocated array
        if (AllocaInst* alloca = dyn_cast<AllocaInst>(basePtr)) 
        {
            return IsMultiDimensionalArray(alloca);
        }

        return false;
    }

    void AddGlobalsToLinkedList(Module& module)
    {
        LLVMContext& context = module.getContext();

        // Get buffers that are allocated globally and store them in the linked list
        for (auto& global : module.globals()) 
        {
            DEBUG_PRINT_INFO("Working on global: " << global.getName().str());

            GlobalVariable* globalVariable = &global;

            // Check if the global variable is an array
            if (ArrayType* arrayType = dyn_cast<ArrayType>(globalVariable->getValueType())) 
            {
                DEBUG_PRINT_INFO("Global is a buffer: " << global.getName().str());

                // Get number of elements in the array
                uint64_t arraySize = arrayType->getNumElements();  
                // Convert size to LLVM Value* for inserting into the linked list
                Value* bufferSizeValue = ConstantInt::get(Type::getInt64Ty(context), arraySize);
                
                // Cast the global variable's address to i8*
                Value* bufferAddressi8 = globalVariable;
                if (globalVariable->getType() != Type::getInt8PtrTy(context)) 
                {
                    bufferAddressi8 = builder->CreateBitCast(globalVariable, Type::getInt8PtrTy(context));
                }

                // Insert global buffer to linked list
                InsertBufferToList(bufferAddressi8, bufferSizeValue);
            }
        }
    }

    void DetermineBaseTypeOfArray()
    {
        // TODO
    }

    bool IsStruct()
    {
        // TODO
        return false;
    }

    virtual bool runOnModule(Module& M)
    {
        DEBUG_PRINT_INFO("Run pass in debug mode");

        init(M);

        LLVMContext& context = M.getContext();

        this->builder->SetInsertPoint(&mainFunction->getEntryBlock().front());

        // Iterate over all functions in the module
        for (auto& F : M)
        {
            // Functions to be skipped
            if (this->skipFunctions.find(&F) != this->skipFunctions.end())
                continue;

            // Process each function of the module
            procesFunction(F);
        }

        // Set insert point to last block of function
        BasicBlock &LastBlock = mainFunction->back();   
        builder->SetInsertPoint(LastBlock.getTerminator());

        #ifdef DEBUG
            // Print the linked list containing all buffers
            builder->CreateCall(this->printBufferListFunction);
        #endif
        builder->CreateCall(this->printBufferListFunction);

        // Close file
        std::vector<Type*> fcloseArgs;
        fcloseArgs.push_back(PointerType::getUnqual(Type::getInt8Ty(context))); // FILE* argument
        FunctionType* fcloseType = FunctionType::get(Type::getInt32Ty(context), fcloseArgs, false); 
        FunctionCallee fcloseFunc = module->getOrInsertFunction("fclose", fcloseType);
        // Load the file pointer from the global variable
        Value *loadedFilePtr = builder->CreateLoad(globalFilePtr->getType()->getPointerElementType(), globalFilePtr);
        builder->CreateCall(fcloseFunc, {loadedFilePtr});

        return true;
    }

    bool procesFunction(Function& F)
    {
        DEBUG_PRINT_INFO("Pass on function: " << F.getName().str());

        LLVMContext& context = F.getContext();

        auto I = inst_begin(F);
        auto nextInstruction = I;
        while (I != inst_end(F))
        {
            nextInstruction++;

            this->builder->SetInsertPoint(&*I);

            // Check if the current instruction is an alloca instruction
            if (AllocaInst* allocaInst = dyn_cast<AllocaInst>(&*I))
            {
                // This is an static allocation

                // Check if the allocated type is an array
                if (ArrayType* arrayType = dyn_cast<ArrayType>(allocaInst->getAllocatedType()))
                {
                    DEBUG_PRINT("Found a static allocation");
                    #ifdef DEBUG
                        allocaInst->dump();
                    #endif

                    // Determine the size of the array in bytes
                    unsigned arraySize = arrayType->getNumElements();
                    unsigned elementSizeInBytes = arrayType->getElementType()->getPrimitiveSizeInBits() / 8;
                    unsigned arraySizeInBytes = arraySize * elementSizeInBytes;
                    
                    // Convert arraySize to LLVM Value* for inserting into the linked list
                    Value* bufferSizeValue = ConstantInt::get(Type::getInt64Ty(context), arraySizeInBytes);

                    // Set insert point after current instruction
                    this->builder->SetInsertPoint(I->getNextNode());

                    // Skip to next instruction
                    // nextInstruction++;

                    // Cast the pointer to the buffer to a generic i8* pointer
                    Value* bufferAddress = allocaInst;
                    if (allocaInst->getType() != Type::getInt8PtrTy(context)) 
                    {
                        bufferAddress = builder->CreateBitCast(allocaInst, Type::getInt8PtrTy(context));
                    }
                    
                    InsertBufferToList(bufferAddress, bufferSizeValue);

                    // Write size of stack-array to file
                    std::string outputString = "Stack allocation of size: %d\n";
                    Value* formatString = this->builder->CreateGlobalStringPtr(outputString, "fileFormatString", 0, module);
                    // Load the file pointer from the global variable
                    Value *loadedFilePtr = this->builder->CreateLoad(globalFilePtr->getType()->getPointerElementType(), globalFilePtr);
                    this->builder->CreateCall(fprintfFunc, { loadedFilePtr, formatString, bufferSizeValue });

                    DEBUG_PRINT("Allocated array of size " << arraySize << " stored in linked list");
                }    
            }
            
            if (auto callInst = dyn_cast<CallInst>(&*I)) 
            {
                // This is an call instruction

                Function *calledFunc = callInst->getCalledFunction();
                if (calledFunc) 
                {
                    // Get name of called function
                    StringRef funcName = calledFunc->getName();

                    // Check if called function is malloc or new
                    if (funcName == "malloc" || funcName.startswith("_Znwm") || funcName.startswith("_Znam"))
                    {
                        // This is a heap allocation
                        DEBUG_PRINT_INFO("Found a heap allocation");

                        // get buffer name
                        std::string dynBufferName = callInst->getName().str();   

                        // Set insert point behind the current instruction
                        builder->SetInsertPoint(I->getNextNode());

                        // Skip to next instruction
                        // nextInstruction++;

                        Value* bufferAddress = callInst;                    // get address of allocated buffer
                        Value* bufferSize = callInst->getArgOperand(0);     // get size of allocated buffer

                        // Store dynamically allocated buffer in linked list
                        InsertBufferToList(bufferAddress, bufferSize);

                        // Write size of dynamicallly allocated array to file
                        std::string outputString = "Heap allocation of size: %d\n";
                        Value* formatString = builder->CreateGlobalStringPtr(outputString, "fileFormatString", 0, module);
                        // Load the file pointer from the global variable
                        Value *loadedFilePtr = builder->CreateLoad(globalFilePtr->getType()->getPointerElementType(), globalFilePtr);
                        builder->CreateCall(fprintfFunc, { loadedFilePtr, formatString, bufferSize });
                    }
                }
            }
            
            if (GetElementPtrInst* gepInst = dyn_cast<GetElementPtrInst>(&*I)) 
            {
                // This is a getelementptr instruction, a buffer is being accessed here
                DEBUG_PRINT("Found a getelementptr instruction");
                #ifdef DEBUG
                    gepInst->dump();
                #endif

                builder->SetInsertPoint(&*I);

                // Get base pointer of the buffer
                Value* basePtr = gepInst->getPointerOperand();
                
                // Get buffer name
                std::string bufferName = basePtr->getName().str();     

                // Get type of the base pointer to determine the size of the elements
                Type* baseType = basePtr->getType();
                unsigned elementSizeInBytes = 0;
                if (PointerType* ptrType = dyn_cast<PointerType>(baseType)) 
                {
                    // Get type of the base pointer
                    baseType = ptrType->getPointerElementType();
                    
                    // Print type of the base pointer
                    #ifdef DEBUG
                        baseType->dump();
                        errs() << "\n"; 
                    #endif

                    if (ArrayType* arrayType = dyn_cast<ArrayType>(baseType))
                    {
                        // It's an array. Get its element type and then its size.
                        Type* elementType = arrayType->getElementType();
                        elementSizeInBytes = elementType->getPrimitiveSizeInBits() / 8;
                    }
                    else
                    {
                        // It's a primitive type or some other type. Get its size.
                        elementSizeInBytes = baseType->getPrimitiveSizeInBits() / 8;
                    }
                }
                
                // Check if the gep instruction is performed on a multi-dimensional array
                bool isMultiDimensionalArray = IsMultiDimensionalArray(gepInst);

                int iteration = 0;
                for (auto it = gepInst->idx_begin(); it != gepInst->idx_end(); it++, iteration++) 
                {
                    // getelementptr instruction has two index values
                    // For arrays with one dimension the first is always zero
                    if (!isMultiDimensionalArray && iteration == 0) 
                    {
                        // Skip the first iteration if the array is not multi-dimensional
                        // continue;
                    }

                    // Determine accessed byte
                    Value* indexValue = it->get();
                    Value* accessedBytes = builder->CreateMul(indexValue, ConstantInt::get(Type::getInt64Ty(context), elementSizeInBytes));

                    // Ensure accessedBytes is of type i64
                    if (accessedBytes->getType() != Type::getInt64Ty(context)) 
                    {
                        accessedBytes = builder->CreateSExt(accessedBytes, Type::getInt64Ty(context));  // Use SExt for signed values
                    }

                    // Cast the pointer to the buffer to a generic i8* pointer
                    if (basePtr->getType() != Type::getInt8PtrTy(context))
                    {
                        basePtr = builder->CreateBitCast(basePtr, Type::getInt8PtrTy(context));
                    }

                    // Get the size of the buffer stored in the linked list
                    Value* bufferSize = builder->CreateCall(getBufferSizeFunction, { basePtr });

                    // Write the pointer address, the accessed byte and the size of the buffer to the file
                    builder->CreateCall(writeToFileFunction, { basePtr, accessedBytes, bufferSize });
                
                }
            } 

            I = nextInstruction;
        }

        return true;
    }
};

} // namespace

char BufferMonitor::ID = 2;

static void registerBufferMonitorPass(const PassManagerBuilder &,
                                      legacy::PassManagerBase &PM) 
{
    PM.add(new BufferMonitor());
}

// Run BufferMonitor at the end of the optimization pipeline
static RegisterStandardPasses RegisterBufferMonitorPass(
    PassManagerBuilder::EP_ModuleOptimizerEarly, registerBufferMonitorPass);

// Also run BufferMonitor when optimizations are turned off (-O0)
static RegisterStandardPasses RegisterBufferMonitorPass0(
    PassManagerBuilder::EP_EnabledOnOptLevel0, registerBufferMonitorPass);
