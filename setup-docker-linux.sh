#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -yq install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# I'm more likely to be running an Ubuntu derivative
case "$(lsb_release -is)" in
    "ubuntu") CODENAME="$(lsb_release -cs)" ;;
    *)        CODENAME="$(lsb_release -csu)" ;;
esac


sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   "${CODENAME}" \
   stable"

sudo apt-get update
sudo apt-get -yq install \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-compose

sudo docker run hello-world
sudo systemctl enable docker

sudo usermod -aG docker $USER
newgrp docker

docker run hello-world

sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R

# if we have homebrew, install docker-compose through that
# because it's guaranteed to be out of date in the OS repo
# and it's not in Docker's repo added above.
command -v brew && brew install docker-compose

