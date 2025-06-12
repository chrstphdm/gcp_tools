FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  build-essential \
  libseccomp-dev \
  pkg-config \
  squashfs-tools \
  cryptsetup \
  curl \
  git \
  uuid-dev \
  libgpgme-dev \
  libssl-dev \
  libglib2.0-dev \
  libseccomp-dev \
  wget \
  fuse3 \
  fakeroot \
  && rm -rf /var/lib/apt/lists/*
