var plasma = getApiVersion(1);

//USE THE theme.sh SCRIPT OR SET MANUALLY. NECESSARY FOR WALLPAPERS
var home;

let wallpaperConfigs = [`file://${home}/Pictures/wallpapers/hitech/darkcube.png`,
    `file://${home}/Pictures/wallpapers/hitech/fractal.png`
];

var desktopsArray = desktopsForActivity(currentActivity());
for( var j = 0; j < Math.min(desktopsArray.length, wallpaperConfigs.length); j++) {
    desktop = desktopsArray[j];
    desktop.wallpaperPlugin = 'org.kde.image';
    desktop.currentConfigGroup = ["Wallpaper", "org.kde.image", "General"]
    desktop.writeConfig("Image", wallpaperConfigs[j])
}
