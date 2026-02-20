#!/bin/sh
# Install ddrscott dotfiles
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/ddrscott/ddrscott/master/install.sh | sh
#   ./install.sh

set -e

REPO_URL="https://github.com/ddrscott/ddrscott.git"
INSTALL_DIR="$HOME/ddrscott"

# Detect if running from within repo or piped from curl
SCRIPT_DIR="$(cd "$(dirname "$0" 2>/dev/null)" && pwd 2>/dev/null)" || SCRIPT_DIR=""

if [ -f "$SCRIPT_DIR/zsh/.zshrc" ]; then
    # Running from within cloned repo
    THIS_DIR="$SCRIPT_DIR"
else
    # Piped from curl - need to clone first
    echo "Cloning ddrscott dotfiles..."

    if ! command -v git >/dev/null 2>&1; then
        echo "Error: git is required but not installed." >&2
        exit 1
    fi

    if [ -d "$INSTALL_DIR" ]; then
        echo "Updating existing installation..."
        git -C "$INSTALL_DIR" pull --ff-only
    else
        git clone "$REPO_URL" "$INSTALL_DIR"
    fi

    THIS_DIR="$INSTALL_DIR"
fi

echo "Installing dotfiles from $THIS_DIR..."

# Only create symlink if THIS_DIR is not already ~/ddrscott
if [ "$THIS_DIR" != "$HOME/ddrscott" ]; then
    rm -f ~/ddrscott 2>/dev/null || true
    ln -sf "$THIS_DIR" ~/ddrscott
fi
ln -sf "$THIS_DIR/zsh/.zshrc" ~/.zshrc
ln -sf "$THIS_DIR/tmux.conf" ~/.tmux.conf
ln -sf "$THIS_DIR/rg/.rgignore" ~/.rgignore
ln -sf "$THIS_DIR/screen/.screenrc" ~/.screenrc
ln -sf "$THIS_DIR/pry/pryrc.rb" ~/.pryrc

if [ -d ~/.oh-my-zsh/themes ]; then
    ln -sf "$THIS_DIR/zsh/themes/ddrscott.zsh-theme" ~/.oh-my-zsh/themes/ddrscott.zsh-theme
else
    echo "Note: oh-my-zsh not found. Install it with:"
    echo '  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
fi

mkdir -p ~/.ptpython
ln -sf "$THIS_DIR/ptpython/config.py" ~/.ptpython/config.py

# tinted-shell for terminal color schemes (successor to base16-shell)
TINTED_SHELL_DIR="$HOME/.config/tinted-theming/tinted-shell"
if [ -d "$TINTED_SHELL_DIR" ]; then
    echo "Updating tinted-shell..."
    git -C "$TINTED_SHELL_DIR" pull --ff-only
else
    echo "Installing tinted-shell..."
    mkdir -p "$HOME/.config/tinted-theming"
    git clone https://github.com/tinted-theming/tinted-shell.git "$TINTED_SHELL_DIR"
fi

echo "Done! Restart your shell or run: source ~/.zshrc"
