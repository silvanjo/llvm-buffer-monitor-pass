#include <iostream>

int main() {
    int* array1 = new int[50];
    double* array2 = new double[100];
    char* array3 = new char[25];

    for (int i = 0; i < 50; i++) {
        array1[i] = i * 2;
    }

    for (int i = 0; i < 100; i++) {
        array2[i] = i * 1.5;
    }

    for (int i = 0; i < 25; i++) {
        array3[i] = 'A' + i;
    }

    std::cout << "First value in array1: " << array1[0] << std::endl;
    std::cout << "First value in array2: " << array2[0] << std::endl;
    std::cout << "First value in array3: " << array3[0] << std::endl;

    delete[] array1;
    delete[] array2;
    delete[] array3;

    return 0;
}
