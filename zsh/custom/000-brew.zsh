# Homebrew
if [ -d /opt/homebrew/bin ]; then
  export HOMEBREW_INSTALL_FROM_API=1
  export PATH=/opt/homebrew/bin:$PATH

  local sources=(
    "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
    "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
  )
  for s in ${sources[@]}; do
    if [ -f $s ]; then source "${s}"; fi
  done

  if [ type podman >/dev/null 2>&1 ]; then alias docker=podman; fi
  if [ type podman-compose >/dev/null 2>&1 ]; then alias 'docker-compose'='podman-compose'; fi
fi
