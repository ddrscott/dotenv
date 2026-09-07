# Cross-platform shims so the rest of the config can call mac names everywhere.
# Loaded early (001-) so later custom files can rely on open/pbcopy/pbpaste.

case "$OSTYPE" in
  linux*)
    if grep -qi microsoft /proc/version 2>/dev/null; then
      export IS_WSL=1
      open() { for f in "$@"; do wslview "$f" 2>/dev/null || explorer.exe "$(wslpath -w "$f")"; done }
      pbcopy()  { clip.exe }
      pbpaste() { powershell.exe -NoProfile -Command Get-Clipboard | tr -d '\r' }
    else
      open() { xdg-open "$@" >/dev/null 2>&1 & }
      if command -v wl-copy >/dev/null 2>&1 && [ -n "$WAYLAND_DISPLAY" ]; then
        pbcopy()  { wl-copy }
        pbpaste() { wl-paste --no-newline }
      else
        pbcopy()  { xclip -in -selection clipboard }
        pbpaste() { xclip -out -selection clipboard }
      fi
    fi
    notify() { notify-send "Shell Notify" "$1" 2>/dev/null || echo "$1" }
    # Ubuntu renames these two
    command -v fdfind >/dev/null && ! command -v fd  >/dev/null && alias fd=fdfind
    command -v batcat >/dev/null && ! command -v bat >/dev/null && alias bat=batcat
    ;;
  darwin*)
    notify() { osascript -e "display notification \"$1\" with title \"Shell Notify\"" }
    type git >/dev/null 2>&1 && git config --global web.browser open
    ;;
esac

# Repo-local scripts (unfence, recent, idle_then, ...)
export PATH="$PATH:${ZSH_CUSTOM:h:h}/bin"
