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

# Display message and pause
display_message "Creating EFI and root partitions using gdisk..."
# Create EFI and root partitions using gdisk
gdisk $DISK <<EOF
n


+560M
ef00
n




w
y
EOF

# Display message and pause
display_message "Formatting EFI and root partitions..."
# Formatting EFI and root partitions
mkfs.vfat $EFI_PARTITION
mkfs.btrfs $ROOT_PARTITION

# Display message and pause
display_message "Mounting root partition and creating Btrfs subvolumes..."
# Mount root partition and create Btrfs subvolumes
mount $ROOT_PARTITION /mnt

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@var

umount /mnt

# Display message and pause
display_message "Mounting root partition with Btrfs options..."
# Mount root partition with Btrfs options

mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@ $ROOT_PARTITION /mnt

# Display message and pause
display_message "Creating necessary directories and mounting Btrfs subvolumes..."
# Create necessary directories and mount Btrfs subvolumes
mkdir -p /mnt/{boot/efi,home,var}
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@home $ROOT_PARTITION /mnt/home
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@var $ROOT_PARTITION /mnt/var

# Display message and pause
display_message "Mounting EFI partition..."
# Mount EFI partition
mount $EFI_PARTITION /mnt/boot/efi

# Display message and pause
display_message "Installing base system and essential packages..."
# Install base system and essential packages
pacstrap /mnt base linux linux-firmware git vim amd-ucode btrfs-progs

# Display message and pause
display_message "Generating fstab..."
# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Display message and pause
display_message "Chrooting into the installed system and configuring..."
# Chroot into the installed system and configure
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

# Display message and pause
display_message "Installing additional packages with Pacman..."
# Install additional packages with Pacman
execute_chroot "pacman -S --noconfirm grub efi-bootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel linux-headers bluez bluez-utils blueman cups xdg-utils xdg-user-dirs gvfs emacs neovim xorg-server os-prober alacritty arandr archlinux-wallpaper aspell bash-completion btop btrfs-progs clisp cmake dmenu efibootmgr evince feh firefox flameshot fzf gimp git gnome-multi-writer grub-btrfs htop hunspell-en_us inkscape iperf ipython julia lightdm lightdm-settings lxappearance nano neofetch nitrogen papirus-icon-theme pavucontrol picom python-matplotlib python-pandas python-pip python-scipy python-tqdm rubber rxvt-unicode sof-firmware stow texmaker thunar timeshift timeshift-autosnap tmux trayer tree ttf-fira-code ttf-jetbrains-mono ttf-scheherazade-new ufw unzip virtualbox vlc wget xclip xdotool xmobar xmonad xmonad-contrib zathura zsh"

more_packages
= "reflector nfs-utlis inetutils dnsutils alsa-utlis pipiewaire pipewire-alsa
pipewire-pulse pipe wire jack openshh rsync"
# GRUB installation and configuration
execute_chroot "grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB"
execute_chroot "grub-mkconfig -o /boot/grub/grub.cfg"
execute_chroot "echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub"
execute_chroot "grub-mkconfig -o /boot/grub/grub.cfg"
####################3 install and enable openshh
# Enable and start services
# Display message and pause
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
# Enable fstrim.timer, lightdm, and yay
execute_chroot "systemctl enable fstrim.timer"
#############3 creaet new user

userad -m $USER_NAME

passwd $USER_NAME


# sudo priviliges

usermod -aG wheel $USER_NAME

id $USER_NAME

# Edit sudoers file to uncomment the wheel group
EDITOR=vim visudo

# Uncomment the following line in /etc/mkinitcpio.conf to enable Btrfs
# Modify the HOOKS line to include "filesystems" and "keyboard" before "fsck"
vim /etc/mkinitcpio.conf

# Uncomment the line with 'HOOKS' in /etc/mkinitcpio.conf to enable Btrfs
#sed -i 's/^#\(HOOKS=.*\)filesystems\(.*\)$/\1filesystems\2/' /etc/mkinitcpio.conf

# Regenerate the initramfs
mkinitcpio -p linux


############################3
#reboot



############################3
#execute_chroot "systemctl enable lightdm"
#execute_chroot "cd / && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"

# Display message and pause
display_message "Installing additional AUR packages with Yay..."
# Install additional AUR packages with Yay
execute_chroot "yay -S --noconfirm timeshift timeshift-autosnap zramd lightdm-settings-aur
dropbox dunst gnome-shell-pomodoro j4-dmenu-desktop texlive-full whatsapp-for-linux xournalpp zathura-pdf-poppler zellij zoom texlive-full"
# Display message and pause
display_message "Enabling zramd..."
# Enable zramd
execute_chroot "systemctl enable --now zramd"

# Display message and pause
display_message "Setting up timeshift and timeshift-autosnap..."
# Set up timeshift and timeshift-autosnap
# ...

# Display final message
display_message "Installation and configuration complete."
