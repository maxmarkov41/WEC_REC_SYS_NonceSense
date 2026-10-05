ENTRY(RESET)

MEMORY
{
    FLASH (rx) : ORIGIN = 0x000000, LENGTH = 32K
    RAM   (rw) : ORIGIN = 0x800100, LENGTH = 2K
}

SECTIONS
{
    .vectors :
    {
        KEEP(*(.vectors))
    } > FLASH

    .text :
    {
        *(.text*)
    } > FLASH
}

__stack = ORIGIN(RAM) + LENGTH(RAM) - 1;