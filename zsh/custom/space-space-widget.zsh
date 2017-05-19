space-space-widget(){
  zle self-insert;
  BUFFER += ' '
  zle fzf-file-widget
}
zle -N space-space-widget
bindkey '  ' space-space-widget
