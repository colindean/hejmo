#!/usr/bin/env bash

#####################################
# setup internal proxy if available #
# it makes downloads so much faster #
#####################################

# install netcat, or update and then install netcat
sudo apt-get -qy install netcat || (sudo apt-get update && sudo apt-get -qy install netcat)
PROXY_DETECTION_SCRIPT_PATH=/usr/local/bin/cadcx-proxy-detect
PROXY_DETECTION_APT_CONF_PATH=/etc/apt/apt.conf.d/99cadcx-proxy-detect
# quotes around the keyword makes bash not substitute inside the HEREDOC
# inside _must_ be tabs for <<- to remove them when writing
sudo tee "${PROXY_DETECTION_SCRIPT_PATH}" > /dev/null <<- "SCRIPT"
	#!/bin/bash
	IP=proxy.blackridge.cad.cx
	PORT=3128
	>&2 echo "Checking proxy ${IP}:${PORT}"
	if nc -w3 -z $IP $PORT; then
		echo -n "http://${IP}:${PORT}"
	else
		echo -n "DIRECT"
	fi
SCRIPT
sudo chmod +x "${PROXY_DETECTION_SCRIPT_PATH}"
sudo tee "${PROXY_DETECTION_APT_CONF_PATH}" > /dev/null << APTCONF
    Acquire::http::Proxy-Auto-Detect "${PROXY_DETECTION_SCRIPT_PATH}";
APTCONF

# update and install some basics

sudo apt-get update
sudo apt-get -qy install software-properties-common

# setup heroku
sudo apt-get -qy install snapd && sudo snap install heroku --classic

# other essentials
sudo apt-get -qy install \
    build-essential \
    vim

# fonts
sudo apt-get -qy install \
    fonts-roboto \
    fonts-noto \
    fonts-lmodern \
    fonts-powerline \
    fonts-open-sans \
    fonts-firacode \
    fonts-liberation2

# elementaryOS-specific stuff
if [[ "$(lsb_release --id --short)" == "elementary" ]]; then

  sudo apt-get -qy install \
      fonts-raleway-elementary

  gsettings set io.elementary.terminal.settings font 'FiraCode 12'

  if [[ "$(lsb_release --codename --short)" == "juno" ]]; then
    sudo add-apt-repository ppa:philip.scott/pantheon-tweaks
    sudo apt install pantheon-tweaks
  fi
  if [[ "$(lsb_release --codename --short)" == "hera" ]]; then
    sudo add-apt-repository ppa:philip.scott/elementary-tweaks
    sudo apt install elementary-tweaks
  fi
fi

# ChromeOS terminal essentials
if [[ "$(hostname)" == "penguin" ]]; then
    if [[ "$(lsb_release --id --short)" == "Debian" ]]; then
        # setup Debian backports
        sudo tee /etc/apt/sources.list.d/debian-backports.list <<- DEBCONF
        deb http://deb.debian.org/debian $(lsb_release --codename --short)-backports main
DEBCONF
        sudo apt-get update
        
        # install flatpak
        sudo apt install flatpak/$(lsb_release --codename --short)-backports
        flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        
        # install some flatpak packages
        flatpak install flathub org.videolan.VLC
    fi
fi

echo "Installing Keybase..."
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install ./keybase_amd64.deb
