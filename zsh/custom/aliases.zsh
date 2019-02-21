alias ssh_inktera='while :; do echo "[$(date)] SSH Connect"; ssh -N -i ~/.ssh/id_rsa spierce@web04.page-foundry.com -L 6379:resque.redis.page-foundry.com:6379 -L 6380:redis.page-foundry.com:6379 -L 3307:prod01.rds.page-foundry.com:3306; done'
alias mm='bundle exec middleman --verbose '
alias be='bundle exec '
alias adp='cd ~/code/adp'
alias t='tree -L 1'
alias gem-tags='ctags --verbose --languages=ruby --recurse -f .tags.gem $(bundle list --paths)'

# Change vi[m] to NeoVim when it's available
if [ -n "$PS1" ] && type nvim >/dev/null 2>&1; then
  alias vim='nvim'
  alias vi='nvim'
  alias v='nvim'
fi

alias won='networksetup -setairportpower en0 on'
alias woff='networksetup -setairportpower en0 off'
alias fcd='cd `find . -type d | fzf`'
alias fgc='git checkout `git branch | fzf`'
alias vims='vim -S Session.vim'
alias gb-point="git log --graph --oneline -99 | grep -A 1 -E '^\* [0-9a-f]{7}' | cut -c 5-11 | tail -1"
alias gb-ls='git --no-pager diff --diff-filter=ACMRTUXB --name-only `gb-point`..'
alias gb-stat='git --no-pager diff --stat `gb-point`..'
alias gbr='git branch --sort=committerdate'
alias gpf='git push --force-with-lease'
alias sed-stat="sed -E 's~ ([^ |]+)([ |])+(.+)~\1:0:0 \3~'"
alias ggpushf='ggpush --force-with-lease'

alias light=base16_solarized-light
alias dark=base16_ocean
alias dict='cat /usr/share/dict/words | fzf --preview "open -g dict://{}; echo See Dictionary.app"'

alias pbc='pbpaste | pbcopy'

type pbcopy > /dev/null 2>&1 || alias pbcopy='xclip -selection clipboard' 
type pbpaste > /dev/null 2>&1 || alias pbpaste='xclip -selection clipboard -o'
# alias python=python2
# alias py=python2
# alias py3='python3 -q -Xfaulthandler'
# alias pip=pip2
