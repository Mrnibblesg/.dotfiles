# Mrnibbles' Dotfiles
Not much here yet.

# Installation
Use the install script. It's currently set up to install both configs and themes. There's options to choose which configs/themes to install and whether to backup or clobber existing configs. Uses the XDG Base Directory Specification to determine destination.

Themes require a little bit of extra work. Certain custom themes might require portions of official themes which this repo isn't made to handle the files for. For example, Futuristica requires the Oxygen theme to be complete. You'll need to find a way to install it. For Arch, you'll need to install the oxygen package. On top of that, window decorations require aurorae. Future themes will require Kvantum.
This repo also comes with a helper bash script to switch global themes. I had major trouble getting plasma's native global theme switcher to work, so right now it's hacked together. It's located in themes/plasma. It expects the wallpaper to be in an exact spot relative to the current user's home, so be wary of that if you need to change it.

# Updating
Since the install script only creates symbolic links, there should be no need to re-install as long as those links still exist and no new files have been added to the repo. Simply a git pull and a config reload of your respective application should be sufficient.

