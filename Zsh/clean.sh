#!/bin/sh
set -euo pipefail
sudo rm -rf /tmp/*
sudo journalctl --vacuum-time=1

# Shell history
rm -f ~/.zsh_history
rm -f ~/.bash_history

# KDE Cache
rm -rf ~/.cache
rm -rf ~/.local/share/Trash/*

# Other Cache
yay -Scc
yay -Yc
rm -f ~/.ipython/profile_default/history.sqlite
