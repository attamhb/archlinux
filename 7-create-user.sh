#!/bin/bash

# Set variables
USER_NAME="atta"
execute_chroot() { arch-chroot /mnt /bin/bash -c "$1" }

display_message() { echo "$1" sleep 2 }


userad -m $USER_NAME
passwd $USER_NAME
usermod -aG wheel $USER_NAME
id $USER_NAME
sudo sed -i 's/^# %wheel ALL=(ALL) ALL$/%wheel ALL=(ALL) ALL/' /etc/sudoers


