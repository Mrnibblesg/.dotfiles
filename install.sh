#! /bin/bash

# For each file here, make link with same name in $HOME/.config?
# Make sure an existing config isn't about to be overwritten?
# Overwrite links if the link to be set already exists

echo "Mrnibbles' Dotfiles"
ln -s $PWD/nvim $HOME/.config/nvim
ln -s $PWD/kitty $HOME/.config/kitty

