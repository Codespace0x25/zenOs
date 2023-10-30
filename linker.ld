OUTPUT_FORMAT(binary)
STARTUP(startup.o)

SECTIONS {
    . = 0x1000;

    .text : {
        *(.text);
    }

    .data : {
        *(.data*);
        *(.data);
        *(.rodata);
        *(.rodata*);
    }

    /DISCARD/ : {
        *(.note*)
        *(.comment*)
    }
}
