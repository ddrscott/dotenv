function man {
  PAGER='' /usr/bin/man $* | col -b -x | \
    vim -R -c "let \$PAGER=''" -c 'set ft=man statusline='''' nomod nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'nmap K :Man <C-R>=expand(\"<cword>\")<CR><CR>' -
}
