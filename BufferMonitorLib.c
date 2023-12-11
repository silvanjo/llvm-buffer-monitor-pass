#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/shm.h>

// Contains declaration of buffer_node_t
#include "BufferNode.h"

/*
    This file contains everything related to managing the buffer list.
*/

#define SHARED_MEM_SIZE 1024 // 1KB

// Shared memory created in Constructor.c
char* __shared_memory_;

// Head of linked list containing all buffers found in the instrumented program
struct buffer_node_t* __buffer_node_list_;
uint32_t buffer_id = 0;

// Insert new buffer node to the linked list
void insert_buffer_node(void* buffer_address, size_t buffer_size)
{
    struct buffer_node_t* new_node = (struct buffer_node_t*) malloc(sizeof(struct buffer_node_t));

    if (!new_node)
    {
        printf("Failed to allocate memory for new buffer node\n");
        return;
    }

    new_node->buffer_address = buffer_address;
    new_node->buffer_size = buffer_size;

    new_node->buffer_id = buffer_id;
    buffer_id++;

    new_node->highest_accessed_byte = 0;

    new_node->next_node = __buffer_node_list_;

    __buffer_node_list_ = new_node;
}

// Get buffer by address
struct buffer_node_t* get_buffer_node_by_address(void* address)
{
    struct buffer_node_t* current_node = __buffer_node_list_;

    while (current_node)
    {
        if (current_node->buffer_address == address)
        {
            return current_node;
        }
    }

    return NULL;
}

// Get buffer by ID
struct buffer_node_t* get_buffer_node_by_id(uint32_t id)
{
    struct buffer_node_t* current_node = __buffer_node_list_;

    while (current_node)
    {
        if (current_node->buffer_id == id)
        {
            return current_node;
        }
    }

    return NULL;
}

// Update highest accessed byte of a buffer
void update_highest_accessed_byte(void* address, uint32_t accessed_byte)
{
    struct buffer_node_t* current_node = __buffer_node_list_;

    while (current_node)
    {
        if (current_node->buffer_address == address)
        {
            if (current_node->highest_accessed_byte < accessed_byte)
            {
                current_node->highest_accessed_byte = accessed_byte;
                return;
            }
        }

        current_node = current_node->next_node;
    }
}

// Store buffer data in shared memory
void store_buffer_data_in_shm()
{
    struct buffer_node_t* current_node = __buffer_node_list_;
    size_t buffer_node_size = sizeof(struct buffer_node_t);

    uint32_t write_byte_location = 0;
    while (current_node)
    {
        /* Extract values from current_node and store them in shared memory */
        
        uint32_t buffer_id = current_node->buffer_id;
        void* buffer_address = current_node->buffer_address;
        size_t buffer_size = current_node->buffer_size;
        uint32_t highest_accessed_byte = current_node->highest_accessed_byte;

        // Write buffer_id to shared memory
        memcpy(__shared_memory_ + write_byte_location, &buffer_id, sizeof(uint32_t));
        write_byte_location += sizeof(uint32_t);

        // Write buffer_address to shared memory
        memcpy(__shared_memory_ + write_byte_location, &buffer_address, sizeof(void*));
        write_byte_location += sizeof(void*);

        // Write buffer_size to shared memory
        memcpy(__shared_memory_ + write_byte_location, &buffer_size, sizeof(size_t));
        write_byte_location += sizeof(size_t);

        // Write highest_accessed_byte to shared memory
        memcpy(__shared_memory_ + write_byte_location, &highest_accessed_byte, sizeof(uint32_t));
        write_byte_location += sizeof(uint32_t);

        current_node = current_node->next_node;
    }

    // Write NULL pointer to indicate end of buffer list
    void* null_pointer = NULL;
    memcpy(__shared_memory_ + write_byte_location, &null_pointer, sizeof(void*));

}

// Print buffer list
void print_buffer_list()
{
    struct buffer_node_t* current_node = __buffer_node_list_;

    while (current_node)
    {
        printf("Buffer ID: %d\n", current_node->buffer_id);
        printf("Buffer address: %p\n", current_node->buffer_address);
        printf("Buffer size: %zu\n", current_node->buffer_size);
        printf("Highest accessed byte: %d\n", current_node->highest_accessed_byte);

        current_node = current_node->next_node;
    }
}

// Print content of shared memory
void print_shared_memory()
{
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
}


// Constructor funtction (runs before main function)
__attribute__((constructor)) void my_setup_function(void) 
{
  // Create shared memory before running targetr program
  key_t key = 1234; // TODO: use ftok() to generate key

  int shmid = shmget(key, SHARED_MEM_SIZE, IPC_CREAT | 0666);
  if (shmid < 0) {
    perror("shmget");
    return;
  }

  __shared_memory_ = shmat(shmid, NULL, 0);
  if (__shared_memory_ == (char *) -1) {
    perror("shmat");
    return;
  }

  memset(__shared_memory_, 0, SHARED_MEM_SIZE);

  printf("Setup shared memory: succes\n");
}

// Destructor function (runs after main function)
__attribute__((destructor)) void my_teardown_function(void) 
{
  // Store buffer data in shared memory
  store_buffer_data_in_shm();

  // Print shared memory
  printf("Shared memory:\n");
  print_shared_memory();
  printf("-----------------------\n");

  // Detach shared memory
  if (shmdt(__shared_memory_) == -1) {
    perror("shmdt");
    return;
  }

  printf("Detach shared memory: succes\n");

  printf("Buffer list:\n");
  print_buffer_list();
  printf("-----------------------\n");

}