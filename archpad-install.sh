#!/bin/bash

#####################################################################################
# Please do not use this script blindly. Review and edit before use. Read the wiki! #
#####################################################################################
# Roy Williams IV - 2018 - GPLv3 #
##################################

###############
# Pre-Install #
###############

# update system clock
timedatectl set-ntp true

# disk partitioning
(
echo o    # Create new partition table
echo n    # 1. Create BOOT partition
echo p      # primary partition type
echo 1      # Partition number
echo ""     # First sector (Accept default: 1)
echo +200M  # Last sector (Create 200MB size)
echo n    # 2. Create SWAP partition
echo p      # primary partition type
echo 2      # Partition number
echo ""     # First sector (Accept default: 1)
echo +8G    # Last sector (Create 8GB size)
echo n    # 3. Create ROOT partition
echo p      # primary partition type
echo 3      # Partition number
echo ""     # First sector (Accept default: 1)
echo +25G   # Last sector (Create 25GB size)
echo n    # 4. Create main partition
echo p      # primary partition type
echo 4      # Partition number
echo ""     # First sector (Accept default: 1)
echo ""     # Last sector (Accept default: varies)
echo w      # Write changes
) | fdisk /dev/sda 

# /dev/sda1 - boot
# /dev/sda2 - swap
# /dev/sda3 - root
# /dev/sda4 - home

# format boot, root, and main partitions ext4
yes | mkfs.ext4 /dev/sda1
yes | mkfs.ext4 /dev/sda3
yes | mkfs.ext4 /dev/sda4

# configure swap
mkswap /dev/sda2
swapon /dev/sda2

#####################
# Mount and Install #
#####################

# mount partitions
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
mkdir /mnt/home
mount /dev/sda4 /mnt/home

# start main installation
pacstrap /mnt base base-devel iw wpa_supplicant dialog intel-ucode grub

# generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

#######################
# Chroot Setup / Grub #
#######################

# enter chroot and continue script
arch-chroot /mnt << EOF

# set time zone
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

# sync hardware clock
hwclock --systohc

# set locale

echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen

locale-gen

# set language
echo 'LANG=en_US.UTF-8' >> /etc/locale.conf

# set hostname
echo 'archpad' >> /etc/hostname

# set hosts
(
echo "127.0.0.1	localhost"
echo "::1		localhost"
echo "127.0.1.1	archpad.localdomain	archpad"
) >> /etc/hosts

################################
# Install Grub and Intel-Ucode #
################################

# install grub
grub-install /dev/sda

# generate config file
grub-mkconfig -o /boot/grub/grub.cfg

# remind user to set new password
# echo "Install finished - please remember to set new root password using passwd."

passwd

EOF


