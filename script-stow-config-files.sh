#!/bin/sh

#dot files are in folder ~/dev/dot
# stow configuration files
stow -t ~ -v zsh
stow -t ~ -v nvim
stow -t ~ -v vim
stow -t ~ -v starship
stow -t ~ -v skhd
stow -t ~ -v tmux
stow -t ~ -v yabai
stow -t ~ -v kitty
#This will copy files to /etc/data folder (-t option)
#stow -t /etc/data vim


