# Logisim MIPS CPU programming

Still doesn't really work. It has `addui`/`li` issue with negative numbers. Not
sure who is wrong - CPU or the compiler.

Bare metal [MIPS CPU](https://github.com/yuxincs/MIPS-CPU) example of program
built by `mipsel-elf-gcc` compile.

Produces `main.rom` that can be loaded into ROM and got executed by MIPS CPU.

It doesn't employ any `crt0`-like stuff, so only zero initialized globals
are supported.
