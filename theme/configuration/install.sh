#!/bin/bash

if [ -d "/boot/efi/EFI/refind" ]; then
	# Found rEFInd bootloader
	echo "Found rEFInd"
	mkdir -p /boot/efi/EFI/refind/themes///THEMENAME//
	cp -R . /boot/efi/EFI/refind/themes///THEMENAME///
	echo 'include themes///THEMENAME///theme.conf' >> /boot/efi/EFI/refind/refind.conf
	echo "//THEMENAME// successfully installed."
else
  	# rEFInd bootloader not found
	echo "Could not locate rEFInd bootloader."
	echo "This can be due to the ESP not mounted at /boot/efi."
	echo "Please locate the rEFInd boot manager and manually install the theme."
fi