#!/bin/bash

# mount main partition
mount /dev/sda3 /mnt

# start main installation
pacstrap /mnt base
