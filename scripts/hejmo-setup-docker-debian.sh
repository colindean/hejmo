#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "${SCRIPT_DIR}/_hejmo_stdlib_helpers.sh"

banner_text "Starting Docker for Linux setup"
echo "This script only works for Debian derivatives!"

banner_text "Installing dependencies from repos"
sudo apt-get update
sudo apt-get -yq install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

banner_text "Installing Docker upstream GPG key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# I'm more likely to be running an Ubuntu derivative
case "$(lsb_release -is)" in
    "ubuntu") CODENAME="$(lsb_release -cs)" ;;
    *)        CODENAME="$(lsb_release -csu)" ;;
esac

banner_text "Adding repo for ${CODENAME}"

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   ${CODENAME} \
   stable"

banner_text "Installing Docker dependencies from Docker repos"

sudo apt-get update
sudo apt-get -yq install \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-compose

banner_text "Checking sudo access to Docker"
sudo docker run hello-world
banner_text "Enabling Docker startup in systemd"
sudo systemctl enable docker
banner_text "Checking docker group sanity"
if ! groups "${USER}" | grep -q docker; then
  echo "Adding Docker user group with ${USER} in it"  
  sudo usermod -aG docker "${USER}"
  echo "Using newgrp to check operation..."  
  newgrp docker <<TEST
echo "Running docker as ${USER} in docker group to see if it's working..."
docker run hello-world
TEST
else
  echo "docker group already exists and contains ${USER}"
fi

banner_text "Fixing .docker permissions if it exists..,"
DOT_DOCKER="${HOME}/.docker"
if [[ -f "${DOT_DOCKER}" ]]; then
  sudo chown -R "${USER}":"${USER}" "${DOT_DOCKER}"
  sudo chmod -R g+rwx "${DOT_DOCKER}"
else
  echo "${DOT_DOCKER} didn't exist, which may be weird."
fi

# if we have homebrew, install docker-compose through that
# because it's guaranteed to be out of date in the OS repo
# and it's not in Docker's repo added above.
if [[ -n $(command -v brew) ]]; then 
  brew install docker-compose
fi

