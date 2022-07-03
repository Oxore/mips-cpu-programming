Q?=@
QQ=@

RM?=rm

PREFIX_ARCH?=mipsel-elf
AS=$(PREFIX_ARCH)-as
CC=$(PREFIX_ARCH)-gcc
LD=$(PREFIX_ARCH)-gcc
OBJDUMP=$(PREFIX_ARCH)-objdump
OBJCOPY=$(PREFIX_ARCH)-objcopy

TARGET=main

SRC=src
BUILD=build

SOURCES:=$(wildcard $(SRC)/*.c)
SOURCES+=$(wildcard $(SRC)/*.s)
OBJECTS:=$(patsubst $(SRC)/%,$(BUILD)/%.o,$(SOURCES))

COMMON_FLAGS+=-mips32r5 -EL -msoft-float
COMMON_FLAGS+=-O0 -flto
COMMON_FLAGS+=-ffreestanding -nostartfiles -nostdlib

ASFLAGS+=--warn --fatal-warnings
ASFLAGS+=$(COMMON_FLAGS)

CFLAGS+=-Wall -Wextra
CFLAGS+=-ffunction-sections -fdata-sections
CFLAGS+=$(COMMON_FLAGS)

LDFLAGS+=-Wl,--gc-sections -Wl,-Map=$(TARGET).map -T flash.ld -Wl,--build-id=none
LDFLAGS+=$(COMMON_FLAGS)

all: $(TARGET).elf $(TARGET).bin $(TARGET).rom

$(OBJECTS): Makefile | $(BUILD)

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/%.c.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD)/%.s.o: $(SRC)/%.s
	$(AS) $(ASFLAGS) $< -o $@

$(TARGET).elf: $(OBJECTS) flash.ld
	$(LD) $(LDFLAGS) -o $@ $(OBJECTS)

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) $< $@ -O binary --remove-section '*.abiflags'

$(TARGET).rom: $(TARGET).bin
	echo "v2.0 raw" >$@
	hexdump -v -e'/4 "%08X" "\n"' $< >>$@

clean:
	$(RM) -rfv $(OBJECTS) $(TARGET).elf $(TARGET).map $(TARGET).bin $(TARGET).rom

.PHONY: clean all
