#!/usr/bin/env bash

PACKAGE_LIST=(
	gnome-core
	deja-dup
	brasero
	gnome-tweaks
	dconf-editor
	simple-scan
)

# install packages
for p in "${PACKAGE_LIST[@]}"
do
    apt install -y $p
done

# add keybindigs to move between virtual desktops 1 through 9
for i in {1..9}; do gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Alt>$i']"; done
