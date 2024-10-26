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
)

function main {
    verify_if_running_as_root
    update_os
    update_repositories
    install_packages
    update_groups
    configure_firewall
}

function verify_if_running_as_root {
    if (( $EUID != 0 )); then
        echo "${0##*/}: Please run the script as root."
        exit
    fi
}

function update_os {
    apt update && apt upgrade -y
}

function update_repositories {
    perl -p -i -e 's/main/main contrib/' /etc/apt/sources.list
}

function install_packages {
   for p in "${PACKAGE_LIST[@]}"
    do
        apt install -y $p
    done
}

function update_groups {
    usermod -aG libvirt,libvirt-qemu,kvm $USER
}

function configure_firewall {
    ufw enable
    ufw logging on
}

# execute script
main
