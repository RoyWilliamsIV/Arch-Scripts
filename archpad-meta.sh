#!/bin/bash
# This script simply downloads and runs the others.

GIT="https://raw.githubusercontent.com/RoyWilliamsIV/Arch-Scripts/master/"  # Git path variable

wget "$GIT/archpad-install.sh" ; bash archpad-install.sh                    # Download and run install script

arch-chroot /mnt ; wget "$GIT/archpad-setup.sh" ; bash archpad-setup.sh     # re-enter chroot and download/run next script
