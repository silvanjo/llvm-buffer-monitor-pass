#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
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

// Node of a linked list used to store information about a dynamically allocated buffer
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
    Function* getBufferSizeFunction;

    Value* mode;
    Value* filename;
    Value* file_ptr;

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
        BufferListHead = module->getGlobalVariable("BufferListHead");
        if (!BufferListHead) 
        {
            std::cout << "Create BufferList." << std::endl;

            // Create the head of the linked list
            BufferListHead = new GlobalVariable(
                *module,                                                        // Module
                PointerType::get(BufferNodeTy, 0),                              // Type
                false,                                                          // isConstant
                GlobalVariable::PrivateLinkage,                                 // Use private linkage
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

        skipFunctions.insert(this->getBufferSizeFunction);

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

        // TODO: Traverse the BufferList linked list and compare each node's
        // buffer address to bufferAddress. If a match is found, set the size
        // of the buffer to a variable.

        // Load BufferListHead
        GlobalVariable* bufferListHead = this->module->getNamedGlobal("BufferListHead");
        Value* current = this->builder->CreateLoad(bufferListHead->getType()->getPointerElementType(), bufferListHead, "current");

        // TODO: Check if bufferLIstHead is null
        // -------------------------------------

        // Create loop condition, loop body, and exit blocks
        BasicBlock* loopCond = BasicBlock::Create(context, "loopCond", getBufferSizeFunction);
        BasicBlock* loopBody = BasicBlock::Create(context, "loopBody", getBufferSizeFunction);
        BasicBlock* exitBlock = BasicBlock::Create(context, "exit", getBufferSizeFunction);

        this->builder->CreateBr(loopCond);
        this->builder->SetInsertPoint(loopCond);

        // Loop condition: check if current node is null
        Value* isEnd = this->builder->CreateIsNull(current, "isEnd");
        this->builder->CreateCondBr(isEnd, exitBlock, loopBody);

        // Loop body: Check buffer address and traverse the list
        this->builder->SetInsertPoint(loopBody);
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
        this->builder->CreateBr(loopCond);
        
        // Exit block: If buffer not found, return -1
        this->builder->SetInsertPoint(exitBlock);
        Value* notFoundValue = ConstantInt::get(Type::getInt64Ty(context), -1, true);
        this->builder->CreateRet(notFoundValue);

        return getBufferSizeFunction;
    }

    virtual bool runOnModule(Module& M)
    {
        init(M);

        LLVMContext& context = M.getContext();

        // Iterate over all functions in the module
        for (auto& F : M)
        {
            // Functions to be skipped
            if (skipFunctions.find(&F) != skipFunctions.end())
                continue;

            // Process each function
            procesFunction(F);
        }

        // Close file
        std::vector<Type*> fcloseArgs;
        fcloseArgs.push_back(PointerType::getUnqual(Type::getInt8Ty(context))); // FILE* argument
        FunctionType* fcloseType = FunctionType::get(Type::getInt32Ty(context), fcloseArgs, false); 
        FunctionCallee fcloseFunc = module->getOrInsertFunction("fclose", fcloseType);
        BasicBlock &LastBlock = mainFunction->back();   // Set insert point to last block of function
        builder->SetInsertPoint(LastBlock.getTerminator());
        builder->CreateCall(fcloseFunc, {file_ptr});

        return true;
    }

    bool procesFunction(Function& F)
    {
        std::cout << "Pass on " << F.getName().str() << std::endl;

        LLVMContext& context = F.getContext();

        // Get data layout of the module to exactly determine the size of the BufferNode struct
        const DataLayout& DL = module->getDataLayout();

        auto I = inst_begin(F);
        auto nextInstruction = I;
        while (I != inst_end(F))
        {
            nextInstruction++;

            // Check if the current instruction is an alloca instruction
            if (AllocaInst* allocaInst = dyn_cast<AllocaInst>(&*I))
            {

                // TODO: Insert statically allocated buffer to linked list              
                
            }
            
            if (auto callInst = dyn_cast<CallInst>(&*I)) 
            {
                // This is an call instruction

                std::cout << "Call instruction detected" << std::endl;

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

                        // Determine size of BufferNode struct for malloc instruction
                        uint64_t size = DL.getTypeAllocSize(BufferNodeTy);
                        ConstantInt* sizeofBufferNode = ConstantInt::get(Type::getInt64Ty(context), size);

                        // Initialize the new Node
                        Value* bufferAddress = callInst;                                                    // get address of allocated buffer
                        Value* bufferSize = callInst->getArgOperand(0);                                     // get size of allocated buffer
                        Value* nullPtr = ConstantPointerNull::get(PointerType::get(BufferNodeTy, 0));       // set next node to NULL

                        // Create malloc call to create new BufferNode storing address and size of a dynamically allocated buffer
                        Value* newNode = builder->CreateCall(mallocFunc, sizeofBufferNode);

                        // Cast the return value of malloc to BufferNodeTy
                        newNode = builder->CreateBitCast(newNode, PointerType::getUnqual(BufferNodeTy));

                        builder->CreateStore(bufferAddress, builder->CreateStructGEP(BufferNodeTy, newNode, 0));  // Store address
                        builder->CreateStore(bufferSize, builder->CreateStructGEP(BufferNodeTy, newNode, 1));     // Store size
                        builder->CreateStore(nullPtr, builder->CreateStructGEP(BufferNodeTy, newNode, 2));        // Set next to nullptr

                        // Insert the new node at the beginning of the linked list
                        Value* currentHead = builder->CreateLoad(BufferListHead->getType()->getPointerElementType(), BufferListHead, "currentHead");
                        builder->CreateStore(newNode, BufferListHead);                                           // Update the head of the list to point to the new node
                        builder->CreateStore(currentHead, builder->CreateStructGEP(BufferNodeTy, newNode, 2));    // Set next of the new node to previous head           

                        // Create output string for the file
                        std::string outputString = "Heap allocation of size: %d\n";

                        // Write size of dynamicallly allocated array to file
                        Value* formatString = builder->CreateGlobalStringPtr(outputString, "fileFormatString", 0, module);
                        
                        // Call fprintf to write the size of the dynamically allocated array to the file
                        builder->CreateCall(fprintfFunc, { file_ptr, formatString, bufferSize });
                    }
                }
            }
            
            if (GetElementPtrInst* gepInst = dyn_cast<GetElementPtrInst>(&*I)) 
            {
                // This is a getelementptr instruction, a buffer is being accessed here
                std::cout << "GetElementPtr detected" << std::endl;

                Value* basePtr = gepInst->getPointerOperand();         // get base 
                
                std::string bufferName = basePtr->getName().str();     // get buffer name

                builder->SetInsertPoint(&*I);
                
                for (auto it = gepInst->idx_begin(); it != gepInst->idx_end(); it++) 
                {
                    Value* indexValue = it->get();

                    // Get size of buffer
                    // For Static Buffers we get the size from the bufferMap
                    // For Dynamic Buffers we get the size from the linked list
                    Value* bufferSize = nullptr;
                    std::string outputString = "Buffer access '" + bufferName + "': %d of size: %d";
                    if (AllocaInst* allocaInst = dyn_cast<AllocaInst>(basePtr))
                    {
                        // Static buffer being accessed
                        std::cout << "Static buffer access" << std::endl;

                        int sizeInt = -1;

                        // Convert integer to LLVM Value*
                        bufferSize = llvm::ConstantInt::get(builder->getInt32Ty(), sizeInt);

                        outputString += " (static)\n";
                    } else 
                    {
                        // Dynamic buffer being accessed
                        std::cout << "Dynamic buffer access" << std::endl;

                        // Cast the pointer to the buffer to a generic i8* pointer
                        if (basePtr->getType() != Type::getInt8PtrTy(context)) 
                        {
                            basePtr = builder->CreateBitCast(basePtr, Type::getInt8PtrTy(context));
                        }

                        // Get the size of the buffer stored in the linked list
                        bufferSize = builder->CreateCall(getBufferSizeFunction, { basePtr });
                    
                        outputString += " (dynamic)\n";
                    }

                
                    if (indexValue->getType()->isIntegerTy())
                    {
                        // Create output string for the file
                        Value* formatString = builder->CreateGlobalStringPtr(outputString.c_str());
                        builder->CreateCall(fprintfFunc, { file_ptr, formatString, indexValue, bufferSize });
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

