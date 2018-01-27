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

# GUI Configuration

## Install ALSA and Pulse
pacman --noconfirm -S alsa-utils pulseaudio
## Install Xorg 
pacman --noconfirm -S xorg-server xorg-xinit

## Install ATI drivers
pacman --noconfirm -S mesa xf86-video-intel

## Install tlp and Thinkpad Battery Driver
pacman --noconfirm -S tlp tp_smapi

## Configure tlp
### enable systemd services
systemctl enable tlp.service
systemctl enable tlp-sleep.service
### mask conflicting services
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket

## Install i3 packages
pacman --noconfirm -S i3-wm i3status dmenu i3lock compton
  ## Copy sample config files over

# TODO - .xinitrc config
# TODO - config files

# Install other packages
pacman --noconfirm -S firefox qutebrowser kodi termite feh

## Create .config folder
mkdir /home/roy/.config

