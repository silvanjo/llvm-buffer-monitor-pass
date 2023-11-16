#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Verifier.h"
#include "llvm/IR/Constant.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"


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
    #define DEBUG_PRINT_ERROR(x) std::cout << "\033[31m:z" << x << "\033[0m" << std::endl  // Text color red
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
    uint64_t highestAccessedByte;      // The highest accessed index of this buffer during program execution

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
    Function* fcloseFunc;
    Function* mallocFunc;
    Function* fprintfFunc;
    Function* mainFunction;
    Function* printfFunction;

    // Custom LLVM functions
    Function* getBufferFunction;
    Function* writeToFileFunction;
    Function* printBufferListFunction;
    Function* writeBufferListToFileFunction;
    Function* setHighestAccessedByteFunction;

    Value* mode;
    Value* filename;

    // Functions to be skipped
    std::set<Function*> skipFunctions;

    BufferMonitor() : ModulePass(ID)
    {
        
    }

    bool init(Module& M) 
    {
        std::cout << "Initialize BufferMonitor pass ..." << std::endl;

        this->module = &M;

        // Get context, module and create IRBuilder for instrumentations
        LLVMContext& context = M.getContext();
        builder = std::make_unique<IRBuilder<>>(context);

        // Create the first node of the linked list
        BufferNodeTy = StructType::create(context, "BufferNode");

        // Define the types of the fields in BufferNode
        std::vector<Type*> BufferNodeFields;
        BufferNodeFields.push_back(Type::getInt64Ty(context));                      // BufferID
        BufferNodeFields.push_back(Type::getInt64Ty(context));                      // highestAccessedByte
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

        // Get or insert fopen function for file IO
        FunctionType* FT = FunctionType::get(Type::getInt8PtrTy(context), { Type::getInt8PtrTy(context), Type::getInt8PtrTy(context) }, false);
        FunctionCallee fopenFuncCallee = module->getOrInsertFunction("fopen", FT);
        fopenFunc = cast<Function>(fopenFuncCallee.getCallee());  

        // Get or insert fclose function for file IO
        std::vector<Type*> fcloseArgs;
        fcloseArgs.push_back(PointerType::getUnqual(Type::getInt8Ty(context))); // FILE* argument
        FunctionType* fcloseType = FunctionType::get(Type::getInt32Ty(context), fcloseArgs, false); 
        FunctionCallee fcloseFuncCallee = module->getOrInsertFunction("fclose", fcloseType);
        fcloseFunc = cast<Function>(fcloseFuncCallee.getCallee());

        // Get or insert the fprint function for file IO
        FunctionType* fprintfType = FunctionType::get(Type::getInt32Ty(context), { Type::getInt8PtrTy(context), Type::getInt8PtrTy(context) }, true);
        FunctionCallee fprintfFuncCallee = module->getOrInsertFunction("fprintf", fprintfType);
        fprintfFunc = cast<Function>(fprintfFuncCallee.getCallee());

        // Open the file for writing in the beginning of the main function
        filename = builder->CreateGlobalStringPtr("output.txt");
        // Open file in append mode
        mode = builder->CreateGlobalStringPtr("a");

        // Get or insert the malloc function
        mallocFunc = module->getFunction("malloc");
        if (!mallocFunc) 
        {
            std::vector<Type*> mallocArgTypes;
            mallocArgTypes.push_back(Type::getInt64Ty(context));
            FunctionType* mallocFuncType = FunctionType::get(Type::getInt8PtrTy(context), mallocArgTypes, false);
            mallocFunc = Function::Create(mallocFuncType, Function::ExternalLinkage, "malloc", module);
        }

        this->getBufferFunction = CreateGetBufferFunction();

        // Check if function is correct after transformations
        if (verifyFunction(*this->getBufferFunction, &llvm::errs())) 
        {
            DEBUG_PRINT_ERROR("getBufferFuntion Function verification failed after transformations!");
            #ifdef DEBUG
                this->getBufferFunction->dump();
            #endif
        }

        // Create the printBufferList function
        this->printBufferListFunction = CreatePrintBufferListFunction();

        // Check if function is correct after transformations
        if (verifyFunction(*this->printBufferListFunction, &llvm::errs())) 
        {
            DEBUG_PRINT_ERROR("printBufferListFunction function verification failed after transformations!");
            #ifdef DEBUG
                this->printBufferListFunction->dump();
            #endif
        }

        this->setHighestAccessedByteFunction = CreateSetHighestAccessedByteFunction();

        // Check if function is correct after transformations
        if (verifyFunction(*this->setHighestAccessedByteFunction, &llvm::errs())) 
        {
            DEBUG_PRINT_ERROR("printBufferListFunction function verification failed after transformations!");
            #ifdef DEBUG
                this->setHighestAccessedByteFunction->dump();
            #endif
        }

        // Create the writeToFile function
        this->writeToFileFunction = CreateWriteToFileFunction();

        if (verifyFunction(*this->writeToFileFunction, &llvm::errs())) 
        {
            DEBUG_PRINT_ERROR("writeToFileFunction function verification failed after transformations!");
            #ifdef DEBUG
                this->writeToFileFunction->dump();
            #endif
        }

        this->writeBufferListToFileFunction = CreateWriteBufferListToFileFunction();

        if (verifyFunction(*this->writeBufferListToFileFunction, &llvm::errs()))
        {
            DEBUG_PRINT_ERROR("writeBufferListToFileFunction function verification failed after transformations!");
            #ifdef DEBUG
                this->writeToFileFunction->dump();
            #endif
        }

        // Add functions to skip
        skipFunctions.insert(this->getBufferFunction);
        skipFunctions.insert(this->writeToFileFunction);
        skipFunctions.insert(this->printBufferListFunction);
        skipFunctions.insert(this->writeBufferListToFileFunction);
        skipFunctions.insert(this->setHighestAccessedByteFunction);

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
        Value* isMatch = this->builder->CreateICmpEQ(nodeData, getBufferFunction->arg_begin(), "isMatch");
    
        // Create blocks for the two possible cases
        // 1. The current node is a match
        // 2. The current node is not a match
        BasicBlock* nodeFound = BasicBlock::Create(context, "nodeFound", getBufferFunction);
        BasicBlock* nextIteration = BasicBlock::Create(context, "nextIteration", getBufferFunction);
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

    // LLVM function that updates the highestAccessedByte member of BufferNode if the passed index 
    // is higher then the current value of highestAccessedByte
    // This function returns true if value was updated
    Function* CreateSetHighestAccessedByteFunction()
    {
        LLVMContext& context = this->module->getContext();

        // Get pointer type of BufferNode* using the default address space (0)
        PointerType* buffernodePtrType = PointerType::get(BufferNodeTy, 0);
        // Get nullptr of type BufferNotTy
        Constant* bufferNodeNullptr = ConstantPointerNull::get(buffernodePtrType);

        // Specify the function type of writeToFileFunction 
        FunctionType* setHighestAccessedByteFunctionType = FunctionType::get( Type::getInt1Ty(context),
                                                                              { buffernodePtrType, Type::getInt64Ty(context) },
                                                                              false);

        Function* setHighestAccessedByteFunction = Function::Create( setHighestAccessedByteFunctionType,
                                                                      Function::ExternalLinkage,
                                                                      "setHighestAccessedByte",
                                                                      this->module);
        
        BasicBlock* entryBB = BasicBlock::Create(context, "Entry", setHighestAccessedByteFunction);
        // Body of the function
        BasicBlock* bodyBB = BasicBlock::Create(context, "Body", setHighestAccessedByteFunction);
        // This Basic Block is reached if currently accessed byte is greater then the highest accessed byte
        BasicBlock* isGreaterBB = BasicBlock::Create(context, "IsGreater", setHighestAccessedByteFunction);
        // This basic block return true (highestAccessedByte changed)
        BasicBlock* returnTrueBB = BasicBlock::Create(context, "Changed", setHighestAccessedByteFunction); 
        // This basic block returns false (highestAccessedByte not changed)
        BasicBlock* returnFalseBB = BasicBlock::Create(context, "NotChanged", setHighestAccessedByteFunction);

        // Get buffer from argument list
        Value* buffer = &*setHighestAccessedByteFunction->arg_begin();    
        // Get accessed byte from argument list
        Value* accessedByte = setHighestAccessedByteFunction->arg_begin() + 1;

        this->builder->SetInsertPoint(entryBB);

        // Check if the passed buffer node is null
        Value* bufferNodeIsNullptr = this->builder->CreateICmpEQ(buffer, bufferNodeNullptr); 
        // Create a conditional branch
        this->builder->CreateCondBr(bufferNodeIsNullptr, returnFalseBB, bodyBB);

        this->builder->SetInsertPoint(bodyBB);
                
        // Get highestAccessedByte pointer from buffer node
        Value* highestAccessedBytePtr = this->builder->CreateStructGEP(this->BufferNodeTy, buffer, 1, "HighestAccessedBytePtr"); 
        Value* highestAccessedByte    = this->builder->CreateLoad(highestAccessedBytePtr, "HighestAccessedByte");

        // Check if the currently accessed byte is greater then the highestAccessedByte
        Value* isGreater = builder->CreateICmpSGT(accessedByte, highestAccessedByte, "accessedByteIsGreater");
        // Conditional branch dependending on isGreater 
        this->builder->CreateCondBr(isGreater, isGreaterBB, returnFalseBB);

        this->builder->SetInsertPoint(isGreaterBB);
      
        // Currently accessed byte is greater then the highest accessed byter, so we update it
        this->builder->CreateStore(accessedByte, highestAccessedBytePtr);

        this->builder->CreateBr(returnTrueBB); 

        this->builder->SetInsertPoint(returnTrueBB);
        // True variable
        Value* trueValue = ConstantInt::get(Type::getInt1Ty(context), 1);
        // Return true
        this->builder->CreateRet(trueValue);

        this->builder->SetInsertPoint(returnFalseBB);
        // False Value
        Value* falseValue = ConstantInt::get(Type::getInt1Ty(context), 0);
        // Return false
        this->builder->CreateRet(falseValue);
        
        return setHighestAccessedByteFunction;
    }

    // LLVM function that takes a BufferNode* and writes it's data to the file
    Function* CreateWriteToFileFunction()
    {
        LLVMContext& context = this->module->getContext();

        // Get pointer type of BufferNode* using the default address space (0)
        PointerType* bufferNodePtrType = PointerType::get(BufferNodeTy, 0); 
        // Get nullptr of type BufferNotTy
        Constant* bufferNodeNullptr = ConstantPointerNull::get(bufferNodePtrType);

        // Specify the function type of writeToFileFunction 
        FunctionType* writeToFileFunctionType = FunctionType::get(  Type::getVoidTy(context), 
                                                                    {bufferNodePtrType, Type::getInt64Ty(context)}, 
                                                                    false);

        Function* writeToFileFunction = Function::Create(   writeToFileFunctionType, 
                                                            Function::ExternalLinkage, 
                                                            "writeToFile", 
                                                            this->module);

        BasicBlock* entry = BasicBlock::Create(context, "entry", writeToFileFunction);
        // Create a basic block for the printf call
        BasicBlock* thenBlockSGE = BasicBlock::Create(context, "then_buffer_found", writeToFileFunction);
        // Create a basic block for continuation after printf
        BasicBlock* continueBlockSGE = BasicBlock::Create(context, "continue_buffer_not_found", writeToFileFunction);

        // Get buffer from argument list
        Value* buffer = &*writeToFileFunction->arg_begin();    
        // Get accessed byte from argument list
        Value* accessedByte = writeToFileFunction->arg_begin() + 1; 

        this->builder->SetInsertPoint(entry);

        // Open file for writing
        Value* file_ptr_tmp = builder->CreateCall(fopenFunc, { filename, mode });

        // Check if the passed buffer node is null
        Value* bufferNodeIsNullptr = this->builder->CreateICmpEQ(buffer, bufferNodeNullptr);  

        // Create a conditional branch
        this->builder->CreateCondBr(bufferNodeIsNullptr, continueBlockSGE, thenBlockSGE);

        // Insert printf inside thenBlock
        this->builder->SetInsertPoint(thenBlockSGE);

        // Get the elements of the buffer node
        Value* bufferIDPtr = this->builder->CreateStructGEP(BufferNodeTy, buffer, 0);
        Value* bufferID    = this->builder->CreateLoad(bufferIDPtr, "BufferID");

        Value* highestAccessedBytePtr = this->builder->CreateStructGEP(BufferNodeTy, buffer, 1);
        Value* highestAccessedByte    = this->builder->CreateLoad(highestAccessedBytePtr, "HighestByte");

        Value* bufferAddressPtr = this->builder->CreateStructGEP(BufferNodeTy, buffer, 2);
        Value* bufferAddress    = this->builder->CreateLoad(bufferAddressPtr, "BufferAddress");

        Value* bufferSizePtr = this->builder->CreateStructGEP(BufferNodeTy, buffer, 3); 
        Value* bufferSize    = this->builder->CreateLoad(bufferSizePtr, "BufferSize");

        // Create output string for the file
        std::string outputString = "Buffer address %p; Accessed index %d; Buffer size %d; ID %d; HAB %d\n";
        Value* formatString = this->builder->CreateGlobalStringPtr(outputString.c_str());

        // Write to file
        this->builder->CreateCall(fprintfFunc, { file_ptr_tmp, formatString, bufferAddress, accessedByte, bufferSize, bufferID, highestAccessedByte });
    
        // Close file after writing to it
        builder->CreateCall(fcloseFunc, { file_ptr_tmp });

        // Jump to the continue block after printf
        this->builder->CreateBr(continueBlockSGE);

        // Set the insert point back to the continue block
        this->builder->SetInsertPoint(continueBlockSGE);
    
        builder->CreateRetVoid();

        return writeToFileFunction;
    }

    Function* CreateWriteBufferListToFileFunction()
    {
        LLVMContext& context = this->module->getContext();

        // Get pointer type of BufferNode* using the default address space (0)
        PointerType* bufferNodePtrType = PointerType::get(BufferNodeTy, 0); 
        // Get nullptr of type BufferNotTy
        Constant* bufferNodeNullptr = ConstantPointerNull::get(bufferNodePtrType);

        FunctionType* writeBufferListToFileType = FunctionType::get(Type::getVoidTy(context), false);

        Function* writeBufferListToFileFunction = Function::Create( writeBufferListToFileType,
                                                                    Function::ExternalLinkage,
                                                                    "writeBufferListToFile",
                                                                    this->module);
        
        BasicBlock* entry = BasicBlock::Create(context, "Entry", writeBufferListToFileFunction);
        BasicBlock* checkIfHeadIsNull = BasicBlock::Create(context, "LoopBody", writeBufferListToFileFunction);
        BasicBlock* loopBody = BasicBlock::Create(context, "LoopBody", writeBufferListToFileFunction);
        BasicBlock* exit = BasicBlock::Create(context, "Exit", writeBufferListToFileFunction);

        this->builder->SetInsertPoint(entry);

        // Load the head of the buffer list
        GlobalVariable* bufferListHead = this->module->getNamedGlobal("BufferListHead");
        Value* head = this->builder->CreateLoad(bufferListHead->getType()->getPointerElementType(), bufferListHead, "head");

        // Create an alloca instruction to store the current node
        AllocaInst* currentNodeAlloca = this->builder->CreateAlloca(head->getType(), 0, "currentNodeAlloca");
        this->builder->CreateStore(head, currentNodeAlloca);

        this->builder->CreateBr(checkIfHeadIsNull); 
        
        this->builder->SetInsertPoint(checkIfHeadIsNull);

        // Check if head node is null 
        Value* headIsNull = this->builder->CreateICmpEQ(head, bufferNodeNullptr); 
        this->builder->CreateCondBr(headIsNull, exit, loopBody);

        this->builder->SetInsertPoint(loopBody);

        Value* currentNode = this->builder->CreateLoad(currentNodeAlloca->getType()->getPointerElementType(), currentNodeAlloca, "current");

        // Fetch data from BufferNode
        Value* bufferIDPtr = this->builder->CreateStructGEP(BufferNodeTy, currentNode, 0);
        Value* bufferID    = this->builder->CreateLoad(bufferIDPtr, "BufferID");

        Value* highestAccessedBytePtr = this->builder->CreateStructGEP(BufferNodeTy, currentNode, 1);
        Value* highestAccessedByte    = this->builder->CreateLoad(highestAccessedBytePtr, "HighestByte");

        Value* bufferAddressPtr = this->builder->CreateStructGEP(BufferNodeTy, currentNode, 2);
        Value* bufferAddress    = this->builder->CreateLoad(bufferAddressPtr, "BufferAddress");

        Value* bufferSizePtr = this->builder->CreateStructGEP(BufferNodeTy, currentNode, 3); 
        Value* bufferSize    = this->builder->CreateLoad(bufferSizePtr, "BufferSize");
       
        // TODO: Write node data to file
        /*
        std::string outputString = "Buffer address %p; Buffer size %d; ID %d; HAB %d\n";
        Value* formatString = this->builder->CreateGlobalStringPtr(outputString.c_str());
        Value* loadedFilePtr = this->builder->CreateLoad(globalFilePtr->getType()->getPointerElementType(), globalFilePtr);
        this->builder->CreateCall(fprintfFunc, { loadedFilePtr, formatString, bufferAddress, bufferSize, bufferID, highestAccessedByte });
        */

        // Move to next node
        Value *nextNodePtr = this->builder->CreateStructGEP(this->BufferNodeTy, currentNode, 4, "nextNodeAddr");
        Value *nextNode = this->builder->CreateLoad(nextNodePtr->getType()->getPointerElementType(), nextNodePtr, "nextNode");
        this->builder->CreateStore(nextNode, currentNodeAlloca);

        // Check if node is null (end of list)
        Value* isEnd = this->builder->CreateICmpEQ(nextNode, bufferNodeNullptr, "isEnd");
        this->builder->CreateCondBr(isEnd, exit, loopBody);

        // Create the exit basic block and return instruction
        this->builder->SetInsertPoint(exit);
        this->builder->CreateRetVoid();

        return writeBufferListToFileFunction;   
    }

    Function* CreatePrintBufferListFunction()
    {
        LLVMContext& context = this->module->getContext();

        // Get pointer type of BufferNode* using the default address space (0)
        PointerType* bufferNodePtrType = PointerType::get(BufferNodeTy, 0); 
        // Get nullptr of type BufferNotTy
        Constant* bufferNodeNullptr = ConstantPointerNull::get(bufferNodePtrType);

        // Create the printBufferList function
        FunctionType* printBufferListType = FunctionType::get(Type::getVoidTy(context), false);
        
        Function* printBufferList = Function::Create(   printBufferListType, 
                                                        Function::ExternalLinkage, 
                                                        "printBufferList", 
                                                        this->module);

        // Create the entry basic block
        BasicBlock *entry = BasicBlock::Create(context, "entry", printBufferList);
        // Create BasicBlocks for loop condition, loop body, and exit blocks
        BasicBlock* checkIfHeadIsNull = BasicBlock::Create(context, "checkIfHeadIsNull", printBufferList);
        BasicBlock* loopBody = BasicBlock::Create(context, "loopBody", printBufferList);
        BasicBlock* exit = BasicBlock::Create(context, "exit", printBufferList);

        builder->SetInsertPoint(entry);

        // Load BufferListHead
        GlobalVariable* bufferListHead = this->module->getNamedGlobal("BufferListHead");
        Value* head = this->builder->CreateLoad(bufferListHead->getType()->getPointerElementType(), bufferListHead, "head");

        // Create an alloca instruction to store the current node
        AllocaInst* currentNodeAlloca = builder->CreateAlloca(head->getType(), 0, "currentNode");
        builder->CreateStore(head, currentNodeAlloca);

        builder->CreateBr(checkIfHeadIsNull);

        builder->SetInsertPoint(checkIfHeadIsNull);

        Value* headIsNull = this->builder->CreateICmpEQ(head, bufferNodeNullptr, "isEnd");
        this->builder->CreateCondBr(headIsNull, exit, loopBody);

        this->builder->SetInsertPoint(loopBody);

        // Load the current node from memory
        Value* current = this->builder->CreateLoad(currentNodeAlloca->getType()->getPointerElementType(), currentNodeAlloca, "current");

        // Fetch the data from the buffer node
        Value *dataPtr = this->builder->CreateStructGEP(this->BufferNodeTy, current, 2, "dataPtr");
        Value *data = this->builder->CreateLoad(dataPtr->getType()->getPointerElementType(), dataPtr, "data");
        
        // Print buffer address
        std::string formatAddrString = "%p\n";
        Value* formatAddrStringGlobal = builder->CreateGlobalStringPtr(formatAddrString, "formatAddrString", 0, module);
        this->builder->CreateCall(printfFunction, {formatAddrStringGlobal, data});

        // Fetch the dataSize 
        Value *dataSizePtr = builder->CreateStructGEP(this->BufferNodeTy, current, 3, "dataSizePtr");
        Value *dataSize = builder->CreateLoad(dataSizePtr->getType()->getPointerElementType(), dataSizePtr, "dataSize");
        
        // print bufferSize
        std::string formatSizeString = "Size: %ld\n";
        Value* formatSizeStringGlobal = builder->CreateGlobalStringPtr(formatSizeString, "formatSizeString", 0, module);
        builder->CreateCall(printfFunction, {formatSizeStringGlobal, dataSize});

        // Move to next node
        Value *nextNodePtr = this->builder->CreateStructGEP(this->BufferNodeTy, current, 4, "nextNodeAddr");
        Value *nextNode = this->builder->CreateLoad(nextNodePtr->getType()->getPointerElementType(), nextNodePtr, "nextNode");

        // Store nextNode to access is it in the next iteration
        builder->CreateStore(nextNode, currentNodeAlloca);

        // Check if node is null (end of list)
        Value* isEnd = this->builder->CreateICmpEQ(nextNode, bufferNodeNullptr, "isEnd");
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

    void DetermineBaseTypeOfArray()
    {
        // TODO
    }

    bool IsStruct()
    {
        // TODO
        return false;
    }

    void FreeBufferList() 
    {
        // TODO
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
                    /*
                    std::string outputString = "Stack allocation of size: %d\n";
                    Value* formatString = this->builder->CreateGlobalStringPtr(outputString, "fileFormatString", 0, module);
                    // Load the file pointer from the global variable
                    Value *loadedFilePtr = this->builder->CreateLoad(globalFilePtr->getType()->getPointerElementType(), globalFilePtr);
                    this->builder->CreateCall(fprintfFunc, { loadedFilePtr, formatString, bufferSizeValue });

                    DEBUG_PRINT("Allocated array of size " << arraySize << " stored in linked list");
                    */
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
                        /*
                        std::string outputString = "Heap allocation of size: %d\n";
                        Value* formatString = builder->CreateGlobalStringPtr(outputString, "fileFormatString", 0, module);
                        // Load the file pointer from the global variable
                        Value *loadedFilePtr = builder->CreateLoad(globalFilePtr->getType()->getPointerElementType(), globalFilePtr);
                        builder->CreateCall(fprintfFunc, { loadedFilePtr, formatString, bufferSize });
                        */
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

                    // Cast the pointer to the buffer to a generic i8* pointer
                    if (basePtr->getType() != Type::getInt8PtrTy(context))
                    {
                        basePtr = builder->CreateBitCast(basePtr, Type::getInt8PtrTy(context));
                    }

                    // Get buffer with this base address from linked list
                    CallInst* buffer = builder->CreateCall(getBufferFunction, { basePtr });
                    // Get pointer type of BufferNode* using the default address space (0)
                    PointerType* bufferNodePtrType = PointerType::get(BufferNodeTy, 0); 
                    // Cast the return type of the getBufferFunction (CallInst) to BufferNode*
                    Value* bufferNode = builder->CreateBitCast(buffer, bufferNodePtrType, "BufferNodePtr");

                    // Update the highest accessed byte of the buffer node if the currently accessed byte is greater then
                    // the highest accessed byte of the buffer node
                    this->builder->CreateCall(setHighestAccessedByteFunction, { bufferNode, accessedBytes });

                    // Write BufferNode data to file
                    this->builder->CreateCall(writeToFileFunction, { bufferNode, accessedBytes });
                
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
