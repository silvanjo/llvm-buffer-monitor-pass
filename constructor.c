#include <stdio.h>
#include <stdlib.h>

__attribute__((constructor)) void my_setup_function(void) 
{
  printf("This runs before main().\n");
}

