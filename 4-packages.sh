#!/bin/bash

display_message() { 
echo "$1" 
sleep 2 
}

display_message "Installing additional packages with Pacman..."

pacman -S --noconfirm grub efi-bootmgr efibootmgr btrfs-progs grub-btrfs  timeshift timeshift-autosnap

pacman -S --noconfirm reflector nfs-utlis inetutils dnsutils

pacman -S --noconfirm base-devel linux-headers sof-firmware 

pacman -S --noconfirm networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools openshh 

pacman -S --noconfirm alsa-utlis pipiewaire pipewire-alsa pipewire-pulse pipewire-jack pavucontrol rsync

pacman -S --noconfirm bluez bluez-utils blueman  cups

pacman -S --noconfirm xdg-utils xdg-user-dirs gvfs  xorg-server os-prober 

pacman -S --noconfirm rubber rxvt-unicode stow texmaker thunar 

pacman -S --noconfirm emacs neovim alacritty evince firefox fzf git tmux  zathura zsh

pacman -S --noconfirm ufw unzip virtualbox vlc wget xclip xdotool 

pacman -S --noconfirm flameshot gimp gnome-multi-writer htop

pacman -S --noconfirm ttf-fira-code ttf-jetbrains-mono ttf-scheherazade-new

pacman -S --noconfirm hunspell-en_us inkscape iperf lxappearance nano

pacman -S --noconfirm archlinux-wallpaper feh arandr aspell bash-completion btop clisp cmake


pacman -S --noconfirm neofetch nitrogen papirus-icon-theme picom

pacman -S --noconfirm ipython julia python-matplotlib python-pandas python-pip python-scipy python-tqdm

pacman -S --noconfirm dmenu xmobar xmonad xmonad-contrib lightdm lightdm-settings

pacman -S --noconfirm trayer tree

