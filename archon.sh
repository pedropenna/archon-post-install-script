#!/bin/bash

declare -a options=(
    "curl"
    "emacs"
    "essentials"
    "fonts"
    "gimp"
    "i3"
    "term"
    "yaourt"
    "zsh"
)

function show_usage {
	echo "usage:"

	for i in "${options[@]}"
	do
		echo "    $i"
	done

	echo "    everything"
}

function install {
	sudo pacman -S --noconfirm $1
}

function directories {
	mkdir -p ~/dev/wk
}

function essentials {
	install "vim git"
}

function i3 {
	install "i3-wm i3status"
}

function curl {
	install "curl wget"
}

function fasd {
	install-aur "fasd"
}

function gimp {
	install "gimp"
}

function node {
	install "npm"
}

# remap caps lock and stuff
function xmodmap {
	install "xorg-xmodmap"

    echo "clear lock
clear control
keycode 66 = Control_L
add control = Control_L Control_R
pointer = 1 2 3 5 4 7 6 8 9 10 11 12
" > ~/.Xmodmap

    env xmodmap ~/.Xmodmap
}

function infinality-replacement {
    sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
    sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d

    install-aur "fonts-meta-extended-lt"
}

function emacs {
	install "emacs"

	(cd ~; git clone https://github.com/syl20bnr/spacemacs.git .emacs.d)
}

function term {
	install "terminator tmux"
}

function yaourt {
	install "yaourt"
}

function install-aur {
	env yaourt -S --noconfirm $1
}

function fonts {
	 install "ttf-dejavu"

	 yaourt
	 install-aur "ttf-meslo"
}

function zsh {
	install "zsh"

	directories
	(cd ~/dev/wk/; git clone https://github.com/robbyrussell/oh-my-zsh.git)
	~/dev/wk/oh-my-zsh/tools/install.sh

	yaourt
	install-aur powerline-fonts-git
}

function everything {
    for i in "${options[@]}"
    do
        $i
    done
}

if [ "$1" == "" ]; then
    show_usage
else
	declare function_to_be_called="$1"
	$function_to_be_called
fi

