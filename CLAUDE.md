# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is Scott Pierce's personal dotfiles repository. It manages shell configuration, editor settings, and development tools for macOS via symlinks.

## Installation

```sh
# One-liner for new machines
curl -fsSL https://raw.githubusercontent.com/ddrscott/ddrscott/master/install.sh | sh

# Or run locally after cloning
./install.sh
```

The install script symlinks:
- `zsh/.zshrc` → `~/.zshrc`
- `tmux.conf` → `~/.tmux.conf`
- `rg/.rgignore` → `~/.rgignore`
- `screen/.screenrc` → `~/.screenrc`
- `pry/pryrc.rb` → `~/.pryrc`
- `ptpython/config.py` → `~/.ptpython/config.py`
- `zsh/themes/ddrscott.zsh-theme` → `~/.oh-my-zsh/themes/`

## Architecture

### ZSH Configuration

The shell config uses oh-my-zsh with a custom folder structure:

- `zsh/.zshrc` - Main entry point, sets `ZSH_CUSTOM=~/ddrscott/zsh/custom`
- `zsh/custom/` - All custom configurations (auto-loaded by oh-my-zsh)
  - Files prefixed with numbers load in order (e.g., `000-brew.zsh` first)
  - `z999-dotenv.zsh` loads last
  - `local.zsh` - Local secrets/keys (gitignored)
- `zsh/themes/ddrscott.zsh-theme` - Custom prompt theme

### Key Custom Files

- `aliases.zsh` - Shell aliases (vim→nvim, git shortcuts, fzf integrations)
- `functions.zsh` - Utility functions (httpd, spell, dic, syn, ptable, yolo)
- `fzf.zsh` - FZF configuration
- `gpt.zsh` - AI/GPT related helpers
- `conda.zsh`, `nvm.zsh`, `ruby.zsh` - Language version managers

### Notable Functions

- `yolo` - Run claude with `--dangerously-skip-permissions`
- `recent [dir] [timeframe]` - Find recently modified files using fd
- `entr_rsync DESTINATION` - Watch for changes and rsync to remote
- `ptable` - Browse Postgres tables with FZF
- `spell`, `dic`, `syn` - Dictionary/thesaurus lookups via FZF and wordnet

### Environment Variables

Path shortcuts defined in `.zshrc`:
- `$c` → `~/code/`
- `$n` → `~/notes/`
- `$v` → `~/.config/nvim/`

### bin/ Directory

Custom scripts added to PATH via `~/bin`. Notable:
- `unfence` - Code fence extraction utility

## Conventions

- Store local/secret environment variables in `zsh/custom/local.zsh` (gitignored)
- Numbered prefixes on zsh custom files control load order
- Tmux uses `Ctrl-a` as secondary prefix (in addition to default `Ctrl-b`)
- Editor defaults to neovim (`vim`, `vi`, `v` all alias to `nvim`)
