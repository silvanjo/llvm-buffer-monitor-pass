#include <iostream>

const int ROWS = 3;
const int COLS = 3;

void printArray(int arr[ROWS][COLS]) {
    for(int i = 0; i < ROWS; i++) {
        for(int j = 0; j < COLS; j++) {
            std::cout << arr[i][j] << " ";
        }
        std::cout << std::endl;
    }
}

void addArrays(int arr1[ROWS][COLS], int arr2[ROWS][COLS], int result[ROWS][COLS]) {
    for(int i = 0; i < ROWS; i++) {
        for(int j = 0; j < COLS; j++) {
            result[i][j] = arr1[i][j] + arr2[i][j];
        }
    }
}

int main() {
    int array1[ROWS][COLS] = {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9}
    };

    int array2[ROWS][COLS] = {
        {9, 8, 7},
        {6, 5, 4},
        {3, 2, 1}
    };

    int result[ROWS][COLS];

    addArrays(array1, array2, result);

    std::cout << "Array 1:" << std::endl;
    printArray(array1);

    std::cout << "Array 2:" << std::endl;
    printArray(array2);

    std::cout << "Result of addition:" << std::endl;
    printArray(result);

    return 0;
}
