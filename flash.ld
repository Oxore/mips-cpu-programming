MEMORY
{
    rom : ORIGIN = 0x00000000, LENGTH = 0x200
    ram : ORIGIN = 0x00000000, LENGTH = 0x400
}

SECTIONS
{
    ._start ORIGIN(rom) : {
        KEEP(*(._start))
    } > rom

    .text : {
        *(.text)
    } > rom

    .rodata : {
        *(.rodata)
    } > rom

    .bss : {
        *(.bss)
    } > ram
}
