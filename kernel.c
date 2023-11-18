// kernel.c

#include "./dirvers/interrupts.h"  // Include your interrupts header file
#include "./dirvers/display.h"


idt_gate_t idt[256];
idt_register_t idt_reg;
isr_t interrupt_handlers[256];  // Assuming you have 256 ISRs

// Define or declare the functions used in the header
void print_letter(uint8_t scancode);
void register_interrupt_handler(int, isr_t);

// Your other kernel code goes here...

void kernel_main() {
    // Initialize the IDT and install ISRs
    isr_install();

    // Initialize the PIC and IRQs
    remap_pic();
    irq_install();

    // Enable interrupts
    asm volatile("sti");

    // Initialize the keyboard
    init_keyboard();

    // Your other initialization code...

    // Enter an infinite loop or perform other kernel tasks
    while (1) {
        // Your kernel logic...
    }
}
