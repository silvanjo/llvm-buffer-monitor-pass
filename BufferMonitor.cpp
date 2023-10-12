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
#include <string>
#include <iostream>

using namespace llvm;

namespace 
{

// Node of a linked list used to store information about a dynamically allocated buffer
// The linked list is becomes instrumented into the transformed target program
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
    GlobalVariable* BufferListHead; 
    StructType* BufferNodeTy;

    BufferMonitor() : ModulePass(ID) { }

    virtual bool runOnModule(Module& M)
    {
        auto module = &M;

        // Get context, module and create IRBuilder for instrumentations
        LLVMContext &context = M.getContext();
        IRBuilder<> builder(context);

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

        // Iterate over all functions in the module
        for (auto& F : M)
        {
            // Process each function
            procesFunction(F);
        }

        return true;
    }

    bool procesFunction(Function& F)
    {
        std::cout << "Pass on " << F.getName().str() << std::endl;

        // map of buffer names to buffer sizes
        std::map<std::string, int> bufferMap;

        // Get context, module and create IRBuilder for instrumentations
        LLVMContext &context = F.getContext();
        auto module = F.getParent();
        IRBuilder<> builder(context);

        // Get main function
        Function* mainFunction = module->getFunction("main");
        if (!mainFunction) 
        {
            std::cout << "No main function found" << std::endl;
            return false;
        }

        // Open the file for writing in the beginning of the main function
        builder.SetInsertPoint(&mainFunction->getEntryBlock().front());
        
        // Get printf function
        std::vector<Type*> printfArgsTypes;
        printfArgsTypes.push_back(Type::getInt8PtrTy(context));
        FunctionType* printfFunctionType = FunctionType::get(builder.getInt32Ty(), printfArgsTypes, true);
        
        Function* printfFunction = module->getFunction("printf");
        if (!printfFunction) 
        {
            printfFunction = Function::Create(printfFunctionType, Function::ExternalLinkage, "printf", module);
        }

        // Get or insert fopen function for file IO
        FunctionType* FT = FunctionType::get(Type::getInt8PtrTy(context), { Type::getInt8PtrTy(context), Type::getInt8PtrTy(context) }, false);
        FunctionCallee fopenFuncCallee = module->getOrInsertFunction("fopen", FT);
        Function* fopenFunc = cast<Function>(fopenFuncCallee.getCallee());  

        // Get or insert the fprint function for file IO
        FunctionType* fprintfType = FunctionType::get(Type::getInt32Ty(context), { Type::getInt8PtrTy(context), Type::getInt8PtrTy(context) }, true);
        FunctionCallee fprintfFuncCallee = module->getOrInsertFunction("fprintf", fprintfType);
        Function* fprintfFunc = cast<Function>(fprintfFuncCallee.getCallee());

        // Open the file for writing in the beginning of the main function
        Value* filename = builder.CreateGlobalStringPtr("output.txt");
        Value* mode = builder.CreateGlobalStringPtr("w");
        Value* file_ptr = builder.CreateCall(fopenFunc, {filename, mode});

        // Get or insert the malloc function
        Function* mallocFunc = module->getFunction("malloc");
        if (!mallocFunc) 
        {
            std::vector<Type*> mallocArgTypes;
            mallocArgTypes.push_back(Type::getInt64Ty(context));
            FunctionType* mallocFuncType = FunctionType::get(Type::getInt8PtrTy(context), mallocArgTypes, false);
            mallocFunc = Function::Create(mallocFuncType, Function::ExternalLinkage, "malloc", module);
        }

        // Get data layout of the module to exactly determine the size of the BufferNode struct
        const DataLayout &DL = module->getDataLayout();

        auto I = inst_begin(F);
        auto nextInstruction = I;
        while (I != inst_end(F))
        {
            nextInstruction++;

            // Check if the current instruction is an alloca instruction
            if (AllocaInst* allocaInst = dyn_cast<AllocaInst>(&*I))
            {

                // This is an alloca instruction, a buffer is being allocated here

                std::string bufferName = allocaInst->getName().str();   // get buffer name

                if (ArrayType* arrayType = dyn_cast<ArrayType>(allocaInst->getAllocatedType()))
                {
                    // This is an array allocation
                    unsigned bufferSizeValue = arrayType->getNumElements(); // get buffer size as number of elements in the array

                    bufferMap[bufferName] = bufferSizeValue;               // add buffer to buffer map

                    std::cout << "Found Buffer [Name= " << bufferName << "] of size: " << bufferSizeValue << std::endl;
                }
                
            }
            
            if (auto callInst = dyn_cast<CallInst>(&*I)) 
            {
                // This is an call instruction

                std::cout << "Call instruction detected" << std::endl;

                Function *calledFunc = callInst->getCalledFunction();

                if (calledFunc) 
                {
                    StringRef funcName = calledFunc->getName();
                    if (funcName == "malloc" || funcName.startswith("_Znwm") || funcName.startswith("_Znam"))
                    {
                        // This is a heap allocation
                        
                        std::cout << "Found a heap allocation" << std::endl;

                        // get buffer name
                        std::string dynBufferName = callInst->getName().str();   

                        // Set insert point behind the current instruction
                        builder.SetInsertPoint(I->getNextNode());

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
                        Value* newNode = builder.CreateCall(mallocFunc, sizeofBufferNode);

                        // Cast the return value of malloc to BufferNodeTy
                        newNode = builder.CreateBitCast(newNode, PointerType::getUnqual(BufferNodeTy));

                        builder.CreateStore(bufferAddress, builder.CreateStructGEP(BufferNodeTy, newNode, 0));  // Store address
                        builder.CreateStore(bufferSize, builder.CreateStructGEP(BufferNodeTy, newNode, 1));     // Store size
                        builder.CreateStore(nullPtr, builder.CreateStructGEP(BufferNodeTy, newNode, 2));        // Set next to nullptr

                        // Insert the new node at the beginning of the linked list
                        Value* currentHead = builder.CreateLoad(BufferListHead->getType()->getPointerElementType(), BufferListHead, "currentHead");
                        builder.CreateStore(newNode, BufferListHead);                                           // Update the head of the list to point to the new node
                        builder.CreateStore(currentHead, builder.CreateStructGEP(BufferNodeTy, newNode, 2));    // Set next of the new node to previous head

                        // add buffer to buffer map
                        bufferMap[dynBufferName] = -1;               

                        // Create output string for the file
                        std::string outputString = "Heap allocation of size: %d\n";

                        // Write size of dynamicallly allocated array to file
                        Value* formatString = builder.CreateGlobalStringPtr(outputString, "fileFormatString", 0, module);
                        
                        // Call fprintf to write the size of the dynamically allocated array to the file
                        builder.CreateCall(fprintfFunc, { file_ptr, formatString, bufferSize });
                    }
                }
            }
            
            if (GetElementPtrInst* gepInst = dyn_cast<GetElementPtrInst>(&*I)) 
            {
                // This is a getelementptr instruction, a buffer is being accessed here

                Value* basePtr = gepInst->getPointerOperand();         // get base pointer
                
                std::cout << "GetElementPtr detected" << std::endl;
                
                std::string bufferName = basePtr->getName().str();     // get buffer name
                
                if (bufferMap.find(bufferName) == bufferMap.end())
                    continue;

                for (auto it = gepInst->idx_begin(); it != gepInst->idx_end(); it++) 
                {
                   Value* indexValue = it->get();
                
                    if (indexValue->getType()->isIntegerTy())
                    {
                        // Create output string for the file
                        std::string outputString = "Buffer access: %d (static)\n";
                        // Write the accessed index to the file
                        Value* formatString = builder.CreateGlobalStringPtr("Buffer access: %d\n");
                        // Value* formatString = builder.CreateGlobalStringPtr("Index access\n");

                        builder.SetInsertPoint(&*I);
                        builder.CreateCall(fprintfFunc, { file_ptr, formatString, indexValue });
                    } else 
                    {
                        std::cout << "Cannot read getelementptr instruction. Index wrong format." << std::endl;
                    }
                }
            } 

            I = nextInstruction;
        }

        // If the currently processed function is the main function close the file
        if (F.getName() == "main") 
        {
            std::cout << "Currently processing main function." << std::endl;
            std::cout << "Closing file." << std::endl;

            std::vector<Type*> fcloseArgs;
            fcloseArgs.push_back(PointerType::getUnqual(Type::getInt8Ty(context))); // FILE* argument
            FunctionType* fcloseType = FunctionType::get(Type::getInt32Ty(context), fcloseArgs, false); 
            FunctionCallee fcloseFunc = module->getOrInsertFunction("fclose", fcloseType);
            BasicBlock &LastBlock = F.back();   // Set insert point to last block of function
            builder.SetInsertPoint(LastBlock.getTerminator());
            builder.CreateCall(fcloseFunc, {file_ptr});
        }

        // Print each detected static buffer
        for (const auto& buffer : bufferMap)
        {
            std::cout << "Buffer: " << buffer.first << ", Size: " << buffer.second << std::endl;
        }

        return true;
    }
};

} // namespace

char BufferMonitor::ID = 0;
static RegisterPass<BufferMonitor> X("buffer_monitor", "Monitors buffer accesses");

