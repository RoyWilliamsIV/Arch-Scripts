#!/bin/bash
# This script simply downloads the scripts in this repo.

GIT="https://raw.githubusercontent.com/RoyWilliamsIV/Arch-Scripts/master/"  # Git path variable

wget "$GIT/archpad-install.sh" # Download scripts
wget "$GIT/archpad-setup.sh" 
wget "$GIT/README.md" 

echo "## Downloading complete. Use them wisely. ##"
