# These are some simple install scripts that I've made for my own, personal use.

The scripts are made specifically for a **Thinkpad T60p** to install **Arch Linux**, so many commands are specific to this machine (drivers, graphics, etc).

---

*Feel free to use and modify this, but* ***PLEASE*** *review it for yourself before running it!*

---

It almost exactly follows the install process found on the [Arch Wiki](https://wiki.archlinux.org/index.php/Installation_guide).

The region is set to America/Chicago, and the keyboard layout is en_US.UTF-8. 

It creates three partitions.

1. Small BIOS partition for Grub
2. Swap Space
3. The remainder of the drive as an ext4 (root partition).

The script installs grub and intel-ucode drivers after finishing.

---

*To download:*
```
wget https://raw.githubusercontent.com/RoyWilliamsIV/Arch-Scripts/master/archpad-install.sh
bash archpad-install.sh
```
