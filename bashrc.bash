# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history

# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
  eval "$("$BASE16_SHELL/profile_helper.sh")"


if [ "$TERM" = "cygwin" ]
  # FZF only available in Cygwin :(
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash

  # Neovim only availabing in Cygwin :(
  alias nvim=/c/apps/Neovim/bin/nvim
then

  FRY_HISTORY=$HOME/ddrscott/bash/fzy_history.bash
  [ -f $FRY_HISTORY ] && source $FRY_HISTORY

  alias ipython3="winpty ipython3"
  alias ipython="winpty ipython"
fi
