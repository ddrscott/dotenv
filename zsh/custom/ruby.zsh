if command -v rv &> /dev/null; then
  # https://github.com/spinel-coop/rv
  autoload -U add-zsh-hook
  _rv_autoload_hook () {
      eval "$(rv shell env zsh)"
  }
  add-zsh-hook chpwd _rv_autoload_hook
  _rv_autoload_hook
fi
