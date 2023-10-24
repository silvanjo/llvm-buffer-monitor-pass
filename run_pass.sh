#!/bin/bash

SHARED_DIR="./shared"
LINKED_BITCODE="linked_program.bc"
PROGRAMS_OUTPUT_DIR="./programs/output"
OUTPUT_BITCODE_FILE="original_program.bc"
BUFFER_MONITOR_SOURCE="./BufferMonitor.cpp"
OUTPUT_TRANSFORMED_BITCODE_FILE="transformed_program.bc"

# Default DEBUG flag is not set
DEBUG_FLAG=""

# Array to store source files
declare -a SOURCE_FILES

# Check for -DDEBUG in arguments and gather source files
for arg in "$@"; do
    if [ "$arg" == "-DDEBUG" ]; then
        DEBUG_FLAG="-DDEBUG"
    else
        SOURCE_FILES+=("$arg")
    fi
done

# Check if at least one input file is provided
if [ "${#SOURCE_FILES[@]}" -lt 1 ]; then
    echo "Usage: $0 [-DDEBUG] < source file C++ > < ... >"
    exit 1
fi

INPUT_FILE="${!#}"
BASE_NAME=$(basename "$INPUT_FILE" .cpp)

# Compile BufferMonitor.cpp pass to shared library
clang++ $DEBUG_FLAG -shared -o "$SHARED_DIR/BufferMonitor.so" $(llvm-config --cxxflags) "$BUFFER_MONITOR_SOURCE" $(llvm-config --ldflags) -fPIC -lLLVM
if [ $? -ne 0 ]; then
    echo "Error compiling BufferMonitor.cpp"
    exit 2
fi

# Array to store compiled bitcode files
declare -a COMPILED_BITCODES

# Compile each source file to a bitcode file
for INPUT_FILE in "${SOURCE_FILES[@]}"; do
    BASE_NAME=$(basename "$INPUT_FILE" .cpp)
    OUTPUT_BITCODE_FILE="${BASE_NAME}.bc"

    # Compile to llvm bitcode file 
    clang++ -emit-llvm -fPIE -c "$INPUT_FILE" -o "$PROGRAMS_OUTPUT_DIR/$OUTPUT_BITCODE_FILE"
    if [ $? -ne 0 ]; then
        echo "Error compiling $INPUT_FILE to llvm bitcode"
        exit 3
    fi

    # Check if the bitcode file was created
    if [ ! -f "$PROGRAMS_OUTPUT_DIR/$OUTPUT_BITCODE_FILE" ]; then
        echo "Expected bitcode file not found: $PROGRAMS_OUTPUT_DIR/$OUTPUT_BITCODE_FILE"
        exit 3
    fi

    COMPILED_BITCODES+=("$PROGRAMS_OUTPUT_DIR/$OUTPUT_BITCODE_FILE")
done

# Print paths to be linked
echo "Linking the following bitcode files:"
printf "%s\n" "${COMPILED_BITCODES[@]}"

# Link all bitcode files into one
echo "Running: llvm-link ${COMPILED_BITCODES[@]} -o $PROGRAMS_OUTPUT_DIR/$LINKED_BITCODE"
llvm-link "${COMPILED_BITCODES[@]}" -o "$PROGRAMS_OUTPUT_DIR/$LINKED_BITCODE"
if [ $? -ne 0 ]; then
    echo "Error linking compiled bitcode files"
    exit 4
fi

# Run the pass using opt on the linked bitcode file
OUTPUT_TRANSFORMED_BITCODE_FILE="transformed_$LINKED_BITCODE"
opt -enable-new-pm=0 -load "$SHARED_DIR/BufferMonitor.so" -buffer_monitor -o "$PROGRAMS_OUTPUT_DIR/$OUTPUT_TRANSFORMED_BITCODE_FILE" < "$PROGRAMS_OUTPUT_DIR/$LINKED_BITCODE"
if [ $? -ne 0 ]; then
    echo "Error running the LLVM pass on $LINKED_BITCODE"
    exit 5
fi