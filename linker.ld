OUTPUT_FORMAT(binary)
ENTRY(Main)

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
