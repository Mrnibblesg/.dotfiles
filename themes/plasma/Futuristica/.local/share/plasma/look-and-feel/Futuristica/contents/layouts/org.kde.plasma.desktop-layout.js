var plasma = getApiVersion(1);

//USE THE theme.sh SCRIPT OR SET MANUALLY. NECESSARY FOR WALLPAPERS
var home;

var layout = {
    "desktops": [
        {
            "config": {
                "/": {
                    "formfactor": "0",
                    "immutability": "1",
                    "lastScreen": "0",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "1051",
                    "DialogWidth": "1912"
                },
                "/General": {
                    "positions": "{\"1920x1080\":[]}"
                },
                "/Wallpaper/org.kde.image/General": {
                    "Image": `file://${home}/Pictures/wallpapers/hitech/darkcube.png`,
                    "SlidePaths": "/usr/share/wallpapers/"
                }
            },
            "wallpaperPlugin": "org.kde.image"
        },
        {
            "config": {
                "/": {
                    "formfactor": "0",
                    "immutability": "1",
                    "lastScreen": "1",
                    "wallpaperplugin": "org.kde.image"
                },
                "/ConfigDialog": {
                    "DialogHeight": "630",
                    "DialogWidth": "810"
                },
                "/General": {
                    "positions": "{\"1920x1080\":[],\"640x480\":[]}"
                },
                "/Wallpaper/org.kde.image/General": {
                    "FillMode": "1",
                    "Image": `file://${home}/Pictures/wallpapers/hitech/fractal.png`,
                    "SlidePaths": "/usr/share/wallpapers/"
                }
            },
            "wallpaperPlugin": "org.kde.image"
        }
    ],
    "serializationFormatVersion": "1"
}
;

plasma.loadSerializedLayout(layout);
