# Mrnibbles' Dotfiles
My linux configurations you can use to enrich your own. Contains program configs and DE themes along with accompanying install scripts.

# Installation
Use the install script. It's currently set up to install both configs and themes. There's options to choose which configs/themes to install and whether to backup or clobber existing configs. Uses the XDG Base Directory Specification to determine destination.

Themes require a little bit of extra work. Certain custom themes might require portions of official themes which this repo isn't made to handle the files for. For example, Futuristica requires the Oxygen theme to be complete. You'll need to find a way to install it. For Arch, you'll need to install the oxygen package. On top of that, window decorations require aurorae. Future themes will require Kvantum.
This repo also comes with a helper bash script to switch global themes. I had major trouble getting plasma's native global theme switcher to work, so right now it's hacked together. It's located in themes/plasma. It expects the wallpaper to be in an exact spot relative to the current user's home, so be wary of that if you need to change it.

# Updating
Since the install script only creates symbolic links, there should be no need to re-install as long as those links still exist and no new files have been added to the repo. Simply a git pull and a config reload of your respective application should be sufficient.


# Theme Details
## Keybinds
### Essential
| Keybind | Action |
|---------|--------|
| Ctrl + Alt + T | Open Terminal |
| Alt + Space | Open KRunner |

### Typing/Text
| Keybind | Action |
|---------|--------|
| Ctrl + Space | Change input method |
| Meta + . | Emoji selector |
| (None yet) | OCR screen snip to text (Req. Spectacle + (None yet) |

### Window Management
| Keybind | Action |
|---------|--------|
| Meta + PgUp | Maximize |
| Meta + PgDown | Minimize |
| Meta + (Arrow keys) | Tile to side of screen |
| Ctrl + Meta + Shift + (Arrow keys) | Move window to different virtual desktop |
| Ctrl + P | Pin window |
| Meta + Alt + (Arrow keys)| Move focus in direction |
| Meta + Shift + (Arrow keys) | Move window to other monitor |
| Meta + T | Adjust tiling window split ratios |
| Shift + (Drag) | Tile window to tiling preset |
| Meta + Ctrl + Esc | Pick & kill a window |

### Workspace Management
| Keybind | Action |
|---------|--------|
| Ctrl + Meta + (Arrow keys) | Move between virtual desktops |
| Ctrl + (F1-F10) | Switch to virtual desktops 1-10 |
| Meta + A | Go to next activity |
| Meta + Q | Pick the next activity |
| Meta + W | Enable overview W/ KRunner |
| Meta + G | Show all windows in all virtual desktops |

### Session Management
| Keybind | Action |
|---------|--------|
| Meta + L | Lock session |
| Ctrl + Alt + Del | Show session/power options |

### Misc. Actions
| Keybind | Action |
|---------|--------|
| PrtSc | Take screenshot (Req. Spectacle) |
| Ctrl + PrtSc | Take screenshot to clipboard (Req. Spectacle) |
| Shift + PrtSc | Save screenshot to file (Req. Spectacle) |
| Meta + R | Record region (Req. Spectacle) |

## Recommended Fonts
- General: Rajdani Medium 10pt
- Fixed Width: Hack 10pt
- Small: Rajdani Medium 8pt
- Toolbar: Rajdani Medium 10pt
- Menu: Rajdani Medium 10pt
- Window Title: Orbitron 8pt
