#include <iostream>

#define STATIC_ARRAY_SIZE 5

int main() {
    int staticArray[STATIC_ARRAY_SIZE] = {1, 2, 3, 4, 5};

    int* dynamicArray = new int[STATIC_ARRAY_SIZE];
    for (int i = 0; i < STATIC_ARRAY_SIZE; i++) {
        dynamicArray[i] = i * 10;
    }

    std::cout << "Static array:" << std::endl;
    for (int i = 0; i < STATIC_ARRAY_SIZE; i++) {
        std::cout << staticArray[i] << " ";
    }
    std::cout << std::endl;

    std::cout << "Dynamic array:" << std::endl;
    for (int i = 0; i < STATIC_ARRAY_SIZE; i++) {
        std::cout << dynamicArray[i] << " ";
    }
    std::cout << std::endl;

    staticArray[2] = 99;
    dynamicArray[3] = 88;

    std::cout << "Static array after update:" << std::endl;
    for (int i = 0; i < STATIC_ARRAY_SIZE; i++) {
        std::cout << staticArray[i] << " ";
    }
    std::cout << std::endl;

    std::cout << "Dynamic array after update:" << std::endl;
    for (int i = 0; i < STATIC_ARRAY_SIZE; i++) {
        std::cout << dynamicArray[i] << " ";
    }
    std::cout << std::endl;

    delete[] dynamicArray;

    return 0;
}
