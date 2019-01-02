autoload -U add-zsh-hook
load-nvmrc() {
  if ! [ "$(command -v nvm)" ]; then
    # Nothing to do NVM isn't loaded, yet
    return 0
  fi

  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use --delete-prefix
    fi
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
