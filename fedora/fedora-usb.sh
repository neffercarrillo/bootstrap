#! /usr/bin/env bash

# globals
INSTALL_REPO='dnf --nogpgcheck install -y'
INSTALL_PKG='dnf install -y'
PACKAGE_LIST=(
    google-chrome-stable
    mozilla-adblockplus
    tmux
)

function main {
    verify_if_running_as_root
    add_repositories
    install_packages
}

function verify_if_running_as_root {
    if (( $EUID != 0 )); then
        echo "${0##*/}: Please run the script as root."
        exit
    fi
}
    
function add_repositories {
    # rpmfusion-free repo
    $INSTALL_REPO http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm

    # rpmfusion-nonfree repo
    $INSTALL_REPO http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm

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
        $INSTALL_PKG $p
    done
}


# execute script
main
