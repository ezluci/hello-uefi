# hello-uefi

The simplest "bootloader" for UEFI firmware that just prints `Hello UEFI!`.

Compile, put it under `EFI/BOOT/BOOTX64.EFI` in an EFI partition (on a stick for example), and boot from it.