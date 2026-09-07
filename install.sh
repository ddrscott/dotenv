#!/bin/sh
# Bootstrap a new machine (macOS, Ubuntu, or Ubuntu under WSL).
#
#   curl -fsSL https://raw.githubusercontent.com/ddrscott/ddrscott/master/install.sh | sh
#
# What it does: installs git + chezmoi, clones this repo to ~/ddrscott, then runs
# `chezmoi init --apply`, which lays down dotfiles and runs home/run_* scripts
# (packages, toolchains, services, repo clones) in order.
#
# Before running, copy the age key to ~/.config/chezmoi/key.txt if you want the
# encrypted secrets (ssh keys, rclone.conf, local.zsh) applied on this pass.
# Without it they are skipped; copy the key later and run `chezmoi apply` again.
set -e

REPO_SSH="git@github.com:ddrscott/ddrscott.git"
REPO_HTTPS="https://github.com/ddrscott/ddrscott.git"
DOTS="$HOME/ddrscott"
export PATH="$HOME/.local/bin:/opt/homebrew/bin:$PATH"

case "$(uname -s)" in
  Darwin)
    xcode-select -p >/dev/null 2>&1 || { echo "==> Installing Xcode command line tools (rerun after it finishes)"; xcode-select --install; exit 0; }
    if ! command -v brew >/dev/null 2>&1; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    command -v chezmoi >/dev/null 2>&1 || brew install chezmoi age
    ;;
  Linux)
    if ! command -v git >/dev/null 2>&1 || ! command -v curl >/dev/null 2>&1; then
      sudo apt-get update -q && sudo apt-get install -y -q git curl ca-certificates
    fi
    command -v chezmoi >/dev/null 2>&1 || sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
    command -v age >/dev/null 2>&1 || sudo apt-get install -y -q age
    ;;
  *) echo "Unsupported OS: $(uname -s)" >&2; exit 1;;
esac

if [ -d "$DOTS/.git" ]; then
  echo "==> Updating $DOTS"; git -C "$DOTS" pull -q --ff-only || true
else
  echo "==> Cloning dotfiles"
  git clone -q "$REPO_SSH" "$DOTS" 2>/dev/null || git clone -q "$REPO_HTTPS" "$DOTS"
fi

[ -f "$HOME/.config/chezmoi/key.txt" ] || echo "==> No age key at ~/.config/chezmoi/key.txt; encrypted secrets will be skipped this pass"

echo "==> chezmoi init --apply"
chezmoi init --source "$DOTS" --apply
echo "==> Done. Start a new shell: exec zsh"
