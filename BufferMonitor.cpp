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

struct BufferMonitor : public FunctionPass
{
    static char ID;

    BufferMonitor() : FunctionPass(ID) { }

    virtual bool runOnFunction(Function& F)
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

        // If the currently processed function is the main function open a file to write to
        if (F.getName() == "main") 
        {
            std::cout << "Currently processing main function." << std::endl;
        }

        // Open the file for writing in the beginning of the main function
        Value* filename = builder.CreateGlobalStringPtr("output.txt");
        Value* mode = builder.CreateGlobalStringPtr("w");
        Value* file_ptr = builder.CreateCall(fopenFunc, {filename, mode});

        // Iterate over all instructions in the function

        for (inst_iterator I = inst_begin(F), E = inst_end(F); I != E; ++I) 
        {

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

                        // add buffer to buffer map
                        bufferMap[dynBufferName] = -1;               

                        // get size of allocation
                        Value* mallocSize = callInst->getArgOperand(0);    

                        // Create output string for the file
                        std::string outputString = "Heap allocation of size: %d\n";

                        // Write size of dynamicallly allocated array to file
                        Value* formatString = builder.CreateGlobalStringPtr(outputString, "fileFormatString", 0, module);
                        
                        // Call fprintf to write the size of the dynamically allocated array to the file
                        builder.CreateCall(fprintfFunc, { file_ptr, formatString, mallocSize });
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

        }

        // Close file using fclose function
        /*std::vector<Type*> fcloseArgs;
        fcloseArgs.push_back(PointerType::getUnqual(Type::getInt8Ty(context))); // FILE* argument
        FunctionType* fcloseType = FunctionType::get(Type::getInt32Ty(context), fcloseArgs, false); 
        FunctionCallee fcloseFunc = module->getOrInsertFunction("fclose", fcloseType);
        builder.CreateCall(fcloseFunc, {file_ptr});*/

        // Print each detected buffer and its size

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

