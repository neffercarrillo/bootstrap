#!/usr/bin/env bash

PACKAGE_LIST=(
    xfce4*
)

# check if script running as root. if not, exit.
if (( $EUID != 0 )); then
    echo "${0##*/}: Please run the script as root."
    exit
fi

# install common workstation apps
if [ -f ./workstation-common.sh ]; then
    bash ./workstation-common.sh
fi

# install packages
for p in "${PACKAGE_LIST[@]}" do
    apt install -y $p
done

