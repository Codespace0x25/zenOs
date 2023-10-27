;disk.asm

[bits 16]

disk_load:
  pusha
  push dx

  mov ah, 0x02  ; BIOS function number for reading sectors
  mov al, dh    ; Number of sectors to read
  mov cl, 2     ; set to the secter 2
  mov ch, 0x00  ; Cylinder number (set to 0)
  mov dh, 0x00  ; Head number (set to 0)
  mov dl, [boot_drive]  ; Drive number

  int 0x13       ; Call BIOS interrupt to read sectors
  jc disk_error  ; Jump if there's an error (carry flag set)

  pop dx
  cmp al, dh     ; Check if the number of read sectors matches the requested
  jne sectors_error  ; Jump to sectors_error if not

  popa
  ret

disk_error:
  jmp disk_loop   ; Handle the error (e.g., go into a loop or retry)

sectors_error:
  jmp disk_loop   ; Handle a sectors error (e.g., go into a loop or retry)

disk_loop:
  jmp $  ; Endless loop for error handling
