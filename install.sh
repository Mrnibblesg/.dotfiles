#! /bin/bash

# For each file here, make link with same name in $HOME/.config?
# Make sure an existing config isn't about to be overwritten?

echo "Mrnibbles' Dotfiles"
ln -s $PWD/nvim $HOME/.config/nvim
