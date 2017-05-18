v-space-widget(){
  zle self-insert;
  if [[ $LBUFFER == 'v ' ]]; then
    zle fzf-file-widget && zle accept-line
  fi
}
zle -N v-space-widget
bindkey ' ' v-space-widget
