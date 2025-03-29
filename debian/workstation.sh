#!/usr/bin/env bash

# globals
PACKAGE_LIST=(
    gnome-core
    firmware-realtek
    firmware-amd-graphics
    firmware-atheros
    emacs
    ufw
    virt-manager
    git
    vlc
    deja-dup
    brasero
    encfs
    printer-driver-escpr
    filezilla
    gimp
    inkscape
    webext-ublock-origin-firefox
    pdfgrep
    rapid-photo-downloader
    sshfs
    unrar-free
    htop
    make
    gcc
    podman
    libreoffice
    dconf-editor
    gnome-tweaks
    simple-scan
    ttf-mscorefonts-installer
    mpv
    digikam
    wl-copy
    cups
    tree
    tmux
    wl-clipboard
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

# enable host firewall
ufw enable
ufw logging on
