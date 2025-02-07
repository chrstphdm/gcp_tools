#!/bin/bash

# Create a new filestore instance

# activate API filestore in the current project
gcloud services enable file.googleapis.com

# create a new filestore instance
# tier: BASIC_HDD, BASIC_SSD, HIGH_SCALE_SSD, STANDARD
gcloud filestore instances create my-filestore \
    --zone=europe-west1-b \
    --tier=STANDARD \
    --file-share=name="reposhare",capacity=1TB \
    --network=name="default"
