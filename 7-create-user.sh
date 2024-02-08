#!/bin/bash

USER_NAME="atta"


userad -m $USER_NAME
passwd $USER_NAME
usermod -aG wheel $USER_NAME
id $USER_NAME
sudo sed -i 's/^# %wheel ALL=(ALL) ALL$/%wheel ALL=(ALL) ALL/' /etc/sudoers


