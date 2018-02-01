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

function gimp {
	install "gimp"
}

function emacs {
	install "emacs"
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

