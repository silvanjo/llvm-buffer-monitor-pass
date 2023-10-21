#include <iostream>

int main() {
    int singleDimArray1[5] = {1, 2, 3, 4, 5};           // 20 bytes
    char singleDimArray2[6] = "Hello";                  // 6 bytes
    double singleDimArray3[3] = {3.14, 1.618, 2.71};    // 24 bytes

    std::cout << singleDimArray1[2] << std::endl;       // prints 3
    std::cout << singleDimArray2[1] << std::endl;       // prints e
    std::cout << singleDimArray3[0] << std::endl;       // prints 3.14

    return 0;
}
