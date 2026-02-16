#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "${SCRIPT_DIR}/_hejmo_stdlib_helpers.sh"

banner_text "Starting Debian deriv setup"

#####################################
# setup internal proxy if available #
# it makes downloads so much faster #
#####################################

# install netcat, or update and then install netcat
sudo apt-get -qy install netcat || (sudo apt-get update && sudo apt-get -qy install netcat)
bash "${SCRIPT_DIR}/hejmo-setup-internal-proxy-for-apt.sh"

# update and install some basics

sudo apt-get update
sudo apt-get -qy install software-properties-common

# setup heroku
curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

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

# make capslock into escape
if command -v gsettings; then
  gsettings set org.gnome.desktop.input-sources xkb-options "['grp:alt_shift_toggle', 'caps:escape']"
elif command -v dconf; then
  dconf write /org/gnome/desktop/input-sources/xkb-options "['grp:alt_shift_toggle', 'caps:escape']"
fi
  

# elementaryOS-specific stuff
if [[ "$(lsb_release --id --short)" == "elementary" ]]; then

  sudo apt-get -qy install \
      fonts-raleway-elementary

  gsettings set io.elementary.terminal.settings font 'FiraCode 12'

  if [[ "$(lsb_release --codename --short)" == "hera" ]]; then
    sudo add-apt-repository ppa:philip.scott/elementary-tweaks
    sudo apt install elementary-tweaks
  else
    # we're probably on something newer, which switched to Pantheon
    sudo add-apt-repository ppa:philip.scott/pantheon-tweaks
    sudo apt install pantheon-tweaks
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
sudo apt install ./keybase_amd64.deb && rm ./keybase_amd64.deb

