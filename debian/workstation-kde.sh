#!/usr/bin/env bash

PACKAGE_LIST=(
	kde-plasma-desktop
	gwenview
	digikam
	skanpage
	libreoffice-plasma
)

# install packages
for p in "${PACKAGE_LIST[@]}"
do
    apt install -y $p
done

