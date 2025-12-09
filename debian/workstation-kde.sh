#!/usr/bin/env bash

PACKAGE_LIST=(
	kde-plasma-desktop
	gwenview
	digikam
	skanpage
	libreoffice-plasma
        okular
)

# install common workstation apps
if [ -f ./workstation-common.sh ]; then
    bash ./workstation-common.sh
fi

# install packages
for p in "${PACKAGE_LIST[@]}" do
    apt install -y $p
done

