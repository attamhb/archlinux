#!/bin/bash


execute_chroot() { arch-chroot /mnt /bin/bash -c "$1" }
display_message() { echo "$1" sleep 2 }


# Install base system and essential packages
display_message "Installing base system and essential packages..."
pacstrap /mnt base linux linux-firmware git vim amd-ucode btrfs-progs

# Generate fstab
display_message "Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

