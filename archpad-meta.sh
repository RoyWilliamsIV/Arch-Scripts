#!/bin/bash
# This script simply downloads a folder full of the scripts in this repo.

GIT="https://raw.githubusercontent.com/RoyWilliamsIV/Arch-Scripts/master/"  # Git path variable

mkdir "ArchPad Scripts" ; cd "Archpad Scripts" # Make folder for scripts and enter it

wget "$GIT/archpad-install.sh" # Download scripts

echo "## Downloading complete. Use them wisely. ##"
