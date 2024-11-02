#! /usr/bin/env bash

# globals
INSTALL_PKG='pkg install -y'
PACKAGE_LIST=(
        emacs
        tintin++
        irssi
        rsync
        tmux
        git
        python3
)

function main {
    verify_if_running_as_root
    update_os
    install_packages
    configure_firewall
    set_timezone
    configure_ntp
    configure_new_user
    configure_sshd
}

function verify_if_running_as_root {
    if (( $EUID != 0 )); then
        echo "${0##*/}: Please run the script as root."
        exit
    fi
}

function update_os {
   pkg update
}

function install_packages {
    for p in "${PACKAGE_LIST[@]}"
    do
        $INSTALL_PKG $p
    done
}

function configure_firewall {
    sysrc firewall_enable="YES"
    sysrc firewall_quiet="YES"
    sysrc firewall_type="workstation"
    sysrc firewall_myservices="22/tcp"
    sysrc firewall_allowservices="any"
    sysrc firewall_logdeny="YES"
    service ipfw start
    echo "net.inet.ip.fw.verbose_limit=5" >> /etc/sysctl.conf
    sysctl net.inet.ip.fw.verbose_limit=5
}

function set_timezone {
    # this step requires human intervent
    tzsetup
}

function configure_ntp {
    sysrc ntpd_enable="YES"
    sysrc ntpd_sync_on_start="YES"
    service ntpd start
}

function configure_new_user {
    # create new user and add to wheel group(s)
     adduser -G wheel
}

function configure_sshd {    
    cp ~/.ssh/ /home/$username/.ssh/
    chown -R $username:$username /home/$username/.ssh/
    sed -i 's/PermitRootLogin\swithout-password/PermitRootLogin\sno/' /etc/sshd/sshd_config
}


# execute script
main
