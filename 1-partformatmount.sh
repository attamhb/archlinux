#!/bin/bash


EFI_PARTITION="${DISK}1"
ROOT_PARTITION="${DISK}2"



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

lsblk 

