# CLAUDE.md

Scott Pierce's dotfiles, managed by chezmoi. Bootstraps macOS, Ubuntu, and WSL. See README.md for the install flow and layout.

## How chezmoi is wired here

- `.chezmoiroot` points the source state at `home/`. Everything outside `home/` (zsh/custom, packages/, services/, bin/) is plain repo content that scripts and `~/.zshrc` reference by path.
- The chezmoi `sourceDir` is `~/ddrscott` (set in `home/.chezmoi.toml.tmpl`), so `chezmoi cd` lands in the repo root.
- Templates get `.role` (`mac` | `ubuntu` | `wsl`), `.wsl`, `.lifeSync`, `.cloneCode` from the config template.
- `run_onchange_*` scripts embed a `sha256sum` of the manifest they consume, so changing a manifest re-runs the script on next `chezmoi apply`. `run_after_40-clone-repos` runs on every apply and is idempotent.
- Secrets are `encrypted_*.age` files. Adding one: `chezmoi add --encrypt <path>`. Never commit plaintext keys; `home/.chezmoiignore` skips encrypted targets when `~/.config/chezmoi/key.txt` is absent.

## Editing rules

- Dotfiles that chezmoi manages (`~/.zshrc`, `~/.tmux.conf`, kitty.conf, ...) are edited in `home/` and applied. Do not edit the target in `$HOME`; the next apply overwrites it.
- `~/.zshrc` source is `home/dot_zshrc.tmpl`. Keep macOS-only lines inside `{{ if eq .chezmoi.os "darwin" }}` blocks. Cross-platform shims (`open`, `pbcopy`, `notify`, `fd`/`bat` aliases) live in `zsh/custom/001-os.zsh`, not in the template.
- `zsh/custom/` files are sourced straight from the repo (`ZSH_CUSTOM` points here). Numbered prefixes order them: `000-brew`, `001-os`, ..., `z998-local`, `z999-dotenv`.
- New packages go in the manifest, not in a script: `packages/Brewfile` (mac), `packages/apt.txt` (Ubuntu, apt-available), `packages/ubuntu-extras.sh` (needs a third-party repo or installer), `packages/ubuntu-desktop.sh` (GUI, native Ubuntu only), `packages/winget.json` (Windows GUI).
- Local secrets go in `~/.zsh/local.zsh` and are re-added with `chezmoi add --encrypt ~/.zsh/local.zsh` after editing.

## Verify before committing

```sh
chezmoi doctor
chezmoi diff
chezmoi execute-template < home/run_onchange_before_10-packages.sh.tmpl | bash -n
```

## Notable shell functions (zsh/custom/functions.zsh)

- `yolo` / `rolo` – claude with permissions skipped (rolo via relay)
- `wa`, `ask` – claude one-shots piped through `zsh/custom/claude-stream-fmt`
- `recent [dir] [timeframe]`, `entr_rsync DEST`, `ptable`, `spell`, `dic`, `syn`
