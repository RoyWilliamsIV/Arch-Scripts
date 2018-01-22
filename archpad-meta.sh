#!/bin/bash

# This script simply downloads and runs the others.

# Download and run install script
wget https://raw.githubusercontent.com/RoyWilliamsIV/Arch-Scripts/master/archpad-install.sh ; bash archpad-install.sh

# re-enter chroot and download/run next script
arch-chroot /mnt 
wget https://raw.githubusercontent.com/RoyWilliamsIV/Arch-Scripts/master/archpad-setup.sh ; bash archpad-setup.sh
