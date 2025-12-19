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

read -p "Install configs? (Y/n) " conf_resp
if [[ $conf_resp != "y" && $conf_resp != "Y" && -n $conf_resp ]]; then
    echo "Skipping configs."
else
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
fi


read -p "Install themes? (Y/n) " theme_resp
if [[ $theme_resp != "y" && $theme_resp != "Y" && -n $theme_resp ]]; then
    echo "Skipping themes."
    exit 1
fi

plasma_theme_path="$script_path/themes/plasma"
themes=()
for file in "$plasma_theme_path/"*; do
    if [[ -d $file ]]; then
        themes+=("$(basename $file)")
    fi
done

echo "Available themes: "

for i in ${!themes[@]}; do
    echo "$i) ${themes[$i]}"
done

read -p "Install all or some? (all/some) " amount
if [[ $amount == "all" ]]; then
    echo "All themes will be installed."
elif [[ $amount == "some" ]]; then
    echo "You will pick which themes to install."
    # Not implemented yet
else
    echo "Input not recognized. Install cancelled."
    exit 1
fi

mkdir -p "$HOME/.local/share/color-schemes"
mkdir -p "$HOME/.local/share/icons"
mkdir -p "$HOME/.local/share/plasma/look-and-feel"

# TODO wallpapers hardcoded in, make per-theme in later fix.
mkdir -p $HOME/Pictures/wallpapers/hitech
cp $script_path/themes/wallpapers/* $HOME/Pictures/wallpapers/hitech

icon_offset=".local/share/icons/"
color_offset=".local/share/color-schemes/"
theme_offset=".local/share/plasma/look-and-feel/"
for theme in ${themes[@]}; do
    if [[ $amount == "some" ]]; then
        read -p "Install theme $theme? (Y/n) " resp
        if [[ $resp == "n" || $resp == "N" ]]; then
            continue
        fi
    fi

    echo "$HOME/$icon_offset"
    echo "$script_path/themes/plasma/$theme/$icon_offset"

    # Icons, color scheme, overall theme.
    # Will improve copying mechanism later
    # Plasma is really bad when it comes to themes and symlinks so we must copy instead of link.
    #ln -fs "$script_path/themes/plasma/$theme/$icon_offset/$theme" "$HOME/$icon_offset"
    #ln -fs "$script_path/themes/plasma/$theme/$color_offset/$theme.colors" "$HOME/$color_offset"
    #ln -fs "$script_path/themes/plasma/$theme/$theme_offset/$theme" "$HOME/$theme_offset"

    cp -r "$script_path/themes/plasma/$theme/$icon_offset/$theme" "$HOME/$icon_offset"
    cp -r "$script_path/themes/plasma/$theme/$color_offset/$theme.colors" "$HOME/$color_offset"
    cp -r "$script_path/themes/plasma/$theme/$theme_offset/$theme" "$HOME/$theme_offset"
done

echo Finished installing. Thank you and enjoy!
