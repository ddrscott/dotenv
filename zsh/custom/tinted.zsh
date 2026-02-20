# Tinted Shell - terminal color scheme support
# https://github.com/tinted-theming/tinted-shell (successor to base16-shell)

TINTED_SHELL_PATH="$HOME/.config/tinted-theming/tinted-shell"

if [[ -d "$TINTED_SHELL_PATH" ]]; then
  [[ -s "$TINTED_SHELL_PATH/profile_helper.sh" ]] && \
    source "$TINTED_SHELL_PATH/profile_helper.sh"
fi
