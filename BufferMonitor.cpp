#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Verifier.h"
#include "llvm/IR/Constant.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

#include <string>
#include <cstdint>
#include <iostream>

// Contains declaration of buffer_node_t
#include "BufferNode.h"

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

struct BufferMonitor : public ModulePass
{
    static char ID;

    Module* module;
    std::unique_ptr<IRBuilder<>> builder;

    // Buffer node list for storing data about all buffers found in 
    // the target program
    GlobalVariable* bufferNodeList;

    // Functions from BufferMonitorLib.c used by the instrumentation
    Function* insertBufferNodeFunction;
    Function* updateHighestAccessedByteFunction;

    BufferMonitor() : ModulePass(ID)
    {
        
    }

    Function* GetOrCreateFunction(const std::string& name, Module& module, LLVMContext& context, FunctionType* functionType) 
    {
        Function* function = module.getFunction(name);

        if (!function) 
            function = Function::Create(functionType, Function::ExternalLinkage, name, &module);
        
        return function;
    }

    bool init(Module& M) 
    {
        std::cout << "Initialize BufferMonitor pass ..." << std::endl;

        this->module = &M;

        // Get context, module and create IRBuilder for instrumentations
        LLVMContext& context = M.getContext();
        builder = std::make_unique<IRBuilder<>>(context);

        // Get head of buffer node list
        this->bufferNodeList = new GlobalVariable(*module, PointerType::get(IntegerType::getInt8Ty(context), 0), false,
                                                                            GlobalValue::ExternalLinkage, 0, "__buffer_node_list_");

        /*
            Get all functions used by the instrumentation from BufferMonitorLib.c
        */
    
        FunctionType* insertBufferNodeFunctionType = FunctionType::get(Type::getVoidTy(context), { Type::getInt8PtrTy(context), Type::getInt64Ty(context) }, false);
        this->insertBufferNodeFunction = GetOrCreateFunction("insert_buffer_node", *module, context, insertBufferNodeFunctionType);

        FunctionType* updateHighestAccessedByteType = FunctionType::get(Type::getVoidTy(context), { Type::getInt8PtrTy(context), Type::getInt64Ty(context) }, false);
        this->updateHighestAccessedByteFunction = GetOrCreateFunction("update_highest_accessed_byte", *module, context, updateHighestAccessedByteType);

        return true;
    }

    virtual bool runOnModule(Module& M)
    {
        DEBUG_PRINT_INFO("Run pass in debug mode");

        init(M);

        LLVMContext& context = M.getContext();

        // Iterate over all functions in the module
        for (auto& F : M)
        {
            // Process each function of the module
            procesFunction(F);
        }

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
                /*
                    This is an static allocation
                */

                // Check if the allocated type is an array
                if (ArrayType* arrayType = dyn_cast<ArrayType>(allocaInst->getAllocatedType()))
                {
                    // Determine the size of the array in bytes
                    unsigned arraySize = arrayType->getNumElements();
                    unsigned elementSizeInBytes = arrayType->getElementType()->getPrimitiveSizeInBits() / 8;
                    unsigned arraySizeInBytes = arraySize * elementSizeInBytes;
                    
                    // Convert arraySize to LLVM Value* for inserting into the linked list
                    Value* bufferSizeValue = ConstantInt::get(Type::getInt64Ty(context), arraySizeInBytes);

                    // Set insert point after current instruction
                    this->builder->SetInsertPoint(I->getNextNode());

                    // Cast the pointer to the buffer to a generic i8* pointer
                    Value* bufferAddress = allocaInst;
                    if (allocaInst->getType() != Type::getInt8PtrTy(context)) 
                    {
                        bufferAddress = builder->CreateBitCast(allocaInst, Type::getInt8PtrTy(context));
                    }
                    
                    // Store statically allocated buffer in linked list
                    this->builder->CreateCall(insertBufferNodeFunction, { bufferAddress, bufferSizeValue });
                }    
            }
            
            if (auto callInst = dyn_cast<CallInst>(&*I)) 
            {
                /*
                    This is an call instruction
                */

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

                        Value* bufferAddress = callInst;                    // get address of allocated buffer
                        Value* bufferSizeValue = callInst->getArgOperand(0);     // get size of allocated buffer

                        // Store dynamically allocated buffer in linked list
                        this->builder->CreateCall(insertBufferNodeFunction, { bufferAddress, bufferSizeValue });
                    }
                }
            }
            
            if (GetElementPtrInst* gepInst = dyn_cast<GetElementPtrInst>(&*I)) 
            {
                /*
                    This is a getelementptr instruction, a buffer is being accessed here
                */

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
                        // baseType->dump();
                        // errs() << "\n"; 
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
                
                int iteration = 0;
                for (auto it = gepInst->idx_begin(); it != gepInst->idx_end(); it++, iteration++) 
                {
                    // Determine accessed byte
                    Value* indexValue = it->get();
                    Value* accessedByte = builder->CreateMul(indexValue, ConstantInt::get(Type::getInt64Ty(context), elementSizeInBytes));

                    // Cast the pointer to the buffer to a generic i8* pointer
                    if (basePtr->getType() != Type::getInt8PtrTy(context))
                    {
                        basePtr = builder->CreateBitCast(basePtr, Type::getInt8PtrTy(context));
                    }

                    // Update the highest accessed byte of the currentl acessed buffer if accessedByte > highest_accessed_byte
                    this->builder->CreateCall(updateHighestAccessedByteFunction, { basePtr, accessedByte });
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