#! /bin/bash
set -eu

# To tackle the problem of configs needing to go into various locations:
#  - Directory as a package organization. Inside the dotfiles repo, each package or set of configs mimic the home directory structure with the places they need to go.
configs=("nvim" "kitty" "onedrive" "kglobalshortcutsrc")
config_path=$HOME/.config/
script_path=$(dirname "$(readlink -f "$0")")

echo $script_path
echo Mrnibbles\' Dotfiles. Contains the following configs:
for config in "${configs[@]}"; do
    echo $config
done

read -p "Install configs? (Y/n) " conf_resp
if [[ $conf_resp == "n" || $conf_resp == "N" ]]; then
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
    if [[ $resp == "n" || $resp == "N" ]]; then
        echo "Install cancelled."
        exit 1
    fi

    # Ask the user if config backups should be made.
    backup=
    read -p "Make backup of existing configs before install? (Y/n) " backup
    backup_path="${config_path}.config.backup/"
    if [[ $backup != "n" && $backup != "N" ]]; then
        backup="y"
        echo Necessary backups will be moved to $backup_path
    fi

    # look at using mv -ft instead for backups
    # For recursively listing every file's path in a dir, use find (dir). It'll be clean
    for config in "${configs[@]}"; do
        if [[ $amount == "some" ]]; then
            read -p "Load config for $config? (Y/n) " resp
            if [[ $resp == "n" || $resp == "N" ]]; then
                continue
            fi
        fi
        if [[ -e "${config_path}${config}" && $backup == "y" ]]; then
            timestamp=$(date +%Y-%m-%d-%H-%M-%S)
            echo ${config_path}${config} exists. backing up to ${backup_path}${config}-${timestamp}.

            if ! [[ -d $backup_path ]]; then
                mkdir -p $backup_path
            fi
            mv -f "${config_path}${config}" "${backup_path}${config}-${timestamp}"
        fi

        # When should we link the whole directory as opposed to every single file?
        ln -fns "$script_path/configs/.config/${config}" "${config_path}${config}"
        
        echo Loaded config "${config_path}${config}"
    done
fi


# Invariably the themes will be coupled to the DE they were made for.
# TODO Figure out wtf I'm doing when users are on a different DE or something
read -p "Install themes? (Y/n) " theme_resp
if [[ $theme_resp == "n" || $theme_resp == "N" ]]; then
    echo "Skipping themes."
    exit 0
else

    plasma_theme_path="$script_path/themes/plasma"
    themes=()
    for file in "$plasma_theme_path/"*; do
        if [[ -d $file ]]; then
            themes+=("$(basename $file)")
        fi
    done

    echo "Available themes: "

    for i in "${!themes[@]}"; do
        echo "$i) ${themes[$i]}"
    done

    #read -p "Install all or some? (all/some) " amount
    #if [[ $amount == "all" ]]; then
    #    echo "All themes will be installed."
    #elif [[ $amount == "some" ]]; then
    #    echo "You will pick which themes to install."
    #else
    #    echo "Input not recognized. Install cancelled."
    #    exit 1
    #fi
    echo "Installing all plasma themes."

    mkdir -p "$HOME/.local/share/color-schemes"
    mkdir -p "$HOME/.local/share/icons"
    mkdir -p "$HOME/.local/share/plasma/look-and-feel"

    # Install links to all wallpapers.
    # Maybe in the future I can associate groups of wallpapers to a theme so I don't explode the wallpapers of anyone who installs my themes
    mkdir -p ~/.local/share/wallpapers
    ln -fns $script_path/themes/wallpapers/*/ ~/.local/share/wallpapers/

    icon_offset=".local/share/icons/"
    color_offset=".local/share/color-schemes/"
    theme_offset=".local/share/plasma/look-and-feel/"
    for theme in "${themes[@]}"; do
        if [[ $amount == "some" ]]; then
            read -p "Install theme $theme? (Y/n) " resp
            if [[ $resp == "n" || $resp == "N" ]]; then
                continue
            fi
        fi

        # Icons, color scheme, overall theme.
        ln -fns "$script_path/themes/plasma/$theme/$icon_offset/$theme" "$HOME/$icon_offset"
        ln -fns "$script_path/themes/plasma/$theme/$color_offset/$theme.colors" "$HOME/$color_offset"
        ln -fns "$script_path/themes/plasma/$theme/$theme_offset/$theme" "$HOME/$theme_offset"
    done
fi

echo Finished installing. Thank you and enjoy!
