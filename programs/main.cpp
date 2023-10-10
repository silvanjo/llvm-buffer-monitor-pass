#include <iostream>

int main() {
    // Allocate a dynamic array of size 10
    int *arr = new int[10];

    // Fill the array with integers from 1 to 10
    for (int i = 0; i < 10; i++) {
        arr[i] = i + 1;
    }

    // Display the contents of the array
    std::cout << "Original array contents:" << std::endl;
    for (int i = 0; i < 10; i++) {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;

    // Double the value of each element in the array
    for (int i = 0; i < 10; i++) {
        arr[i] *= 2;
    }

    // Display the updated array contents
    std::cout << "Updated array contents (doubled values):" << std::endl;
    for (int i = 0; i < 10; i++) {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;

    // Deallocate the dynamic array
    delete[] arr;

    return 0;
}
