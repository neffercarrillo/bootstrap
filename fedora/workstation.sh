#! /usr/bin/env bash

# globals
PACKAGE_LIST=(
    rpmfusion-free-release-tainted
    brasero
    clamav
    clamav-update
    code
    ctags
    dconf-editor
    deja-dup
    emacs    
    encfs
    epson-inkjet-printer-escpr
    exiv2
    filezilla
    gimp
    google-chrome-stable
    gnome-tweak-tool
    gparted
    gstreamer-plugins-*
    gstreamer1-plugins-*
    gthumb
    htop
    inkscape
    libdvdcss
    libdvdnav
    libdvdread
    libvirt
    livecd-tools
    liveusb-creator
    mozilla-ublock-origin
    mozilla-noscript
    mozilla-https-everywhere
    nodejs
    openssl-devel
    pdfgrep    
    rapid-photo-downloader
    simple-scan
    shotwell
    sshfs
    tintin
    tintin-doc
    tmux
    unrar
    unzip
    uuid
    virt-manager
    vlc
)

function main {
    verify_if_running_as_root
    update_os
    add_repositories
    install_packages
}

function verify_if_running_as_root {
    if (( $EUID != 0 )); then
        echo "${0##*/}: Please run the script as root."
        exit
    fi
}

function update_os {
    dnf update -y
}
    
function add_repositories {
    # rpmfusion-free repo
    dnf --nogpgcheck install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 

    # rpmfusion-nonfree repo
    dnf --nogpgcheck install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    
    # microsoft vs code
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

    # google chrome repo
    cat << EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome - \$basearch
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF

}
    
function install_packages {
    for p in "${PACKAGE_LIST[@]}"
    do
        dnf install -y $p
    done
}


# execute script
main
