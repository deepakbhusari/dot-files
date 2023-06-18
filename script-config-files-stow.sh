#!/bin/bash

#dot files are in folder ~/dev/dot
# stow configuration files
stow -v zsh
stow -v nvim
stow -v vim
stow -v starship
stow -v skhd
stow -v yabai
#This will copy files to /etc/data folder (-t option)
#stow -t /etc/data vim

