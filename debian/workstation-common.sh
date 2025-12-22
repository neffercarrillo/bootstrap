#!/usr/bin/env bash

# globals
PACKAGE_LIST=(
    firmware-realtek
    firmware-amd-graphics
    firmware-atheros
    emacs
    ufw
    git
    printer-driver-escpr
    pdfgrep
    unrar-free
    htop
    make
    gcc
    podman
    ttf-mscorefonts-installer
    mpv
    wl-clipboard
    cups
    tree
    tmux
    sqlite3
    virt-manager
    sqlitebrowser
    filezilla
    gimp
    inkscape
    rapid-photo-downloader
    libreoffice
    keepassxc
    webext-ublock-origin-firefox
    webext-keepassxc-browser
    chromium
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

# add user to groups relevant to virtualization
usermod -aG libvirt,libvirt-qemu,kvm $USER

# add usre to printer group
usermod -aG lpadmin $USER

# enable host firewall
ufw enable
ufw logging on

# TODO fix interfaces file

