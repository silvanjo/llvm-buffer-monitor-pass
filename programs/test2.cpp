#include <iostream>

int main() {
    // Static arrays
    int staticArray1[5] = {1, 2, 3, 4, 5};
    double staticArray2[3] = {1.1, 2.2, 3.3};

    std::cout << "Static Array 1: ";
    for (int i = 0; i < 5; i++) {
        std::cout << staticArray1[i] << " ";
    }
    std::cout << std::endl;

    std::cout << "Static Array 2: ";
    for (int i = 0; i < 3; i++) {
        std::cout << staticArray2[i] << " ";
    }
    std::cout << std::endl;

    // Dynamic arrays
    int* dynamicArray1 = new int[5];
    double* dynamicArray2 = new double[3];

    // Initialize dynamic arrays
    for (int i = 0; i < 5; i++) {
        dynamicArray1[i] = i + 6; // Some arbitrary values
    }
    for (int i = 0; i < 3; i++) {
        dynamicArray2[i] = i + 4.4; // Some arbitrary values
    }

    std::cout << "Dynamic Array 1: ";
    for (int i = 0; i < 5; i++) {
        std::cout << dynamicArray1[i] << " ";
    }
    std::cout << std::endl;

    std::cout << "Dynamic Array 2: ";
    for (int i = 0; i < 3; i++) {
        std::cout << dynamicArray2[i] << " ";
    }
    std::cout << std::endl;

    // Clean up dynamic memory
    delete[] dynamicArray1;
    delete[] dynamicArray2;

    return 0;
}
