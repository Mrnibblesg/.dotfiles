#! /bin/bash

# For each file here, make link with same name in $HOME/.config?
# Make sure an existing config isn't about to be overwritten?
# Overwrite links if the link to be set already exists
configs=("nvim" "kitty" "onedrive")
config_path=$HOME/.config/
script_path=$(dirname "$(readlink -f "$0")")
echo $script_path
echo Mrnibbles\' Dotfiles. Contains the following configs:
for config in ${configs[@]}; do
    echo $config
done

read -p "Configs will be placed in $config_path Proceed? (Y/n) " resp
if [[ $resp != "y" && $resp != "Y" && -n $resp ]]; then
    echo "Install cancelled."
    exit 1
fi
# Ask the user if config backups should be made.
read -p "Make backup of existing configs before install? (Y/n) " resp
backup="${config_path}config.bak"
if [[ $resp == "y" || $resp == "Y" || -n $resp ]]; then
    resp="y"
    echo Necessary backups will be moved to $backup
fi

# look at using mv -ft instead for backups
for config in ${configs[@]}; do
    if [[ -e "${config_path}${config}" && $resp == "y" ]]; then
        echo "${config_path}${config}" exists. backing up...
        if ! [[ -d $backup ]]; then
            mkdir $backup
        fi
        mv -f "${config_path}${config}" $backup
    fi
    ln -fs "$script_path/${config}" "${config_path}${config}"
    echo Loaded config "${config_path}${config}"
done

