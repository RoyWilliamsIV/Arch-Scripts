# arch-install-t60
A simple install bash script for my Thinkpad T60.

The region is set to America/Chicago, and the keyboard layout is en_US.UTF-8.

It creates three partitions.

1. Small BIOS partition for Grub
2. Swap Space
3. The remainder of the drive as an ext4 (root partition)

The script installs grub and intel-ucode drivers after finishing.

To download:
git clone --bare https://github.com/RoyWilliamsIV/arch-install
