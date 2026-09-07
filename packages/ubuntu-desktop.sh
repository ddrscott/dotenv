#!/bin/bash
# GUI apps for a native Ubuntu desktop. Not run under WSL.
set -euo pipefail
USER="${USER:-$(id -un)}"   # unset under sudo -u and in containers
have() { command -v "$1" >/dev/null 2>&1; }
KEYRINGS=/etc/apt/keyrings

sudo apt-get install -y -q kitty flameshot fonts-jetbrains-mono fonts-firacode vlc audacity gimp inkscape obs-studio

# keyd: caps lock -> esc (tap) / ctrl (hold), the Karabiner replacement
if ! have keyd; then
  sudo add-apt-repository -y ppa:keyd-team/ppa && sudo apt-get update -q && sudo apt-get install -y -q keyd
fi
sudo mkdir -p /etc/keyd
sudo tee /etc/keyd/default.conf >/dev/null <<'KEYD'
[ids]
*

[main]
capslock = overload(control, esc)
KEYD
sudo systemctl enable --now keyd
sudo keyd reload || true

# Chrome
if ! have google-chrome; then
  curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o $KEYRINGS/google-chrome.gpg
  echo "deb [arch=amd64 signed-by=$KEYRINGS/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list >/dev/null
  sudo apt-get update -q && sudo apt-get install -y -q google-chrome-stable
fi
# VS Code
if ! have code; then
  curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o $KEYRINGS/microsoft.gpg
  echo "deb [arch=amd64,arm64 signed-by=$KEYRINGS/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
  sudo apt-get update -q && sudo apt-get install -y -q code
fi
# Electron apps that only ship as snaps or .debs
have snap && sudo snap install slack discord obsidian --classic 2>/dev/null || true
if ! have claude-desktop && ! [ -d /opt/Claude ]; then echo "   Claude desktop: download the .deb from https://claude.ai/download"; fi
echo "   zoom: https://zoom.us/download?os=linux   dbeaver: sudo snap install dbeaver-ce"
