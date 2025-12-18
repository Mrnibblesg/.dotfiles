#! /bin/bash

# To tackle the problem of configs needing to go into various locations:
#  - Directory as a package organization. Inside the dotfiles repo, each package or set of configs mimic the home directory structure with the places they need to go.
configs=("nvim" "kitty" "onedrive")
config_path=$HOME/.config/
script_path=$(dirname "$(readlink -f "$0")")

echo $script_path
echo Mrnibbles\' Dotfiles. Contains the following configs:
for config in ${configs[@]}; do
    echo $config
done

read -p "Install all or some? (all/some) " amount
if [[ $amount == "all" ]]; then
    echo "All configs will be installed."
elif [[ $amount == "some" ]]; then
    echo "You will pick which configs to install."
else
    echo "Input not recognized. Install cancelled."
    exit 1
fi

# Verify installation
read -p "Configs will be placed in $config_path Proceed? (Y/n) " resp
if [[ $resp != "y" && $resp != "Y" && -n $resp ]]; then
    echo "Install cancelled."
    exit 1
fi

# Ask the user if config backups should be made.
read -p "Make backup of existing configs before install? (Y/n) " backup
backup_path="${config_path}.config.bak"
if [[ $backup == "y" || $backup == "Y" || -n $backup ]]; then
    backup="y"
    echo Necessary backups will be moved to $backup_path
fi

# look at using mv -ft instead for backups
# For recursively listing every file's path in a dir, use find (dir). It'll be clean
for config in ${configs[@]}; do
    if [[ $amount == "some" ]]; then
        read -p "Load config for $config? (Y/n) " resp
        if [[ $resp == "n" || $resp == "N" ]]; then
            continue
        fi
    fi

    if [[ -e "${config_path}${config}" && $backup == "y" ]]; then
        echo ${config_path}${config} exists. backing up to $backup_path.

        if ! [[ -d $backup_path ]]; then
            mkdir $backup_path
        fi
        mv -f "${config_path}${config}" $backup_path
    fi
    
    # Mirror everything in the configs path to the home directory.
    # If a directory doesn't exist, it should be made to exist.
    # When should we link the whole directory as opposed to every single file?
    ln -fs "$script_path/configs/.config/${config}" "${config_path}${config}"
    
    echo Loaded config "${config_path}${config}"
done


# INSTALL THEMES
read -p "Install themes? (Y/n) " theme_resp


