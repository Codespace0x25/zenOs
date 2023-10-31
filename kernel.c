//kernel.c
#include "./dirvers/display.h"// loads the code in the driver for display to the file to be compiled

void Main() //were the kernel is started
{
    clear_screen();
    print_string("hi\nim mr.fenn"); 

    // Halt the CPU or enter an infinite loop
    while (1){

    }
}
