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

