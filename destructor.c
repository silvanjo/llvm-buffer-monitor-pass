#include <stdio.h>
#include <stdlib.h>

extern FILE* __file_;

__attribute__((destructor)) void my_teardown_function(void) 
{
  printf("Closing file.\n");

  // Close the file
  fclose(__file_);

  printf("File closed.\n");
}
