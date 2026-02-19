# FZF configuration
# Supports: brew install fzf, git clone ~/.fzf, or native (0.48+)

# Shell integration (order: native > brew > git clone)
if command -v fzf &>/dev/null && fzf --zsh &>/dev/null 2>&1; then
  eval "$(fzf --zsh)"
elif [[ -f "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/fzf/shell/completion.zsh" ]]; then
  source "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/fzf/shell/completion.zsh"
  source "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/fzf/shell/key-bindings.zsh"
elif [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi

# File listing: fd (fast) > rg (fallback)
if command -v fd &>/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
else
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Preview: bat (pretty) > cat (fallback)
if command -v bat &>/dev/null; then
  export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}' --preview-window=right:60%"
else
  export FZF_CTRL_T_OPTS="--preview 'head -500 {}' --preview-window=right:60%"
fi

# History search
export FZF_CTRL_R_OPTS="--exact --height 50%"
