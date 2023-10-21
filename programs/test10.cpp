#include <iostream>

// Define a struct called 'Person'
struct Person {
    std::string name;
    int age;
    double height;
};

int main() {
    // Initialize a struct instance with some values
    Person alice = {"Alice", 30, 5.6};

    // Modify the struct fields
    alice.name = "Alicia";
    alice.age = 31;

    // Access and print the fields of the struct
    std::cout << "Name: " << alice.name << std::endl;
    std::cout << "Age: " << alice.age << std::endl;
    std::cout << "Height: " << alice.height << " feet" << std::endl;

    return 0;
}
