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


#include <map>
#include <set>
#include <string>
#include <iostream>

using namespace llvm;

namespace 
{

// Node of a linked list used to store information about allocated buffer (static and dynamic)
// The linked list becomes instrumented into the transformed target program
// to have access to the buffer sizes at runtime
struct BufferNode 
{
    void* bufferAddr;           // Address of the allocated buffer
    size_t bufferSize;          // Size of the buffer

    struct BufferNode* next;    // Pointer to the next node
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

    // Custom functions
    Function* printBufferListFunction;
    Function* getBufferSizeFunction;

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
        BufferNodeFields.push_back(PointerType::get(Type::getInt8Ty(context), 0)); // bufferAddr
        BufferNodeFields.push_back(Type::getInt64Ty(context)); // bufferSize
        BufferNodeFields.push_back(PointerType::get(BufferNodeTy, 0)); // next pointer set to NULL
        
        // Set the fields for BufferNodeTy
        BufferNodeTy->setBody(BufferNodeFields);
        
        // Get the global variable BufferListHead
        // Create it if it does not exist
        this->BufferListHead = module->getGlobalVariable("BufferListHead");
        if (!this->BufferListHead) 
        {
            std::cout << "Create BufferList." << std::endl;

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
            std::cout << "No main function found" << std::endl;
            return false;
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
            llvm::errs() << "getBufferSizeFunction Function verification failed after transformations!\n";
            this->getBufferSizeFunction->dump();
        }

        // Create the printBufferList function
        this->printBufferListFunction = CreatePrintBufferListFunction();

        // Check if function is correct after transformations
        if (verifyFunction(*this->printBufferListFunction, &llvm::errs())) 
        {
            llvm::errs() << "printBufferListFunction Function verification failed after transformations!\n";
            this->printBufferListFunction->dump();
        }

        skipFunctions.insert(this->getBufferSizeFunction);
        skipFunctions.insert(this->printBufferListFunction);

        return true;
    }

