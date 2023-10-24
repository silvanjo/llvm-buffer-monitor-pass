# BufferMonitor Pass

## Introduction

BufferMonitor is an LLVM pass designed to monitor buffer accesses and report potential vulnerabilities. It assists in detecting buffer overflows in C and C++ applications during run-time. It logs heap allocations and buffer accesses to a file and keeps track of buffer sizes and their respective memory addresses. The pass is compiled to a shared library located in shared/BufferMonitor.so.

## Prerequisites

Before running the pass, LLVM and Clang version 14 must be installed:

```
sudo apt-get update
sudo apt-get install llvm-14 clang-14
```

## Installation

```
git clone https://gitlab.fokus.fraunhofer.de/sil94098/llvm-buffer-monitor-pass.git
```

## Running the Pass

To run the pass use the run_pass script:

```
./run_pass path/to/c++/file
```

If the target program consists of multiple source files:

```
./run_pass path/to/c++/file1 path/to/c++/file2 ...
```

To see additional console output when running the pass:

```
./run_pass -DDEBUG path/to/c++/file
```

The transformed output binaries a created in the program/output directory and can be run using lli:

```
lli transformed_linked_output.bc
```