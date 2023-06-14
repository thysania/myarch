#!/usr/bin/sh
#  __  __ __   __ _    ___   ___  _  _ 
# |  \/  |\ \ / //_\  | _ \ / __|| || |
# | |\/| | \ V // _ \ |   /| (__ | __ |
# |_|  |_|  |_|/_/ \_\|_|_\ \___||_||_|
#	Script to install my dwm rice
#   Author: thysania
#	https://github.com/thysania

CRE=$(tput setaf 1)
CYE=$(tput setaf 3)
CGR=$(tput setaf 2)
CBL=$(tput setaf 4)
BLD=$(tput bold)
CNC=$(tput sgr0)
date=$(date +%Y%m%d-%H%M%S)

logo () {
	
	local text="${1:?}"
	echo "                                  
  _______  _    _ __     __ _____           _   _  _____           
 |__   __|| |  | |\ \   / // ____|   /\    | \ | ||_   _|    /\    
    | |   | |__| | \ \_/ /| (___    /  \   |  \| |  | |     /  \   
    | |   |  __  |  \   /  \___ \  / /\ \  | . ` |  | |    / /\ \  
    | |   | |  | |   | |   ____) |/ ____ \ | |\  | _| |_  / ____ \ 
    |_|   |_|  |_|   |_|  |_____//_/    \_\|_| \_||_____|/_/    \_\
			  z0mbi3 Dotfiles\n\n"
    printf ' %s [%s%s %s%s %s]%s\n\n' "${CRE}" "${CNC}" "${CYE}" "${text}" "${CNC}" "${CRE}" "${CNC}"
}

########## ---------- Welcome ---------- ##########

logo "Welcome!"
printf '%s%sThis script will check if you have the necessary dependencies, and if not, it will install them. You will be prompted for your root password to install missing dependencies and/or to switch to zsh shell if its not your default.\nThis script DO NOT modify any of your system configuration.%s\n\n' "${BLD}" "${CRE}" "${CNC}"

while true; do
	read -rp " Do you wish to continue? [y/N]: " yn
		case $yn in
			[Yy]* ) break;;
			[Nn]* ) exit;;
			* ) printf " Error: just write 'y' or 'n'\n\n";;
		esac
    done
clear

########## ---------- Install packages ---------- ##########

logo "Installing needed packages.."

dependencias=(base-devel xorg-xsetroot xorg-server xorg-xinit libx11 libxft libxinerama webkit2gtk libmpdclient \
			                   udiskie acpie feh scrot xdg-user-dirs xorg-xprob neofetch \
			                   mpd ncmpcpp picom lf pamixer \
			                   ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-dejavu ttf-hack noto-font-emoji \
			                   zsh zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search xorg-xrandr)

is_installed() {
  pacman -Qi "$1" &> /dev/null
  return $?
}

printf "%s%sChecking for required packages...%s\n" "${BLD}" "${CBL}" "${CNC}"
for paquete in "${dependencias[@]}"
do
  if ! is_installed "$paquete"; then
    sudo pacman -S "$paquete" --noconfirm
    printf "\n"
  else
    printf '%s%s is already installed on your system!%s\n' "${CGR}" "$paquete" "${CNC}"
    sleep 1
  fi
done
sleep 3
clear

########## ---------- Preparing Folders ---------- ##########

logo "Preparing Folders"
if [ ! -e $HOME/.config/user-dirs.dirs ]; then
	xdg-user-dirs-update
	echo "Creating xdg-user-dirs"
else
	echo "user-dirs.dirs already exists"
fi
sleep 2 
clear
########## ---------- Copy the Rice! ---------- ##########

logo "Installing dotfiles.."
printf "Copying files to respective directories..\n"

[ ! -d ~/.config ] && mkdir -p ~/.config
[ ! -d ~/.local/share/fonts ] && mkdir -p ~/.local/share/fonts

for archivos in ~/dotfiles/config/*; do
  cp -R "${archivos}" ~/.config/
  if [ $? -eq 0 ]; then
	printf "%s%s%s folder copied succesfully!%s\n" "${BLD}" "${CGR}" "${archivos}" "${CNC}"
	sleep 1
  else
	printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archivos}" "${CNC}"
	sleep 1
  fi
done

for archivos in ~/dotfiles/misc/bin/*; do
  cp -R "${archivos}" ~/.local/bin/
  if [ $? -eq 0 ]; then
	printf "%s%s%s file copied succesfully!%s\n" "${BLD}" "${CGR}" "${archivos}" "${CNC}"
	sleep 1
  else
	printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archivos}" "${CNC}"
	sleep 1
  fi
done

for archivos in ~/dotfiles/misc/applications/*; do
  cp -R "${archivos}" ~/.local/share/applications/
  if [ $? -eq 0 ]; then
	printf "%s%s%s file copied succesfully!%s\n" "${BLD}" "${CGR}" "${archivos}" "${CNC}"
	sleep 1
  else
	printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archivos}" "${CNC}"
	sleep 1
  fi
done

cp -f "$HOME"/myarch/.zshrc "$HOME"
cp -f "$HOME"/myarch/.xinitrc "$HOME"
fc-cache -rv >/dev/null 2>&1
printf "%s%sFiles copied succesfully!!%s\n" "${BLD}" "${CGR}" "${CNC}"
sleep 3
