#!/bin/bash

#####################################################################################
# Please do not use this script blindly. Review and edit before use. Read the wiki! #
#####################################################################################
# Roy Williams IV - 2018 - GPLv3 #
##################################

dialog --infobox "Installing Arch - Please be patient..." 3 42 &

###############
# Pre-Install #
###############

# update system clock
timedatectl set-ntp true

# partition the disk
gdisk /dev/sda << EOF
o    # Create a new empty GPT partition table
y    # Confirm changes
n    # 1. Create BIOS partition
1    # Partition number
     # First sector (Accept default: 1)
+1M  # Last sector (Create 1MB size)
EF02 # Change type to BIOS
n    # 2. Create swap partition
2    # Partition number
     # First sector (Accept default: 1)
+4G  # Last sector (Create 4GB size)
8200 # Change type to BIOS
n    # 3. Create main partition
3    # Partition number
     # First sector (Accept default: 1)
     # Last sector (Accept default: varies)
     # Leave as default type
w    # Write changes
y    # Confirm changes
EOF

# format main partition as ext4
yes | mkfs.ext4 /dev/sda3

#####################
# Mount and Install #
#####################

# mount main partition
mount /dev/sda3 /mnt

# start main installation
pacstrap /mnt base

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

echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen

locale-gen

# set language
echo 'LANG=en_US.UTF-8' >> /etc/locale.conf

# set hostname
touch /etc/hostname
echo 'archpad' >> /etc/hostname

#########################
# Install Network Tools #
#########################

# install network utilites
yes | pacman -S iw wpa_supplicant dialog

################################
# Install Grub and Intel-Ucode #
################################

# install intel-ucode and grub packages
yes | pacman -S intel-ucode grub

# install grub
grub-install /dev/sda

# generate config file
grub-mkconfig -o /boot/grub/grub.cfg

# remind user to set new password
echo "Install finished - please remember to set new root password using passwd."

EOF

dialog --msgbox "Install Finished!\n\nRemember to set a new root password using passwd." 8 30


