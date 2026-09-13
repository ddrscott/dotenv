# FZF configuration
# Supports: brew install fzf, apt install fzf, git clone ~/.fzf, or native (0.48+)

# Shell integration (order: native > brew > distro package > git clone).
# Debian and Ubuntu ship fzf 0.38, which predates `fzf --zsh`, and put the
# integration scripts under /usr/share/doc. Their fzf writes a ~/.fzf.zsh that
# calls `fzf --zsh` anyway, so the distro paths must win over that fallback.
if command -v fzf &>/dev/null && fzf --zsh &>/dev/null 2>&1; then
  eval "$(fzf --zsh)"
elif [[ -f "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/fzf/shell/completion.zsh" ]]; then
  source "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/fzf/shell/completion.zsh"
  source "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/fzf/shell/key-bindings.zsh"
elif [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  [[ -f /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh
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
