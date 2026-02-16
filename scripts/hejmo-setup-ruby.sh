#!/usr/bin/env bash
# this will install or update RVM using
# literally the steps from rvm.io
ensure_brew() {
	if [[ -z "$(command -v brew)" ]]; then
		echo "Homebrew not found, can't install required dependencies."
		exit 2
	fi
	true
}
if [[ -z "$(command -v curl)" ]]; then
	echo "cURL not found. Are you even using a computer?"
	echo "Let's try to install it with Homebrew but Homebrew relies on cURL already…"
	ensure_brew && brew install curl
fi
if [[ -z "$(command -v gpg)" ]]; then
	echo "GPG not found, installing it…"
	ensure_brew && brew install gpg
	if [[ -z "$(command -v gpg)" ]]; then
		echo "GPG not available, cannot install RVM without being able to validate it."
		exit 1
	fi
fi

if ! gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB; then
	curl -sSL https://rvm.io/mpapis.asc | gpg --import -
	curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
fi

gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
# shellcheck source=/dev/null
. ~/.bash_profile

install_rvm_with_curlbash() {
  gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  curl -sSL https://get.rvm.io | bash -s stable
}

install_rvm_for_debian() {
  sudo apt-get install --yes software-properties-common
  if ! sudo apt-add-repository -y ppa:rael-gc/rvm; then
    curl "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x7be3e5681146fd4f1a40eda28094bb14f4e3fbbe" | sudo tee /etc/apt/trusted.gpg.d/rael-gc_ubuntu_rvm.asc
  fi
  sudo apt-get update --yes
  sudo apt-get install --yes rvm
  sudo usermod -a -G rvm "${USER}"
}

if [[ -f /etc/os-release ]]; then
  # probably on Linux
  # shellcheck source=/dev/null
  . /etc/os-release
  case "${ID}" in
    "ubuntu" | "debian")
      install_rvm_for_debian
      ;;
    *)
      install_rvm_with_curlbash
      ;;
  esac
else
  install_rvm_with_curlbash
fi



##
## I almost never need a Ruby outside of a project scope since 2023.
##
# if we're not already using an rvm ruby, install the same version as what the
# system is using and use it. This makes this script a little future-proof.
if ! grep -E -q -o 'rvm' <(command -v ruby); then
	system_version=$(/usr/bin/ruby --version | grep -E -o '[[:digit:]]\.[[:digit:]]\.[[:digit:]]')
	rvm install "${system_version}" "--with-openssl-dir=$(brew --prefix openssl)"
fi

