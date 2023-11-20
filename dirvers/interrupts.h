
#ifndef INTERRUPTS_H
#define INTERRUPTS_H

#include <stdint.h>

// Define the structure of an IDT gate
typedef struct {
  uint16_t low_offset;
  uint16_t selector;
  uint8_t always0;
  uint8_t flags;
  uint16_t high_offset;
} __attribute__((packed)) idt_gate_t;

// Define the structure for passing registers to ISRs
typedef struct {
  uint32_t ds;
  uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;
  uint32_t int_no, err_code;
  uint32_t eip, cs, eflags, useresp, ss;
} registers_t;

// Define an array of ISR functions
typedef void (*isr_t)(registers_t *);

// Function to set up an IDT gate
static inline void set_idt_gate(int n, uint32_t handler) {
  idt[n].low_offset = handler & 0xFFFF;
  idt[n].selector = 0x08; // Kernel code segment selector
  idt[n].always0 = 0;
  idt[n].flags = 0x8E; // 32-bit interrupt gate
  idt[n].high_offset = (handler >> 16) & 0xFFFF;
}

// Function to load the IDT
static inline void load_idt() {
  idt_reg.base = (uint32_t)&idt;
  idt_reg.limit = sizeof(idt_gate_t) * 256 - 1;
  asm volatile("lidt (%0)" : : "r"(&idt_reg));
}

// Function to handle internal interrupts
static inline void isr_handler(registers_t *r) {
  if (interrupt_handlers[r->int_no] != 0) {
    isr_t handler = interrupt_handlers[r->int_no];
    handler(r);
  }
}

// Function to install ISRs
static inline void isr_install() {
  // ... (install CPU-specific ISRs)
  load_idt(); // Load the IDT
}

// Function to remap the PIC
static inline void remap_pic() {
  // Send initialization command words (ICWs) to both PICs
  // ...

  // Send operational command words (OCWs) to enable interrupts
  // ...
}

// Function to handle external interrupts (IRQs)
static inline void irq_handler(registers_t *r) {
  // ... (handle IRQs)
}

// Function to install IRQs
static inline void irq_install() {
  // ... (install IRQ handlers)
}

// Function to handle keyboard input
static inline void keyboard_callback(registers_t *regs) {
  uint8_t scancode = port_byte_in(0x60); // Read scan code from keyboard port
  print_letter(scancode);                // Print corresponding key information
}

// Function to initialize the keyboard
static inline void init_keyboard() {
  register_interrupt_handler(
      33, keyboard_callback); // Register keyboard handler for IRQ 1
}

#endif // INTERRUPTS_H
