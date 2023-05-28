#!/bin/sh
echo "                       _       ______                   "
echo "     /\               | |     |  ____|                  "
echo "    /  \    _ __  ___ | |__   | |__    _ __  ___  _ __  "
echo "   / /\ \  | '__|/ __|| '_ \  |  __|  | '__|/ _ \| '_ \ "
echo "  / ____ \ | |  | (__ | | | | | |____ | |  |  __/| | | |"
echo " /_/    \_\|_|   \___||_| |_| |______||_|   \___||_| |_|"
echo "--------------------------------------------------------"

echo
echo "  === CONFIGURING THE SYSTEM! ==="
echo

# installing dwm
echo "  --> INSTALLING DWM"
cd ~/myarch/dwm/
sudo make clean install
cd ..
chmod +x statusbar.sh
echo""

# installing st terminal
echo "  --> INSTALLING ST TERMINAL"
cd ~/myarch/st
sudo make clean install
echo ""

# installing oh-my-zsh
echo "  --> INSTALLING OHMYZSH"
cd
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# installing dunst
echo " --> CLONING DUNST"
cd
git clone https://github.com/dunst-project/dunst.git
echo " --> INSTALLING DUNST"
cd dunst
sudo make clean install

# installing dmenu
echo "  --> INSTALLING DMENU"
cd ~/myarch/dmenu
sudo make clean install
echo ""

# installing dunst
echo "  --> INSTALLING DUNST"
cd ~/myarch/dunst/
sudo make clean install
echo ""

# creating user dirs
echo "  --> CREATING USER DIRS"
xdg-user-dirs-update
echo ""

# changing wallpaper
echo "  --> CHANGING WALLPAPER"
feh --bg-fill ~/myarch/wallpapers/arch.png
echo ""

# copying dotfiles
echo " => Creating config directories"
if [ -d "~/.config/dunst" ]
then
    echo "dunst already exist"
else
    mkdir ~/.config/dunst
fi

cd ~/myarch
echo " => Copying .xinitrc"
cp .xinitrc ~/.xinitrc

echo " => Copying .bashrc"
cp .bashrc ~/.bashrc

echo " => Copying .bash_profile"
cp .bash_profile ~/bash_profile

echo " => Copying .zshrc"
cp .zshrc ~/.zshrc

echo " => Copying dunstrc"
cp dunstrc ~/.config/dunst/

echo
echo "Done!"
echo
