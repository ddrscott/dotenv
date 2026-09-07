# Dotfiles

Scott Pierce's environment, managed by [chezmoi](https://chezmoi.io). One repo
bootstraps macOS, native Ubuntu, and Ubuntu under WSL.

## New machine

```sh
# 1. (optional, for secrets) copy the age key from an existing machine
mkdir -p ~/.config/chezmoi && scp old-box:~/.config/chezmoi/key.txt ~/.config/chezmoi/key.txt

# 2. bootstrap
curl -fsSL https://raw.githubusercontent.com/ddrscott/ddrscott/master/install.sh | sh

# with the full ~/code checkout (259 repos)
curl -fsSL https://raw.githubusercontent.com/ddrscott/ddrscott/master/install.sh | CLONE_CODE=1 sh
```

`install.sh` installs git and chezmoi, clones this repo to `~/ddrscott`, and runs
`chezmoi init --apply`. That lays down the dotfiles and runs the scripts in
`home/run_*` in order:

| script | does |
|---|---|
| `10-packages` | Homebrew `Brewfile` on mac; `apt.txt` + `ubuntu-extras.sh` (+ `ubuntu-desktop.sh` when not WSL) on Ubuntu |
| `20-toolchains` | oh-my-zsh, tinted-shell, uv + `uv-tools.txt`, nvm + node 22 + `npm-globals.txt`, rustup, bun, deno, rbenv, ollama (linux) |
| `30-services` | `~/life` R2 bisync as a launchd agent (mac) or systemd user timer (Ubuntu); skipped on WSL |
| `40-clone-repos` | `~/.claude`, `~/.config/nvim`, `~/life`, and optionally everything in `code-repos.txt` |

The `onchange` scripts re-run when their manifest changes, so editing `packages/Brewfile`
and running `chezmoi apply` installs the new package everywhere.

Windows itself gets GUI apps from `packages/winget.json`:

```powershell
winget import -i packages\winget.json --accept-package-agreements --accept-source-agreements
```

then does everything else inside WSL with the Linux path above.

## Layout

```
.chezmoiroot        -> "home"; chezmoi only manages what is under home/
home/               chezmoi source state (dot_zshrc.tmpl, dot_tmux.conf, run_* scripts, encrypted secrets)
zsh/custom/         oh-my-zsh custom dir, referenced in place by ~/.zshrc
zsh/themes/         prompt theme, symlinked into ~/.oh-my-zsh/themes
packages/           Brewfile, apt.txt, ubuntu-*.sh, npm-globals.txt, uv-tools.txt, winget.json, code-repos.txt
services/           launchd plist + systemd unit for the life bisync (__HOME__ substituted at apply)
bin/                scripts on PATH (recent, unfence, idle_then, ...)
tmux-osx.conf, tmux-linux.conf, karabiner/, iterm2/, duckdb/, applescript/
```

## Day to day

```sh
chezmoi edit ~/.zshrc      # edits home/dot_zshrc.tmpl
chezmoi diff               # what apply would change
chezmoi apply              # write targets, run changed scripts
chezmoi add --encrypt ~/.ssh/new-key
chezmoi cd                 # jump to ~/ddrscott, commit, push
```

Files under `zsh/custom/` are sourced directly from the repo, so those edits are live
without an apply.

## Secrets

Encrypted with [age](https://age-encryption.org). The public recipient is in
`home/.chezmoi.toml.tmpl`; the private identity lives only at
`~/.config/chezmoi/key.txt` on each machine and is never committed. Without the key,
`.chezmoiignore` skips the encrypted files and everything else still applies.

Managed secrets: `~/.zsh/local.zsh` (API keys, sourced by `zsh/custom/z998-local.zsh`),
`~/.netrc`, `~/.pgpass`, `~/.config/rclone/rclone.conf`, `~/.ssh/config`, and the
daily-use SSH keys. Service-account JSON files and one-off `.pem` keys are
deliberately not here; move them by hand when a project needs them.

## Refreshing manifests from a live machine

```sh
brew bundle dump --force --file=packages/Brewfile --no-vscode
npm ls -g --depth=0 --parseable | tail -n +2 | xargs -n1 basename | grep -vE '^(npm|corepack)$' | sort > packages/npm-globals.txt
uv tool list | grep -E '^[a-z]' | awk '{print $1}' | sort > packages/uv-tools.txt
for d in ~/code/*/; do r=$(git -C "$d" remote get-url origin 2>/dev/null) && echo "$(basename "$d") $r"; done | sort > packages/code-repos.txt
```
