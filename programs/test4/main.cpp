#include "group.h"
#include <iostream>

int main() {
    Person alice("Alice", 25);
    Person bob("Bob", 30);
    Person charlie("Charlie", 35);

    Group group;
    group.addMember(alice);
    group.addMember(bob);
    group.addMember(charlie);

    std::cout << "Group members (" << group.getSize() << " total):" << std::endl;
    group.printAllMembers();

    return 0;
}
