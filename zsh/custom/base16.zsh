# Base16 Shell - terminal color scheme support
# https://github.com/chriskempson/base16-shell

BASE16_SHELL_PATH="$HOME/.config/base16-shell"

if [[ -d "$BASE16_SHELL_PATH" ]]; then
  [[ -s "$BASE16_SHELL_PATH/profile_helper.sh" ]] && \
    source "$BASE16_SHELL_PATH/profile_helper.sh"
fi
