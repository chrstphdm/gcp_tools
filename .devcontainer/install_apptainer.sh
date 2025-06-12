#!/bin/bash

set -e

export VERSION=1.2.5
export GOPATH=/opt/go
export PATH=$GOPATH/bin:$PATH

# Install Go (requis pour Apptainer)
cd /tmp
wget https://go.dev/dl/go1.20.5.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.20.5.linux-amd64.tar.gz
export PATH=/usr/local/go/bin:$PATH

# Clone and build Apptainer
cd /tmp
git clone https://github.com/apptainer/apptainer.git
cd apptainer
git checkout v$VERSION
./mconfig && \
  make -C builddir && \
  make -C builddir install

# verification
apptainer --version

# Create ~/.local/bin and add to PATH
mkdir -p /home/vscode/.local/bin
echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/vscode/.bashrc

# Create wrapper for gsutil
cat << 'EOF' > /home/vscode/.local/bin/gsutil
#!/bin/bash
# Wrapper to run gsutil via Apptainer image
IMG="oras://community.wave.seqera.io/library/gsutil:5.34--7830d4f50eb3a75e"
apptainer exec "$IMG" gsutil "$@"
EOF
# Create wrapper for terraform & providers
cat << 'EOF' > /home/vscode/.local/bin/terraform
#!/bin/bash
# Wrapper to run terraform via Apptainer image
# terraform=1.12.1
# terraform-provider-google=6.38.0
# terraform-provider-openstack=1.31.0
# terraform-provider-ovh=0.9.0
IMG="oras://community.wave.seqera.io/library/terraform-provider-google_terraform-provider-openstack_terraform-provider-ovh_terraform:db22f0828efa0d1a"
apptainer exec "$IMG" terraform "$@"
EOF



chmod +x /home/vscode/.local/bin/gsutil
chown vscode:vscode /home/vscode/.local/bin/gsutil
chmod +x /home/vscode/.local/bin/terraform
chown vscode:vscode /home/vscode/.local/bin/terraform
