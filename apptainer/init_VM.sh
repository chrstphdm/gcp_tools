#!/bin/bash

set -e

sudo add-apt-repository -y ppa:apptainer/ppa
sudo apt-get update -y
sudo apt-get install -y apptainer


sudo echo "kernel.apparmor_restrict_unprivileged_userns = 0" > /etc/sysctl.d/99-userns.conf
sudo sysctl --system