#pragma once

#include "person.h"
#include <vector>

class Group {
private:
    std::vector<Person> members;

public:
    Group();
    void addMember(const Person& p);
    void printAllMembers() const;
    int getSize() const;
};
