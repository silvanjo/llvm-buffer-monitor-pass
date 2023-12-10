#include <stdio.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/shm.h>

#define SHARED_MEM_SIZE 1024 // 1KB

char* __shared_memory_;

__attribute__((constructor)) void my_setup_function(void) 
{
  // Create shared memory before running targetr program
  key_t key = 1234;

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

