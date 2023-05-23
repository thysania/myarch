#!/bin/sh
echo "                       _       ______                   "
echo "     /\               | |     |  ____|                  "
echo "    /  \    _ __  ___ | |__   | |__    _ __  ___  _ __  "
echo "   / /\ \  | '__|/ __|| '_ \  |  __|  | '__|/ _ \| '_ \ "
echo "  / ____ \ | |  | (__ | | | | | |____ | |  |  __/| | | |"
echo " /_/    \_\|_|   \___||_| |_| |______||_|   \___||_| |_|"
echo "--------------------------------------------------------"

echo
echo "INSTALLING FONTS"
echo

PKGS=(
        'xorg-server'
        'xorg-xsetroot'
        'xorg-xinit'
        'libx11'
        'libxft'
        'libxinerama'
        'webkit2gtk'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Done!"
echo
