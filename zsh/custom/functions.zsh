function set_nvr {
  export NVIM_LISTEN_ADDRESS=`nvr --serverlist | sed '/^$/d' | head -1`
}

function httpd {
  http_port=8000
  open http://localhost:$http_port
  ruby -run -e httpd $@ -p $http_port
}

function cd {
  builtin cd "$@" && tree -L 1
}

function tail_logs {
  # Make some colors
  ANSI_CLEAR=`echo  -e '\\033[0;0m'`
  ANSI_RED=`echo    -e '\\033[1;31m'`  # bold
  ANSI_BELL=`echo   -e '\\007'`

  # Make some patterns
  RE_UUID='[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'
  RE_SESSION='[0-9a-f]{32}'

  # Loud errors and remove noisy tags
  tail -F `find . -name '*.log' | grep -v WARN` | sed -E -e "s/\|$RE_SESSION//g" -e "s/\|$RE_UUID//g" -e "s/(ERROR|FATAL)/$ANSI_RED\1$ANSI_CLEAR$ANSI_BELL/"
}

# say_fortune
function say_fortune {
  FORT=`fortune`
  (echo $FORT | cowsay -f head-in)
  (echo $FORT | say &)
}


# Default `fold` to screen width and break at spaces
function fold {
  if [ $# -eq 0 ]; then
    /usr/bin/fold -w $COLUMNS -s
  else
    /usr/bin/fold $*
  fi
}

# Use `fzf` against system dictionary
function spell {
  cat /usr/share/dict/words | fzf --preview 'wn {} -over | fold' --preview-window=up:60%
}

# Lookup definition of word using `wn $1 -over`.
# If $1 is not provided, we'll use the `spell` command to pick a word.
#
# Requires:
#   brew install wordnet
#   brew install fzf
function dic {
  if [ $# -eq 0 ]; then
    wn `spell` -over | fold
  else
    wn $1 -over | fold
  fi
}

# Lookup synonym of word using `wn $1 -synsn - synsa`.
# If $1 is not provided, we'll use the `spell` command to pick a word.
#
# Requires:
#   brew install wordnet
#   brew install fzf
function syn {
  if [ $# -eq 0 ]; then
    wn `spell` -synsn -synsa | fold
  else
    wn $1 -synsn -synsa | fold
  fi
}

