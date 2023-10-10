#include <iostream>

int main() {
    // Declaration of a static array
    int staticArray[5] = {1, 2, 3, 4, 5};

    // Print the array's contents
    for(int i = 0; i < 5; ++i) {
        std::cout << "staticArray[" << i << "] = " << staticArray[i] << std::endl;
    }

    return 0;
}
