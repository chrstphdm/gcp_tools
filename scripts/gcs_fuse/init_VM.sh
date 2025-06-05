#!/bin/bash

BUCKET=$1
MOUNT_POINT=$2

. /etc/os-release
echo "deb https://packages.cloud.google.com/apt gcsfuse-${VERSION_CODENAME} main" \
  | sudo tee /etc/apt/sources.list.d/gcsfuse.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo ">>> Mise à jour avant installation de gcsfuse..."
apt-get update -y

echo ">>> Installation de gcsfuse..."
DEBIAN_FRONTEND=noninteractive apt-get install -y gcsfuse

sed -i 's/#user_allow_other/user_allow_other/' /etc/fuse.conf || true

################################################################
# change the ownership of the directory to the current user
sudo chown -R $USER:$USER "${MOUNT_POINT}"
# if many users need to access the directory, you can change the ownership to nobody:nogroup
# sudo chown -R nobody:nogroup "${MOUNT_POINT}"
# if necessary, change the permissions of the directory to allow read/write access
sudo chmod -R 777 "${MOUNT_POINT}"
################################################################
# can also use a dedicated group for the filestore
# sudo groupadd filestore-users
# sudo usermod -aG filestore-users $USER
# sudo chown -R root:filestore-users "${MOUNT_POINT}"
# sudo chmod -R 775 "${MOUNT_POINT}"
################################################################

gcsfuse --implicit-dirs -o allow_other "${BUCKET}" "${MOUNT_POINT}"