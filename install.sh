#!/usr/bin/env bash

set -e
THIS_DIR="$(cd $(dirname $0) &>/dev/null && pwd && cd - &>/dev/null)"

ln -sf "${THIS_DIR}" ~/ddrscott
ln -sf "${THIS_DIR}/zsh/.zshrc" ~/.zshrc
ln -sf "${THIS_DIR}/tmux.conf" ~/.tmux.conf
ln -sf "${THIS_DIR}/ag/.agignore" ~/.agignore
ln -sf "${THIS_DIR}/screen/.screenrc" ~/.screenrc
ln -sf "${THIS_DIR}/pry/pryrc.rb" ~/.pryrc

[ -d '~/.oh-my-zsh/themes' ] && ln -sf "${THIS_DIR}/zsh/themes/ddrscott.zsh-theme" ~/.oh-my-zsh/themes/ddrscott.zsh-theme

mkdir -p ~/.ptpython
ln -sf "${THIS_DIR}/ptpython/config.py" ~/.ptpython/config.py
