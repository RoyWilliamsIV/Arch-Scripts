#!/bin/bash

# generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# enter chroot
arch-chroot /mnt &

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
