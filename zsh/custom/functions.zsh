function set_nvr {
  export NVIM_LISTEN_ADDRESS=`nvr --serverlist | sed '/^$/d' | head -1`
}

function httpd {
  http_port=8000
  open http://localhost:$http_port
  ruby -run -e httpd $@ -p $http_port
}

# This was cute for a while, but it was starting to fill up view with
# information I never read.
# function cd {
#   builtin cd "$@" && tree -L 1
# }

function tail_logs {
  # Make some colors
  ANSI_CLEAR=`echo  -e '\\033[0;0m'`
  ANSI_RED=`echo    -e '\\033[1;31m'`  # bold
  ANSI_BELL=`echo   -e '\\007'`

  # Make some patterns
  RE_UUID='[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'
  RE_SESSION='[0-9a-f]{32}'

  # Loud errors and remove noisy tags
  tail -F `find . -name '*.log' | grep -v WARN | grep -v newrelic` | sed -E -e "s/\|$RE_SESSION//g" -e "s/\|$RE_UUID//g" -e "s/(ERROR|FATAL)/$ANSI_RED\1$ANSI_CLEAR$ANSI_BELL/" | ts -i
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

function man {
  if [ $# -eq 0 ]; then
    /usr/bin/man `print -rl -- ${(ko)commands} | fzf --preview 'man {}'`
  else
    /usr/bin/man $*
  fi
}

function gcip {
  gcloud compute instances list --filter="name~$1" --format=json | jq -r '. | map(.networkInterfaces[0].accessConfigs[0].natIP) | join(",")'
}

# Helper to browse Postgres tables using FZF
# 
# Example:
#   ptable -h 35.184.159.193 -U spierce@spins.com curvball
function ptable {
   psql --pset pager --pset tuples_only -Ac '\d' $* | \
       cut -d '|' -f 2 | \
       fzf --preview "psql --pset pager -c 'select * from {} limit 15' -c '\d {}' $*" --preview-window right:80%
}

# Helper view gcs file using FZF
# Example:
#   gsutil -m ls 'gs://spins-edp-uat-incoming/**' > spins-edp-uat-incoming.lst
#   gsfzf spins-edp-uat-incoming.lst  | head -10
function gsfzf {
    selected=$(cat $1 | fzf)
    cmd="gsutil -m cp '$selected' -"
    echo -e "\e[33m$cmd\e[0m" >> /dev/stderr
    eval ${cmd}
}

# A slower tail -f
# Example:
#     cat foo | snail
#     cat bar | snail 0.1
function snail() {
  awk -v s="${1:-'0.3'}" 'system("sleep " s) {exit} 1'
}


# Watch for project changes and rsync to remote destination.
#
# Example:
#    entr_rsync dev-e2:~/app 
function entr_rsync() {
    DST=$1
    [ -n "$DST" ] || { echo "Usage:\n  entr_rsync DESTINATION"; return 1; }
    GLOBAL_GIT_IGNORE="$(git config --global core.excludesFile)"
    RSYNC_CMD="rsync -avz --max-size=100m --exclude '.git' --filter=':- .gitignore' --filter=':- ${GLOBAL_GIT_IGNORE}' . ${DST}"
    while true; do
        git ls-files | entr -c -d -s "${RSYNC_CMD}"
        #    ^           ^   ^  ^  ^
        #    |           |   |  |  |
        #    |           |   |  |  + run shell command
        #    |           |   |  |   
        #    |           |   |  + track directories
        #    |           |   |      
        #    |           |   + clear screen before executing
        #    |           |   |      
        #    |           + [E]vent [N]otify [T]est [R]unner
        #    |             http://eradman.com/entrproject/
        #    |
        #    + list files tracked by git
        sleep 1
    done
}

# function dot_when() {
#   while true; do
#     curl -s http://192.168.86.1/api/v1/status \
#       | grep online \
#       | awk -v pat="${1:-'true'}" '$0 ~ pat {printf("\033[32m.\033[0m")} $0 !~ pat {printf("\033[31m!\033[0m")}'
#   done
# }
#
notify() {
    osascript -e "display notification \"$1\" with title \"Shell Notify\""
}

recent() {
  fd . "${1:-$HOME}" --type f \
    --exclude .git \
    --exclude node_modules \
    --exclude Library \
    --exclude 'Application Support' \
    --exclude 'Photos Library.photoslibrary' \
    --exclude 'TV Library.tvlibrary' \
    --exclude 'Downloads' \
    --changed-within "${2:-7d}" \
    --exec stat -f '%m %N' {} \; | sort -rn | cut -d' ' -f2-
}

# Run claude with --dangerously-skip-permissions, joining all args as prompt.
# Because sometimes you just gotta send it.
#
# Example:
#   yolo                           # interactive mode
#   yolo fix the build errors      # with prompt
yolo() {
  if [ $# -eq 0 ]; then
    claude --dangerously-skip-permissions
  else
    claude --dangerously-skip-permissions -p "$*"
  fi
}
