#! /bin/bash
lookandfeeltool -l

read -p "Which would you like? " choice
lookandfeeltool -a $choice

desktoplayout = ${HOME}/.local/share/plasma/look-and-feel/${choice}/contents/layouts/org.kde.plasma.desktop-layout.js

# Doing this because I intend for this to be ran on other people's stuff that isn't my own.
# They'll be able to run this script which will inject their home directory so the file path will point to the right picture after installation.

# Look for var home in the chosen theme's path. Then, set the path properly.
# Find var home. Replace the rest of the line with = ${HOME};
sed --in-place --expression "0,/^var home.*$/s|^var home.*$|var home = ${HOME};|" $desktoplayout

# Apply desktop layout (currently only wallpaper... if we were only doing this we'd use plasma-apply-wallpaperimage)
# dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript "string:$(cat $desktoplayout)"
