ARM_GCC ?= arm-none-eabi

as := $(ARM_GCC)-as
ld := $(ARM_GCC)-ld
objcopy := $(ARM_GCC)-objcopy
objdump := $(ARM_GCC)-objdump

all: test.bin

test.bin: test.elf test.list
	$(objcopy) test.elf test.bin -O binary

test.elf: test.o memmap
	$(ld) -o test.elf test.o -T memmap

test.list: test.elf
	$(objdump) -D test.elf > test.list

test.o: test.s
	$(as) test.s -o test.o

clean:
	rm -f test.bin test.elf test.list test.o
