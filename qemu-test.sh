#!/bin/sh

set -e
cd "$(dirname "$0")"

qemu-img create -f raw disk.img 64M
parted -s disk.img -- mklabel gpt mkpart ESP fat32 1MiB 100% set 1 boot on

LOOP=$(losetup --find --show --partscan disk.img)
echo loop drive: ${LOOP}
mkfs.fat -F32 "${LOOP}p1"

mkdir -p /tmp/esp-mount
mount "${LOOP}p1" /tmp/esp-mount
mkdir -p /tmp/esp-mount/EFI/BOOT
cp BOOTX64.EFI /tmp/esp-mount/EFI/BOOT/BOOTX64.EFI
sync

umount /tmp/esp-mount
losetup -d "$LOOP"
rmdir /tmp/esp-mount

qemu-system-x86_64 -bios /usr/share/ovmf/x64/OVMF.4m.fd -drive file=disk.img,format=raw