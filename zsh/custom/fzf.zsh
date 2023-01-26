# FZF Stuff
if [ -f ~/.fzf.zsh ] ; then
source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg -l . --hidden'
export FZF_HIGHLIGHT_PREVIEW_OPTS="--height 100% --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null' --preview-window=right:60%"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--delimiter '/' --nth=-1 $FZF_HIGHLIGHT_PREVIEW_OPTS"
export FZF_CTRL_R_COMMAND=$FZF_DEFAULT_COMMAND
#export FZF_CTRL_R_OPTS="--sort --exact --height 100% --preview 'echo {} | cut -d \" \" -f2' --preview-window=up:40%"
export FZF_CTRL_R_OPTS="--exact --height 100%"
fi
