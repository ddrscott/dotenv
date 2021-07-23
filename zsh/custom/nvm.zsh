function nvm {
  unset -f -m 'nvm'
  export NVM_DIR="$HOME/.nvm"
  export NVM_DEFAULT_VERSION_PATH=${NVM_DIR}/versions/node/v14.17.3/bin
  if [ -d $NVM_DEFAULT_VERSION_PATH ]; then
    export PATH="${PATH}:${NVM_DEFAULT_VERSION_PATH}"
  elif [ -s "/usr/local/opt/nvm/nvm.sh" ]; then
    source "/usr/local/opt/nvm/nvm.sh"
  fi
  nvm $*
}
