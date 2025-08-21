EFI_INCLUDES = /usr/include/efi
EFI_LDS      = elf_x86_64_efi.lds
EFI_CRT0     = /usr/lib/crt0-efi-x86_64.o
EFI_LDFLAGS  = -nostdlib --warn-common --no-undefined -znocombreloc -T $(EFI_LDS) -s -shared -Bsymbolic $(EFI_CRT0) -L/usr/lib -lgnuefi -lefi

all: BOOTX64.EFI

hello.o: hello.c
	gcc -I$(EFI_INCLUDES) -ffreestanding -fPIC -fshort-wchar -fno-stack-protector -fno-stack-check \
		-fno-strict-aliasing -fno-merge-all-constants -m64 -mno-red-zone -DGNU_EFI_USE_MS_ABI \
		-maccumulate-outgoing-args --std=c11 -Og -g3 -Wall -Wextra -Wdouble-promotion \
		-fmessage-length=0 -c hello.c -o hello.o

BOOTX64.EFI: hello.o
	ld $(EFI_LDFLAGS) hello.o -o hello.so
	objcopy -j .text -j .sdata -j .data -j .dynamic -j .dynsym -j .rel \
		-j .rela -j .reloc \
		--target=efi-app-x86_64 hello.so BOOTX64.EFI

clean:
	rm -f *.o *.so BOOTX64.EFI