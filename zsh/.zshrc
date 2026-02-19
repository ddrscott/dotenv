# Add deno completions to search path
if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then export FPATH="$HOME/.zsh/completions:$FPATH"; fi
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="ddrscott"
ZSH_CUSTOM=~/ddrscott/zsh/custom
COMPLETION_WAITING_DOTS="true"
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:$PATH"

plugins=(git dotenv fancy-ctrl-z rake-fast docker kubectl thor)

source $ZSH/oh-my-zsh.sh

unsetopt auto_cd

export KEYTIMEOUT=20

export EDITOR=vim
export ECLIPSE_HOME=/Applications/Eclipse.app/Contents/Eclipse

[ -f /usr/libexec/java_home ] && export JAVA_HOME="$(/usr/libexec/java_home -v 12)"

export AWS_REGION='us-east-1'

export GOPATH=$HOME/golang
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/opt/homebrew/bin

# Crystal Stuff
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig

export GRADLE_OPTS=-Dorg.gradle.daemon=true

# Path shortcuts
export blog=~/code/octopress/
export c=~/code/
export cmm=~/code/cmm/
export n=~/notes/
export sp=~/code/sql_probe/
export v=~/.config/nvim/

# Codesign
export CODESIGN_APP_CNAME='Developer ID Application: Scott Pierce (DH6NDWAQQ2)'
export CODESIGN_INSTALL_CNAME='Developer ID Installer: Scott Pierce (DH6NDWAQQ2)'

type git >/dev/null 2>&1 && git config --global web.browser open

# Disable spell completion when ESC is pressed (macOS)
# https://discussions.apple.com/thread/7311015
if [[ $OSTYPE == darwin* ]]; then
  defaults write -g NSUseSpellCheckerForCompletions -bool false
  defaults write -g ApplePressAndHoldEnabled -bool false
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Put custom bin paths ahead of everything
export PATH=$PATH:~/bin:./bin:./exe:~/.local/bin

# If interactive, not already in Tmux, and tmux installed try to attach to it
export TMUX_SESSION_PATH=/tmp/pair
[ -n "$PS1" ] && [ -z "$TMUX" ] && type tmux >/dev/null 2>&1 && [ -f $TMUX_SESSION_PATH ] && tmux -S $TMUX_SESSION_PATH attach


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

export GPG_TTY=$(tty)

# Completions
fpath+=~/.zfunc
autoload -Uz compinit
zstyle ':completion:*' menu select
compinit

# Language environments
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"
