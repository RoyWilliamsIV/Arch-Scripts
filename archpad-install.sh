#!/bin/bash

# update system clock
timedatectl set-ntp true

# disk partitioning
(
echo o    # Create a new empty GPT partition table
echo n    # 1. Create BIOS partition
echo 1    # Partition number
echo      # First sector (Accept default: 1)
echo +1M  # Last sector (Create 1MB size)
echo EF02 # Change type to BIOS
echo n    # 2. Create swap partition
echo 2    # Partition number
echo      # First sector (Accept default: 1)
echo +4G  # Last sector (Create 4GB size)
echo 8200 # Change type to BIOS
echo n    # 3. Create main partition
echo 3    # Partition number
echo      # First sector (Accept default: 1)
echo      # Last sector (Accept default: varies)
echo EF02 # Change type to BIOS
echo w    # Write changes
) | gdisk /dev/sda 

# format main partition as ext4
mkfs.ext4 /dev/sda3

# mount main partition
mount /dev/sda3 /mnt

# start main installation
pacstrap /mnt base

# generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# enter chroot
arch-chroot /mnt

# set time zone
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

# sync hardware clock
hwclock --systohc

# set locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

# set language
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# set hostname
echo "archpad" >> /etc/hostname

# install network utilites
pacman -S iw wpa_supplicant dialog

# install intel-ucode and grub packages
pacman -S intel-ucode
pacman -S grub

# install grub
grub-install /dev/sda

# generate config file
grub-mkconfig -o /boot/grub/grub.cfg

# remind user to set new password
echo "Install finished - please remember to set new root password using passwd."



