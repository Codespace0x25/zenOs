;boot.s

[bits 16]
org 0x7C00

KERNEL_OFFSET equ  0x1000



; DS, ES = CS
mov ax, cs
mov ds, ax
mov es, ax
; save boot drive value from DL
mov [boot_drive], dl


mov bp, 0x9000
mov sp, bp

call load_kernel
call switch_to_32bit

jmp $

%include "disk.asm"
%include "gdt.asm"
%include "switch-to-32bit.asm"

[bits 16]
load_kernel:
  mov bx, KERNEL_OFFSET
  mov dh, 16
  mov dl, [boot_drive]
  call disk_load
  ret

[bits 32]
BEGIN_32BIT:
  call KERNEL_OFFSET
  jmp $
boot_drive: db 0
times 510 - ($-$$) db 0
dw 0xAA55

