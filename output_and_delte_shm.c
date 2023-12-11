#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/shm.h>

// Contains declaration of buffer_node_t
#include "BufferNode.h"

#define SHARED_MEM_SIZE 1024 // 1KB

int main()
{
    key_t key = 1234;

    int shmid = shmget(key, SHARED_MEM_SIZE, 0666);
    if (shmid < 0) {
        perror("shmget");
        return 1;
    }

    char* __shared_memory_ = shmat(shmid, NULL, 0);
    if (__shared_memory_ == (char *) -1) {
        perror("shmat");
        return 1;
    }

    uint32_t read_byte_location = 0;
    while (1) 
    {
        struct buffer_node_t node;

        // The end of the buffer list is marked by a NULL entry
        void* entry;
        memcpy(&entry, __shared_memory_ + read_byte_location, sizeof(void*));
        if (!entry)
            break;

        // Read buffer_id from shared memory
        memcpy(&node.buffer_id, __shared_memory_ + read_byte_location, sizeof(uint32_t));
        read_byte_location += sizeof(uint32_t);

        // Read buffer_address from shared memory
        memcpy(&node.buffer_address, __shared_memory_ + read_byte_location, sizeof(void*));
        read_byte_location += sizeof(void*);

        // Read buffer_size from shared memory
        memcpy(&node.buffer_size, __shared_memory_ + read_byte_location, sizeof(size_t));
        read_byte_location += sizeof(size_t);

        // Read highest_accessed_byte from shared memory
        memcpy(&node.highest_accessed_byte, __shared_memory_ + read_byte_location, sizeof(uint32_t));
        read_byte_location += sizeof(uint32_t);

        // Print the node's data (or process it as needed)
        printf("Buffer ID: %u\n", node.buffer_id);
        printf("Buffer Address: %p\n", node.buffer_address);
        printf("Buffer Size: %zu\n", node.buffer_size);
        printf("Highest Accessed Byte: %u\n", node.highest_accessed_byte);
        printf("\n");
    }

    // Detach shared memory
    if (shmdt(__shared_memory_) == -1) {
        perror("shmdt");
        return 1;
    }

    // Delte shared memory
    if (shmctl(shmid, IPC_RMID, NULL) == -1) {
        perror("shmctl");
        return 1;
    }

    return 0;
}