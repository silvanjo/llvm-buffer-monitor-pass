#include "person.h"
#include <iostream>

Person::Person(std::string n, int a) : name(n), age(a) {}

std::string Person::getName() const {
    return name;
}

int Person::getAge() const {
    return age;
}

void Person::printInfo() const {
    std::cout << "Name: " << name << ", Age: " << age << std::endl;
}
