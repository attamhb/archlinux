#!/bin/bash

# Set variables
USER_NAME="atta"
HOSTNAME_VAR="arch-ws"

DISK="/dev/nvme0n1"

EFI_PARTITION="${DISK}1"
ROOT_PARTITION="${DISK}2"

#DISK2="/dev/nvme0n2"
#HOME_PARTITION="${DISK}2"

# Function to execute commands within chroot
execute_chroot() {
    arch-chroot /mnt /bin/bash -c "$1"
}

# Function to display messages with a pause
display_message() {
    echo "$1"
    sleep 2
}


vim /etc/mkinitcpio.conf
#sed -i 's/^#\(HOOKS=.*\)filesystems\(.*\)$/\1filesystems\2/' /etc/mkinitcpio.conf
mkinitcpio -p linux


#reboot



#execute_chroot "systemctl enable lightdm"