    Function* CreateBufferSizeFunction()
    {
        LLVMContext& context = this->module->getContext();

        // Define the function signature
        // Function type: i64(i8*)
        FunctionType* functionType = FunctionType::get(Type::getInt64Ty(context), 
                                                Type::getInt8PtrTy(context), 
                                                false);

        // Create the function
        Function* getBufferSizeFunction = Function::Create(functionType, 
                                                    Function::ExternalLinkage, 
                                                    "getBufferSize", 
                                                    module);

        // Set function argument name
        getBufferSizeFunction->arg_begin()->setName("bufferAddress");

        // 2. Define the function body
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

        Value* nodeDataAddr = this->builder->CreateStructGEP(BufferNodeTy, current, 0, "nodeDataAddr");
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
        Value* dataSizeAddr = this->builder->CreateStructGEP(BufferNodeTy, current, 1, "dataSizeAddr");
        Value* dataSize = this->builder->CreateLoad(dataSizeAddr->getType()->getPointerElementType(), dataSizeAddr, "dataSize");
        this->builder->CreateRet(dataSize);

        // Move to next node
        this->builder->SetInsertPoint(nextIteration);
        Value* nextNodeAddr = this->builder->CreateStructGEP(BufferNodeTy, current, 2, "nextNodeAddr");
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

    Function* CreatePrintBufferListFunction()
    {
        LLVMContext& context = this->module->getContext();

        // Create the printBufferList function
        FunctionType* printBufferListType = FunctionType::get(Type::getVoidTy(context), false);
        Function* printBufferList = Function::Create(printBufferListType, Function::ExternalLinkage, "printBufferList", module);

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
        Value *dataPtr = builder->CreateStructGEP(this->BufferNodeTy, current, 0, "dataPtr");
        Value *data = builder->CreateLoad(dataPtr->getType()->getPointerElementType(), dataPtr, "data");
        
        // Print buffer address
        std::string formatAddrString = "%p\n";
        Value* formatAddrStringGlobal = builder->CreateGlobalStringPtr(formatAddrString, "formatAddrString", 0, module);
        builder->CreateCall(printfFunction, {formatAddrStringGlobal, data});

        // Fetch the dataSize 
        Value *dataSizePtr = builder->CreateStructGEP(this->BufferNodeTy, current, 1, "dataSizePtr");
        Value *dataSize = builder->CreateLoad(dataSizePtr->getType()->getPointerElementType(), dataSizePtr, "dataSize");
        
        // print bufferSize
        std::string formatSizeString = "Size: %ld\n";
        Value* formatSizeStringGlobal = builder->CreateGlobalStringPtr(formatSizeString, "formatSizeString", 0, module);
        builder->CreateCall(printfFunction, {formatSizeStringGlobal, dataSize});

        // Move to next node
        Value *nextNodeAddr = this->builder->CreateStructGEP(this->BufferNodeTy, current, 2, "nextNodeAddr");
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

        // Get data layout of the module to exactly determine the size of the BufferNode struct
        const DataLayout& DL = module->getDataLayout();

        // Get mull pointer of type BufferNodeTy
        Value* nullPtr = ConstantPointerNull::get(PointerType::get(BufferNodeTy, 0));       

        // Determine size of BufferNode struct for malloc instruction
        uint64_t size = DL.getTypeAllocSize(BufferNodeTy);
        ConstantInt* sizeofBufferNode = ConstantInt::get(Type::getInt64Ty(context), size);

        // Create malloc call to create new BufferNode storing address and size of a dynamically allocated buffer
        Value* newNode = builder->CreateCall(mallocFunc, sizeofBufferNode);

        // Cast the return value of malloc to BufferNodeTy
        newNode = builder->CreateBitCast(newNode, PointerType::getUnqual(BufferNodeTy));

        // INitialize the new node
        builder->CreateStore(bufferAddress, builder->CreateStructGEP(BufferNodeTy, newNode, 0));  // Store address
        builder->CreateStore(bufferSize, builder->CreateStructGEP(BufferNodeTy, newNode, 1));     // Store size
        builder->CreateStore(nullPtr, builder->CreateStructGEP(BufferNodeTy, newNode, 2));        // Set next to nullptr

        // Insert the new node at the beginning of the linked list
        Value* currentHead = builder->CreateLoad(BufferListHead->getType()->getPointerElementType(), BufferListHead, "currentHead");
        builder->CreateStore(newNode, BufferListHead);                                           // Update the head of the list to point to the new node
        builder->CreateStore(currentHead, builder->CreateStructGEP(BufferNodeTy, newNode, 2));    // Set next of the new node to previous head           
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



    virtual bool runOnModule(Module& M)
    {
        init(M);

        LLVMContext& context = M.getContext();

        this->builder->SetInsertPoint(&mainFunction->getEntryBlock().front());

        // Get buffers that are allocated globally and store them in the linked list
        /*
        for (auto& global : M.globals()) 
        {
            errs() << "Working on global: " << global.getName() << "\n";

            GlobalVariable* globalVariable = &global;

            // Check if the global variable is an array
            if (ArrayType* arrayType = dyn_cast<ArrayType>(globalVariable->getValueType())) 
            {
                errs() << "Global is a buffer: " << global.getName() << "\n";

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
        */

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

        // Print the linked list containing all buffers
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
        std::cout << "Pass on function: " << F.getName().str() << std::endl;

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
                    std::cout << "Found a static allocation" << std::endl;

                    // Determine the size of the array
                    unsigned arraySize = arrayType->getNumElements();
                    
                    // Convert arraySize to LLVM Value* for inserting into the linked list
                    Value* bufferSizeValue = ConstantInt::get(Type::getInt64Ty(context), arraySize);

                    // Set insert point after current instruction
                    this->builder->SetInsertPoint(I->getNextNode());

                    // Skip to next instruction
                    nextInstruction++;

                    // Cast the pointer to the buffer to a generic i8* pointer
                    Value* bufferAddress = allocaInst;
                    if (allocaInst->getType() != Type::getInt8PtrTy(context)) 
                    {
                        bufferAddress = builder->CreateBitCast(allocaInst, Type::getInt8PtrTy(context));
                    }
                    
                    InsertBufferToList(bufferAddress, bufferSizeValue);

                    // Write size of dynamicallly allocated array to file
                    std::string outputString = "Stack allocation of size: %d\n";
                    Value* formatString = this->builder->CreateGlobalStringPtr(outputString, "fileFormatString", 0, module);
                    // Load the file pointer from the global variable
                    Value *loadedFilePtr = builder->CreateLoad(globalFilePtr->getType()->getPointerElementType(), globalFilePtr);
                    this->builder->CreateCall(fprintfFunc, { loadedFilePtr, formatString, bufferSizeValue });

                    std::cout << "Allocated array of size " << arraySize << " stored in linked list" << std::endl;
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
                        std::cout << "Found a heap allocation" << std::endl;

                        // get buffer name
                        std::string dynBufferName = callInst->getName().str();   

                        // Set insert point behind the current instruction
                        builder->SetInsertPoint(I->getNextNode());

                        // Skip to next instruction
                        nextInstruction++;

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
                std::cout << "GetElementPtr detected" << std::endl;

                // Get base pointer of the buffer
                Value* basePtr = gepInst->getPointerOperand();
                
                // Get buffer name
                std::string bufferName = basePtr->getName().str();     

                builder->SetInsertPoint(&*I);
                
                for (auto it = gepInst->idx_begin(); it != gepInst->idx_end(); it++) 
                {
                    Value* indexValue = it->get();

                    // Get size of buffer
                    // For Static Buffers we get the size from the bufferMap
                    // For Dynamic Buffers we get the size from the linked list
                    Value* bufferSize = nullptr;
                    std::string outputString = "Buffer access: %d of size: %d";

                    // Check if the base pointer is a static buffer or a dynamic buffer or a global buffer
                    // Temporary: Skip globally defined bufers
                    if (GlobalVariable* globalVariable = dyn_cast<GlobalVariable>(basePtr))
                    {
                        // GEP is performed on a global variable
                        errs() << "GEP on global variable: " << globalVariable->getName() << "\n";
                        outputString += " (global)\n";
                    }
                    else if (AllocaInst* allocaInst = dyn_cast<AllocaInst>(basePtr))
                    {

                        // Check if accessed array is a multi-dimensional array
                        if(IsMultiDimensionalArray(gepInst))
                        {
                            outputString += " (static and multidimensional)\n";
                        }
                        else 
                        {
                            outputString += " (static)\n";
                        }

                    } 
                    else 
                    {
                        outputString += " (dynamic)\n";
                    }

                    // Cast the pointer to the buffer to a generic i8* pointer
                    if (basePtr->getType() != Type::getInt8PtrTy(context)) 
                    {
                        basePtr = builder->CreateBitCast(basePtr, Type::getInt8PtrTy(context));
                    }

                    // Get the size of the buffer stored in the linked list
                    bufferSize = builder->CreateCall(getBufferSizeFunction, { basePtr });

                
                    if (indexValue->getType()->isIntegerTy())
                    {
                        // Create output string for the file
                        Value* formatString = builder->CreateGlobalStringPtr(outputString.c_str());
                        Value *loadedFilePtr = builder->CreateLoad(globalFilePtr->getType()->getPointerElementType(), globalFilePtr);
                        builder->CreateCall(fprintfFunc, { loadedFilePtr, formatString, indexValue, bufferSize });
                    } else 
                    {
                        std::cout << "Cannot read getelementptr instruction. Index wrong format." << std::endl;
                    }
                }

            } 

            I = nextInstruction;
        }

        return true;
    }
};

} // namespace

char BufferMonitor::ID = 0;
static RegisterPass<BufferMonitor> X("buffer_monitor", "Monitors buffer accesses");

