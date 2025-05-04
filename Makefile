machinecode: m.s m.ld
	riscv64-unknown-elf-gcc -O0 -ggdb -nostdlib -march=rv32i -mabi=ilp32 -Wl,-Tm.ld m.s -o main.elf
	riscv64-unknown-elf-objcopy -0 binary main.elf main.bin

printbinary:
	xxd -e -c 4 -g 4 main.bin

startqemu:
	qemu-system-riscv32 -S -M virt -nographic -bios none -kernel main.elf -gdb tcp::1234

connectgdb:
	gdb-multiarch main.elf -ex "target remote localhost:1234" -ex "break _start" -ex "continue" -q

clean:
	rm -f main.elf
	rm -f main.bin
	rm -f m.s
	rm -f m.ld
	rm -f m.o
	rm -f m.map
	rm -f m.sym
	rm -f m.lst
	rm -f m.hex
	rm -f m.bin
	rm -f m.dis