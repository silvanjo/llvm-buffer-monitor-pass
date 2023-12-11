#ifndef BUFFER_NODE_H
#define BUFFER_NODE_H

#include <stdlib.h>
#include <stdint.h>

// Node of a linked list used to store information about allocated buffer (static and dynamic)
// The linked list becomes instrumented into the transformed target program
// to keep track of all buffers during runtime
struct buffer_node_t 
{
    uint32_t buffer_id;                  // Unique ID of this buffer
    uint32_t highest_accessed_byte;      // The highest accessed index of this buffer during program execution

    void* buffer_address;                // Address of the allocated buffer
    size_t buffer_size;                  // Size of the buffer

    struct buffer_node_t* next_node;     // Pointer to the next node
};

#endif // BUFFER_NODE_H
