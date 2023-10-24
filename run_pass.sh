#!/bin/bash

# Define paths and filenames as constants
SHARED_DIR="./shared"
PROGRAMS_OUTPUT_DIR="./programs/output"
BUFFER_MONITOR_SOURCE="./BufferMonitor.cpp"
OUTPUT_BITCODE_FILE="original_program.bc"
OUTPUT_TRANSFORMED_BITCODE_FILE="transformed_program.bc"

# Default DEBUG flag is not set
DEBUG_FLAG=""

# Check for -DDEBUG in arguments
for arg in "$@"; do
    if [ "$arg" == "-DDEBUG" ]; then
        DEBUG_FLAG="-DDEBUG"
        break
    fi
done

# Check if input is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 [-DDEBUG] <source file (C++)>"
    exit 1
fi

INPUT_FILE="${!#}"
BASE_NAME=$(basename "$INPUT_FILE" .cpp)

# Step 1: Compile BufferMonitor.cpp pass to shared library
clang++ $DEBUG_FLAG -shared -o "$SHARED_DIR/BufferMonitor.so" $(llvm-config --cxxflags) "$BUFFER_MONITOR_SOURCE" $(llvm-config --ldflags) -fPIC -lLLVM
if [ $? -ne 0 ]; then
    echo "Error compiling BufferMonitor.cpp"
    exit 2
fi

# Step 2: Compile target program to llvm bitcode file 
clang++ -emit-llvm -fPIE -c "$INPUT_FILE" -o "$PROGRAMS_OUTPUT_DIR/$OUTPUT_BITCODE_FILE"
if [ $? -ne 0 ]; then
    echo "Error compiling target program to llvm bitcode"
    exit 3
fi

# Step 3: Run the pass using opt
opt -enable-new-pm=0 -load "$SHARED_DIR/BufferMonitor.so" -buffer_monitor -o "$PROGRAMS_OUTPUT_DIR/$OUTPUT_TRANSFORMED_BITCODE_FILE" < "$PROGRAMS_OUTPUT_DIR/$OUTPUT_BITCODE_FILE"
if [ $? -ne 0 ]; then
    echo "Error running the LLVM pass"
    exit 4
fi
