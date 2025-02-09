#!/bin/bash



lsblk
sudo fdisk /dev/sdb
lsblk
sudo mkfs.ext4 /dev/sdb1
sudo mkdir /mnt/data
sudo chown -R chdem:chdem /mnt/data
sudo chmod -R 777 /mnt/data
sudo mount /dev/sdb1 /mnt/data
sudo nano /etc/fstab
# add "/dev/sdb1   /mnt/data   ext4   defaults   0   0"
sudo umount /mnt/data
sudo systemctl daemon-reload
sudo mount -a
sudo chown -R chdem:chdem /mnt/data
sudo chmod -R 777 /mnt/data
touch /mnt/data/test