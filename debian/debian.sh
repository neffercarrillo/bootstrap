#! /usr/bin/env bash

# check if script is running as root


# update /etc/apt/sources.list


# update distro
apt update && apt upgrade -y

# download packages
apt install -y gnome-core gnome-tweaks ufw emacs podman transmission vlc pidgin virt-manager

# confifure firewall
ufw enabled
ufw logging enabled
