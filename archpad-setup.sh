#!/bin/bash

# Post-Install Setup

#####################################################################################
# Please do not use this script blindly. Review and edit before use. Read the wiki! #
#####################################################################################
# Roy Williams IV - 2018 - GPLv3 #
##################################

# Configure swap to be loaded on startup
mkswap /dev/sda2
swapon /dev/sda2
echo "UUID=$(lsblk -no UUID /dev/sda2) none swap defaults 0 0" >> /etc/fstab

# Create User "roy" in wheel Usergroup, prompt user for password.
useradd -m -G wheel -s /bin/bash roy
passwd roy

# Install Sudo
pacman --noconfirm -S sudo

# Configure Sudo for wheel Usergroup
echo "# Allow all wheel usergroup sudo access
%wheel  ALL=(ALL) ALL" >> /etc/sudoers

# i3 Configuration

  ## Install Xorg 
pacman --noconfirm -S xorg xorg-xinit
  ## Install needed packages

pacman --noconfirm -S i3wm i3status dmenu i3lock compton
  ## Copy sample config files over

# TODO - config add compton and i3 to .xinitrc

# Install other packages
pacman --noconfirm -S firefox

