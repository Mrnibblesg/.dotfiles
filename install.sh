#! /bin/bash
set -eu # For safety
shopt -s dotglob # Include hidden files in filename expansions

# Files to skip
XDG_SPEC_DIRS=("$HOME/.config" "$HOME/.local" "$HOME/.local/share")

script_path=$(dirname "$(readlink -f "$0")")
timestamp=$(date +%Y-%m-%d-%H-%M-%S)
backup_path="${HOME}/.config/.config.backup/"

echo $script_path
echo Mrnibbles\' Dotfiles. Contains the following configs:
ls "$script_path"/configs

# Find $1 in the rest
contains() {
    needle=$1; shift
    for haystack in "$@"; do
        [[ $haystack == $needle ]] && return 0
    done
    return 1
}

# Installs the given config. It starts by searching for its directory within ./configs.
# Takes the config name as $1.
# Mirrors the inside structure on top of the destination, $2.
install_config() {
    local config=$1
    local dest_dir=$2
    # Recurse through the given config.
    # If a file or directory isn't in the XDG_SPEC_DIRS, we know we should symlink it and to skip its insides (if it's a dir).
    # If anything already exists there and it's not a symlink back to the same config, we skip it.
    for item in "$config"/*; do
        local name=$(basename $item)
        local dest_item=$dest_dir/$name
        if [[ -d $dest_item ]] && contains $dest_item ${XDG_SPEC_DIRS[@]}; then
            install_config $item $dest_item
            continue
        fi
        # It's a file we should place/replace.
        if [[ -e $dest_item ]]; then
            if [[ -L $dest_item && $(readlink -f "$dest_item") == "$script_path"/* ]]; then
                continue
            fi
            # Don't do anything if this is one of our own links.
            local file_backup="${backup_path}${name}-${timestamp}"
            mv -f "$dest_item" $file_backup
            echo "$dest_item already exists. Backing up to $file_backup"
        fi
        echo "Symlinked $dest_item to $item"
        ln -fns $item $dest_item
    done
}

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
    read -p "Configs will be based in "$HOME". Proceed? (Y/n) " resp
    if [[ $resp == "n" || $resp == "N" ]]; then
        echo "Install cancelled."
        exit 1
    fi

    backup=
    read -p "Make backup of existing configs before install? (Y/n) " backup
    if [[ $backup != "n" && $backup != "N" ]]; then
        backup="y"
        echo Necessary backups will be moved to $backup_path
    fi

    # look at using mv -ft instead for backups
    # For recursively listing every file's path in a dir, use find (dir). It'll be clean
    for config in "$script_path/configs/"*; do
        conf_name=$(basename $config)
        
        if [[ $amount == "some" ]]; then
            read -p "Load config for $(basename $config)? (Y/n) " resp
            if [[ $resp == "n" || $resp == "N" ]]; then
                continue
            fi
        fi
        install_config "$config" "$HOME"
        echo Loaded "$conf_name"
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
