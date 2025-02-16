AS := as
#LD := ld -m elf_i386
LD := ld -m elf_x86_64

LDFLAG := -Ttext 0x0 -s --oformat binary

image : linux.img

linux.img : bootsect
	cat bootsect > linux.img

bootsect : bootsect.o
	$(LD) $(LDFLAG) -o $@ $<

bootsect.o : bootsect.S
	$(AS) -o $@ $<

run:
	qemu-system-x86_64 -boot a -fda linux.img
clean:
	rm -f *.o
	rm -f bootsect
	rm -f linux.img