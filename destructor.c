#include <stdio.h>
#include <stdlib.h>

__attribute__((destructor)) void my_teardown_function(void) 
{
  printf("This runs after main().\n");
}
