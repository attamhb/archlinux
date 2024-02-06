#!/bin/bash

execute_chroot() { arch-chroot /mnt /bin/bash -c "$1" }

display_message() { echo "$1" sleep 2 }

# Enable and start services
display_message "Enabling and starting NetworkManager..."
execute_chroot "systemctl enable NetworkManager"
execute_chroot "systemctl start NetworkManager"

# Display message and pause
display_message "Enabling and starting CUPS..."
execute_chroot "systemctl enable cups"
execute_chroot "systemctl start cups"

# Display message and pause
display_message "Enabling and starting Bluetooth..."
execute_chroot "systemctl enable bluetooth"
execute_chroot "systemctl start bluetooth"

# Display message and pause
display_message "Enabling fstrim.timer, lightdm, and yay..."
execute_chroot "systemctl enable fstrim.timer"
