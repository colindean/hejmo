#!/usr/bin/env bash

sudo apt-get update
sudo apt install software-properties-common

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

