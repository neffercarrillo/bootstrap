#!/usr/bin/bash

# globals
PACKAGE_LIST=(
    vim
    emacs
    ufw
    git
    htop
    make
    gcc
    podman
    mpv
    ufw
    tmux
    newsboat
    irssi
)

# check if script running as root. if not, exit.
if (( $EUID != 0 )); then
    echo "${0##*/}: Please run the script as root."
    exit
fi

# modify sources to include contrib
perl -p -i -e 's/main/main contrib/' /etc/apt/sources.list

# update sources and upgrade distro
apt update && apt upgrade -y

# install packages
for p in "${PACKAGE_LIST[@]}"
do
    apt install -y $p
done

# enable host firewall
ufw allow 22/tcp
ufw enable
ufw logging on
