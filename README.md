# gcp_tools

This repository provides a collection of shell scripts to help set up
common tools on Google Compute Engine VMs.

All scripts are stored in the `scripts/` directory and grouped by the
tool they configure.

## Directory overview

- `scripts/apptainer/init_VM.sh` – install Apptainer
- `scripts/gcs_fuse/init_VM.sh` – install and configure gcsfuse
- `scripts/nextflow/init_VM.sh` – install Nextflow
- `scripts/nfs_share/init_filestore.sh` – create a Filestore instance
- `scripts/nfs_share/init_VM.sh` – mount the NFS share on a VM
- `scripts/nfs_share/format_and_mount.sh` – format and mount an attached disk

Adapt the scripts as needed for your project settings before running them.
