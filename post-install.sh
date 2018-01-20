# install network utilites
pacman -S iw wpa_supplicant dialog

# install intel-ucode and grub packages
pacman -S intel-ucode grub

# install grub
grub-install /dev/sda

# generate config file
grub-mkconfig -o /boot/grub/grub.cfg

# remind user to set new password
echo "Install finished - please remember to set new root password using passwd."
