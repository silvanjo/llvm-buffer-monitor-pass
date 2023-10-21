#include <iostream>

int main() {
    int twoDimArray[3][4] = {
        {1, 2, 3, 4},
        {5, 6, 7, 8},
        {9, 10, 11, 12}
    };

    // Print some values to ensure the program uses the array
    std::cout << "twoDimArray[0][1]: " << twoDimArray[0][1] << std::endl;  // prints 2
    std::cout << "twoDimArray[2][3]: " << twoDimArray[2][3] << std::endl;  // prints 12

    return 0;
}
