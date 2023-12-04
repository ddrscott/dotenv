if [[ -d "$HOME/.nvm/versions/node/" ]]; then
  local latest_dir=$(ls -d1 "$HOME/.nvm/versions/node/"* | tail -1)
  export PATH="$latest_dir/bin:$PATH"
  export NVM_DIR=$HOME/.nvm
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" --no-use
fi
