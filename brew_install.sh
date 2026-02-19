#!/bin/bash -ev
# Updated: 2025-02
# Casks (GUI apps)
brew install --cask \
  android-platform-tools \
  dbeaver-community \
  fork \
  google-cloud-sdk \
  handbrake \
  imageoptim \
  obs \
  rectangle \
  slack \
  vivaldi \
  vlc

# CLI tools
brew install \
  asciinema \
  bat \
  coreutils \
  delta \
  entr \
  eza \
  fd \
  ffmpeg \
  fswatch \
  fzf \
  go \
  htop \
  imagemagick \
  jq \
  kubectl \
  helm \
  kind \
  neovim \
  pv \
  ripgrep \
  rustup \
  scrcpy \
  sox \
  telnet \
  tmux \
  tree \
  uv \
  watch \
  wget \
  zoxide

# Optional: uncomment if needed
# brew install gradle maven mono

brew install hashicorp/tap/terraform
