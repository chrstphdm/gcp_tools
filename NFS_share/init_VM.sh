#!/bin/bash

# Install NFS client on the VM

# Get the IP address of the filestore instance
IP_ADDRESS=$(gcloud filestore instances describe my-filestore --zone=europe-west1-b \
    --format="value(networks.ipAddresses)" | sed "s/[][]//g" | sed "s/'//g")


sudo apt update && sudo apt install -y nfs-common
sudo mkdir -p /mnt/filestore

# change the ownership of the directory to the current user
sudo chown -R $USER:$USER /mnt/filestore
# if many users need to access the directory, you can change the ownership to nobody:nogroup
# sudo chown -R nobody:nogroup /mnt/filestore
# if necessary, change the permissions of the directory to allow read/write access
sudo chmod -R 777 /mnt/filestore

# can also use a dedicated group for the filestore
# sudo groupadd filestore-users
# sudo usermod -aG filestore-users $USER
# sudo chown -R root:filestore-users /mnt/filestore
# sudo chmod -R 775 /mnt/filestore


sudo mount -o nolock ${IP_ADDRESS}:/reposhare /mnt/filestore

# Add the mount to /etc/fstab
echo "${IP_ADDRESS}:/reposhare /mnt/filestore nfs nfs rw,nosuid,nodev,noatime,nolock" | sudo tee -a /etc/fstab
# remount the filestore
sudo mount -o remount /mnt/filestore
