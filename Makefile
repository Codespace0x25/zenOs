# Makefile for building the bootloader, C kernel, and running in QEMU
# Output filenames
BOOTLOADER_BIN = bootloader.bin
KERNEL_BIN = kernel.bin
BOOTABLE_BIN = bootable.bin
BOOTABLE_IMG = bootable.img

# Source files
BOOTLOADER_SRC = boot.s
GDT_SRC = gdt.asm
SWITCH_TO_32BIT_SRC = switch-to-32bit.asm
DISK_SRC = disk.asm
KERNEL_SRC = kernel.c

# Compilation flags
NASM = nasm
GCC = gcc
LD = ld
RM = rm -f
QEMU = qemu-system-i386

NASM_FLAGS = -f bin
GCC_FLAGS = -Wall -T linker.ld -m32 -nostdlib -fno-builtin -ffreestanding 

# Targets
all: $(BOOTABLE_IMG)

$(BOOTLOADER_BIN): $(BOOTLOADER_SRC)
	$(NASM) $(NASM_FLAGS) $< -o $@

$(KERNEL_BIN): $(KERNEL_SRC)
	$(GCC) $(GCC_FLAGS) $< -o $@

$(BOOTABLE_BIN): $(BOOTLOADER_BIN) $(KERNEL_BIN)
	cat $(BOOTLOADER_BIN) $(KERNEL_BIN) > $@

$(BOOTABLE_IMG): $(BOOTABLE_BIN)
	dd if=/dev/zero of=$@ bs=1024 count=1440
	dd if=$(BOOTABLE_BIN) of=$@ conv=notrunc

run: $(BOOTABLE_IMG)
	$(QEMU) -fda $< -boot a

clean:
	$(RM) $(BOOTLOADER_BIN) $(KERNEL_BIN) $(BOOTABLE_BIN) $(BOOTABLE_IMG)

.PHONY: all run clean

