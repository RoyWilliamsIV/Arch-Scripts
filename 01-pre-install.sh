#!/bin/bash

# update system clock
timedatectl set-ntp true

# disk partitioning
(
echo o    # Create a new empty GPT partition table
echo y    # Confirm changes
echo n    # 1. Create BIOS partition
echo 1    # Partition number
echo ""    # First sector (Accept default: 1)
echo +1M  # Last sector (Create 1MB size)
echo EF02 # Change type to BIOS
echo n    # 2. Create swap partition
echo 2    # Partition number
echo ""    # First sector (Accept default: 1)
echo +4G  # Last sector (Create 4GB size)
echo 8200 # Change type to BIOS
echo n    # 3. Create main partition
echo 3    # Partition number
echo ""     # First sector (Accept default: 1)
echo ""     # Last sector (Accept default: varies)
echo ""     # Change type to main
echo w    # Write changes
echo y    # Confirm changes
) | gdisk /dev/sda 

# format main partition as ext4
yes | mkfs.ext4 /dev/sda3

