#! /usr/bin/env bash

# globals
INSTALL_REPO='dnf --nogpgcheck install -y'
INSTALL_PKG='dnf install -y'
PACKAGE_LIST=(
    flash-plugin
    keepassx
    mozilla-adblockplus
    mozilla-noscript
    mozilla-https-everywhere
    python-pip
    python-virtualenv
    python3-virtualenv
    sqlite-devel
    tmux
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
    dnf update -y
}
    
function add_repositories {
    # rpmfusion-free repo
    $INSTALL_REPO http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm

    # rpmfusion-nonfree repo
    $INSTALL_REPO http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm

    ## Adobe Repository 64-bit x86_64
    rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
}
    
function install_packages {
    for p in "${PACKAGE_LIST[@]}"
    do
        $INSTALL_PKG $p
    done
}

# execute script
main
