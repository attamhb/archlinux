#!/bin/bash

execute_chroot() { arch-chroot /mnt /bin/bash -c "$1" }

display_message() { echo "$1" sleep 2 }

# GRUB installation and configuration
execute_chroot "grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB"
execute_chroot "grub-mkconfig -o /boot/grub/grub.cfg"
execute_chroot "echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub"
execute_chroot "grub-mkconfig -o /boot/grub/grub.cfg"
