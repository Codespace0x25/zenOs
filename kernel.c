// kernel.c

#include "./dirvers/interrupts.h"  // Include your interrupts header file
#include "./dirvers/display.h"



void kernel_main() {
    // Initialize the IDT and install ISRs
    while (1) {
        // Your kernel logic...
        print_string('h')
    }
}
