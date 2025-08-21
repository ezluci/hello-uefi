#include <efi.h>
#include <efilib.h>

EFI_STATUS efi_main(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable)
{
	InitializeLib(ImageHandle, SystemTable);

	SystemTable->ConOut->OutputString(SystemTable->ConOut, L"Hello UEFI!\r\n");
	SystemTable->ConOut->OutputString(SystemTable->ConOut, L"What's up\r\n");

	BS->Stall(5 * 1000 * 1000);

	return EFI_SUCCESS;
}