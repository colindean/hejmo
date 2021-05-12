#!/usr/bin/env bash

#####################################
# setup internal proxy if available #
# it makes downloads so much faster #
#####################################

# install netcat, or update and then install netcat
sudo apt-get -qy install netcat || (sudo apt-get update && sudo apt-get -qy install netcat)
PROXY_DETECTION_SCRIPT_PATH=/usr/local/bin/cadcx-proxy-detect
PROXY_DETECTION_APT_CONF_PATH=/etc/apt/apt.conf.d/99cadcx-proxy-detect
sudo tee "${PROXY_DETECTION_SCRIPT_PATH}" > /dev/null <<- "SCRIPT"
    #!/bin/bash
    IP=proxy.blackridge.cad.cx
    PORT=3128
    if nc -w1 -z $IP $PORT; then
        echo -n "http://${IP}:${PORT}"
    else
        echo -n "DIRECT"
    fi
SCRIPT
sudo tee "${PROXY_DETECTION_APT_CONF_PATH}" > /dev/null << "APTCONF"
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
