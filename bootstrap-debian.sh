#! /usr/bin/env bash

# ask if /etc/apt/sources.list has been updated to include contrib and non-free

# check if script is run as sudo
if (( $EUID != 0 )); then
    echo "${0##*/}: Please run the script as root."
    exit
fi

# remove unnecessary apps
apt purge gnome-games && apt autoremove

# update distro
apt update && apt upgrade

# install apps
apt install -y firmware-realtek firmware-amd-graphics emacs ufw virt-manager git firmware-atheros vlc deja-dup brasero encfs printer-driver-escpr filezilla gimp inkscape webext-ublock-origin-firefox pdfgrep rapid-photo-downloader sshfs tmux unrar-free htop make gcc podman

# configure firewall
ufw enable
ufw logging on

# add user to libvirt-qemu and qemu groups
# ask for username and add at the end of the next line
usermod -aG libvirt,libvirt-qemu,kvm 
