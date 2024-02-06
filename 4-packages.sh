#!/bin/bash

execute_chroot() { arch-chroot /mnt /bin/bash -c "$1" }
display_message() { echo "$1" sleep 2 }

display_message "Installing additional packages with Pacman..."

execute_chroot "grub efi-bootmgr efibootmgr btrfs-progs grub-btrfs  timeshift timeshift-autosnap"
execute_chroot = "reflector nfs-utlis inetutils dnsutils"
execute_chroot "base-devel linux-headers sof-firmware "

execute_chroot "networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools openshh "
execute_chroot "alsa-utlis pipiewaire pipewire-alsa pipewire-pulse pipewire-jack pavucontrol rsync"
execute_chroot "bluez bluez-utils blueman  cups"

execute_chroot "xdg-utils xdg-user-dirs gvfs  xorg-server os-prober "

execute_chroot "rubber rxvt-unicode stow texmaker thunar " 
execute_chroot  "emacs neovim alacritty evince firefox fzf git tmux  zathura zsh"
execute_chroot "ufw unzip virtualbox vlc wget xclip xdotool" 
execute_chroot "flameshot gimp gnome-multi-writer htop"
execute_chroot "ttf-fira-code ttf-jetbrains-mono ttf-scheherazade-new" 
execute_chroot "hunspell-en_us inkscape iperf lxappearance nano"

execute_chroot "archlinux-wallpaper feh arandr aspell bash-completion btop clisp cmake " 

execute_chroot "neofetch nitrogen papirus-icon-theme picom"

execute_chroot "ipython julia python-matplotlib python-pandas python-pip python-scipy python-tqdm"


execute_chroot "dmenu xmobar xmonad xmonad-contrib lightdm lightdm-settings "
execute_chroot "trayer tree"  



