#include <iostream>

int main() {
    // Single-dimensional int array allocation
    int* singleIntArray = new int[10];
    for (int i = 0; i < 10; ++i) {
        singleIntArray[i] = i * 10;
    }


    // Print some values to prevent optimizations from removing unused buffers
    std::cout << "First int: " << singleIntArray[0] << std::endl;

    return 0;
}
