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

gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
. ~/.bash_profile

# if we're not already using an rvm ruby, install the same version as what the
# system is using and use it. This makes this script a little future-proof.
if [[ -z "$(command -v ruby | egrep -o 'rvm' )" ]]; then
  system_version=$(/usr/bin/ruby --version | egrep -o '[[:digit:]]\.[[:digit:]]\.[[:digit:]]')
  rvm install "${system_version}" "--with-openssl-dir=$(brew --prefix openssl)"
fi

