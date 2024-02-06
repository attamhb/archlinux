#!/bin/bash
HOSTNAME_VAR = "arch-somethin"

execute_chroot() { arch-chroot /mnt /bin/bash -c "$1" }

display_message() { echo "$1" sleep 2 }


# Display message and pause
display_message "Chrooting into the installed system and configuring..."
execute_chroot "ln -sf /usr/share/zoneinfo/America/Phoenix /etc/localtime"
execute_chroot "hwclock --systohc"
execute_chroot "timedatectl"
execute_chroot "sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen"
execute_chroot "locale-gen"
execute_chroot "echo 'LANG=en_US.UTF-8' > /etc/locale.conf"
execute_chroot "echo '$HOSTNAME_VAR' > /etc/hostname"
execute_chroot "cat > /etc/hosts <<EOL
127.0.0.1   localhost
::1         localhost
127.0.1.1   $HOSTNAME_VAR.localdomain    $HOSTNAME_VAR
EOL"

echo "Hostname has been set to: $HOSTNAME_VAR"

# Display message and pause
display_message "Setting root password..."
# Set root password
execute_chroot "passwd"

