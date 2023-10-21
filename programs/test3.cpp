#include <iostream>
#include <vector>

int main() {
    std::vector<int> numbers;
    int arr1[10] = {0,1,2,3,4,5,6,7,8,9};
    std::cout << "Index 1: " << arr1[1] << std::endl;

    for (int i = 0; i < 10; ++i) {
        numbers.push_back(i);
    }

    std::cout << "Size of the vector: " << numbers.size() << std::endl;

    std::cout << "Elements in the vector: ";
    for (int num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;

    numbers.pop_back();

    std::cout << "Elements after pop_back: ";
    for (int num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;

    return 0;
}
