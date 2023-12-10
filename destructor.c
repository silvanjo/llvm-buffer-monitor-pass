#include <stdio.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/shm.h>

extern char* __shared_memory_;

__attribute__((destructor)) void my_teardown_function(void) 
{
  char value = __shared_memory_[0];
  printf("Destructor: %d\n", value);

  // Detach shared memory
  if (shmdt(__shared_memory_) == -1) {
    perror("shmdt");
    return;
  }

  printf("Detach shared memory: succes\n");
}
