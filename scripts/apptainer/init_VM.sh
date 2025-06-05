#!/bin/bash

set -e

sudo add-apt-repository -y ppa:apptainer/ppa
sudo apt-get update -y
sudo apt-get install -y apptainer


# Update AppArmor configuration so that unprivileged user namespaces can be used
# The redirection must happen with elevated privileges. Using `sudo echo` would
# still attempt to write the file as the current user because the redirection is
# handled by the shell. Pipe the output to `sudo tee` instead.
echo "kernel.apparmor_restrict_unprivileged_userns = 0" | sudo tee /etc/sysctl.d/99-userns.conf
sudo sysctl --system
