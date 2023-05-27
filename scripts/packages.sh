#!/bin/sh
echo "                       _       ______                   "
echo "     /\               | |     |  ____|                  "
echo "    /  \    _ __  ___ | |__   | |__    _ __  ___  _ __  "
echo "   / /\ \  | '__|/ __|| '_ \  |  __|  | '__|/ _ \| '_ \ "
echo "  / ____ \ | |  | (__ | | | | | |____ | |  |  __/| | | |"
echo " /_/    \_\|_|   \___||_| |_| |______||_|   \___||_| |_|"
echo "--------------------------------------------------------"

echo
echo "  === INSTALLING PACKAGES ==="
echo

PKGS=(
# dwm and st dependencies
        'xorg-server'
        'xorg-xsetroot'
        'xorg-xinit'
        'libx11'
        'libxft'
        'libxinerama'
        'webkit2gtk'
        'picom'
# audio
        'alsa-utils'        # Advanced Linux Sound Architecture (ALSA) Components https://alsa.opensrc.org/
        'alsa-plugins'      # ALSA plugins
        'pulseaudio'        # Pulse Audio sound components
        'pulseaudio-alsa'   # ALSA configuration for pulse audio
        'pavucontrol'       # Pulse Audio volume control
# utilities
        'udiskie'           # Automounter for removable media
        'acpi'              # Battery status
        'feh'               # Wallpaper
        'scrot'             # Screenshots
        'zsh'               # Zsh shell
        'xdg-user-dirs'     # User directories
# fonts
        'ttf-hack'
        'ttf-hack-nerd'
        'ttf-font-awesome'
        'noto-fonts-emoji'
# browsers
        'qutebrowser'
        
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo "  === INSTALLING SNAPS ==="
echo " --> Cloning snap"
cd
git clone https://aur.archlinux.org/snapd.git
echo " --> Installing snap"
cd snapd
makepkg -si
sudo systemctl enable --now snapd.socket

echo " --> Installing brave"
sudo snap install brave

echo
echo "Done!"
echo
