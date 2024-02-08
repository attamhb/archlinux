#!/bin/bash
HOSTNAME_VAR = "arch-somethin"
display_message() { 
echo "$1" 
sleep 2 
}

# display message and pause
display_message "Chrooting into the installed system and configuring..."
ln -sf /usr/share/zoneinfo/America/Phoenix/etc/localtime
hwclock --systohc
#timedatectl
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
#
#
#
echo '$HOSTNAME_VAR' > /etc/hostname
#
#
#
echo "127.0.0.1   localhost" >>  /etc/hosts
echo "::1         localhost" >>  /etc/hosts
echo "127.0.1.1   $HOSTNAME_VAR.localdomain    $HOSTNAME_VAR" >>  /etc/hosts

echo "Hostname has been set to: $HOSTNAME_VAR"
display_message "Setting root password..."
passwd

