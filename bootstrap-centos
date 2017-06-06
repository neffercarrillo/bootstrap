#! /usr/bin/env bash

# globals
INSTALL_REPO='yum --nogpgcheck install -y'
INSTALL_PKG='yum install -y'
PACKAGE_LIST=(
    brasero
    clamav
    clamav-update
    ctags
    dconf-editor
    deja-dup
    emacs   
    encfs
    epson-inkjet-printer-escpr
    exfalso
    filezilla
    gimp
    gnome-mud
    gnome-tweak-tool
    gparted
    gstreamer-plugins-*
    gstreamer1-plugins-*
    htop
    inkscape
    keepassx
    libdvdcss
    libdvdnav
    libdvdread
    libvirt
    livecd-tools
    mplayer
    ncurses-devel
    openssl-devel
    pdfgrep 
    simple-scan 
    soundconverter
    sshfs
    tmux
    tracker-preferences
    transmission
    unrar
    unzip
    uuid
    vlc
    xchm
)

function main {
    verify_if_running_as_root
    update_distro
    add_repositories
    install_packages
}

function verify_if_running_as_root {
    if (( $EUID != 0 )); then
        echo "${0##*/}: Please run the script as root."
        exit
    fi
}

function update_distro {
    yum update -y
}
    
function add_repositories {
    # EPEL repo
    yum install -y epel-release
    
    # nux-desktop
    rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
}
   
function install_packages {
    for p in "${PACKAGE_LIST[@]}"
    do
        $INSTALL_PKG $p
    done
}

# execute script
main
