#include "group.h"
#include <iostream>

Group::Group() {}

void Group::addMember(const Person& p) {
    members.push_back(p);
}

void Group::printAllMembers() const {
    for(const auto& member : members) {
        member.printInfo();
    }
}

int Group::getSize() const {
    return members.size();
}
