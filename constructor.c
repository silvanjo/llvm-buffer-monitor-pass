#include <stdio.h>
#include <stdlib.h>

FILE* __file_;

__attribute__((constructor)) void my_setup_function(void) 
{
  printf("Open file for IO.\n");

  __file_ = fopen("output.txt", "a");

  if (__file_ == NULL) {
    printf("Error opening file!\n");
    exit(1);
  }
}

