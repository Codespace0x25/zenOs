 int_handler:
    mov ax, LINEAR_DATA_SELECTOR
    mov gs, ax
    mov dword [gs:0xB8000],') : '
    hlt
 
 idt:
    resd 50*2
 
 idtr:
    dw (50*8)-1
    dd LINEAR_ADDRESS(idt)
 
 test1:
    lidt [idtr]
    mov eax,int_handler
    mov [idt+49*8],ax
    mov word [idt+49*8+2],CODE_SELECTOR
    mov word [idt+49*8+4],0x8E00
    shr eax,16
    mov [idt+49*8+6],ax
    int 49
