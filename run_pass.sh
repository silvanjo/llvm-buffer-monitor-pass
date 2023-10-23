#!/bin/bash

# Check if input is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <source file (C++)>"
    exit 1
fi

INPUT_FILE="$1"
BASE_NAME=$(basename "$INPUT_FILE" .cpp)
OUTPUT_BITCODE_FILE="original_program.bc"
OUTPUT_TRANSFORMED_BITCODE_FILE="transformed_program.bc"

# Step 1: Compile BufferMonitor.cpp pass to shared library
clang++ -DDEBUG -shared -o ./shared/BufferMonitor.so `llvm-config --cxxflags` ./BufferMonitor.cpp `llvm-config --ldflags` -fPIC -lLLVM

# Step 2: Compile target program to llvm bitcode file 
clang++ -emit-llvm -fPIE -c "$INPUT_FILE" -o ./programs/output/"${OUTPUT_BITCODE_FILE}"

# Step 3: Run the pass using opt
opt -enable-new-pm=0 -load ./shared/BufferMonitor.so -buffer_monitor -o "./programs/output/${OUTPUT_TRANSFORMED_BITCODE_FILE}" < ./programs/output/"$OUTPUT_BITCODE_FILE"

# TODO: Generating executable from transformed bitcode file does not work currently

# Step 4: Transform LLVM bitcode to native machine code
# llc -filetype=obj ./programs/output/${OUTPUT_TRANSFORMED_BITCODE_FILE} -o ./programs/output/${BASE_NAME}.o

# Step 5: Link the object file to produce an executable
# clang++ -pie ./programs/output/${BASE_NAME}.o -o ./programs/output/${BASE_NAME}

