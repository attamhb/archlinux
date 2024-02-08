#!/bin/bash


vim /etc/mkinitcpio.conf
#sed -i 's/^#\(HOOKS=.*\)filesystems\(.*\)$/\1filesystems\2/' /etc/mkinitcpio.conf
mkinitcpio -p linux
#reboot


