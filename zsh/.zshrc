# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ddrscott"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"
# !! use custom/history.zsh

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/ddrscott/zsh/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fancy-ctrl-z rake-fast dotenv)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/sbin:$PATH"
export PATH=$PATH:./node_modules/.bin
# export PATH=$PATH:~/Library/Python/3.5/bin
# export PATH=$PATH:~/Library/Python/2.7/bin

# export MANPATH="/usr/local/man:$MANPATH"


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export KEYTIMEOUT=20

export EDITOR='/usr/local/bin/nvim'
export ECLIPSE_HOME=/Applications/Eclipse.app/Contents/Eclipse

[ -f /usr/libexec/java_home ] && export JAVA_HOME="$(/usr/libexec/java_home -v 11)"

export AWS_REGION='us-east-1'

export GOPATH=$HOME/golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Rust Stuff
if [ type rustc >/dev/null 2>&1 ]; then
  export PATH=$PATH:~/.cargo/bin
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

# Crystal Stuff
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig

# FZF Stuff
export FZF_DEFAULT_COMMAND='ag -g "" --hidden'
export FZF_HIGHLIGHT_PREVIEW_OPTS="--height 100% --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null' --preview-window=right:60%"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--delimiter '/' --nth=-1 $FZF_HIGHLIGHT_PREVIEW_OPTS"
export FZF_CTRL_R_COMMAND=$FZF_DEFAULT_COMMAND
#export FZF_CTRL_R_OPTS="--sort --exact --height 100% --preview 'echo {} | cut -d \" \" -f2' --preview-window=up:40%"
export FZF_CTRL_R_OPTS="--exact --height 100%"


#export FZF_DEFAULT_OPTS='--exact'
#export LOG_SRC=true
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

type git >/dev/null 2>&1 && git config --global web.browser open

# Colors
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

[ -n "$BASE16_THEME" ] && eval base16_${BASE16_THEME}

# Disable spell completion when ESC is presssed.
#
# Thanks: https://discussions.apple.com/thread/7311015?start=0&tstart=0
if [[ $OSTYPE == darwin* ]]; then
  defaults write -g NSUseSpellCheckerForCompletions -bool false
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH="/usr/local/opt/llvm@5/bin:$PATH"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:$PATH"

type rbenv >/dev/null 2>&1 && eval "$(rbenv init - zsh)"

# Put custom bin paths ahead of everything
export PATH=$PATH:~/bin:./bin:./exe

