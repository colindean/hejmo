#!/usr/bin/env bash
# Set up Ghostty's Fedora COPR repo and install Ghostty via rpm-ostree
# Author: colindean
# Adapted from https://ghostty.org/docs/install/binary#atomic-desktops-(silverblue)

set -eux -o pipefail

repo_file="/etc/yum.repos.d/_copr:copr.fedorainfracloud.org:scottames:ghostty.repo"

# shellcheck source=/dev/null
. /etc/os-release

if [[ -z "${ID_LIKE}" ]]; then
  echo "ID_LIKE is not set in /etc/os-release"
  exit 1
fi

if [[ -z "${VERSION_ID}" ]]; then
  echo "VERSION_ID is not set in /etc/os-release"
  exit 1
fi

if [[ "${ID_LIKE}" != fedora ]] || ! command -v rpm-ostree; then
  echo "This is meant for Universal Blue, which has ID_LIKE=fedora, you've got ${ID_LIKE}, or you're missing rpm-ostree."
  exit 1
fi

sudo rm -rf "${repo_file}"
copr_url="https://copr.fedorainfracloud.org/coprs/scottames/ghostty/repo/fedora-${VERSION_ID}/scottames-ghostty-fedora-${VERSION_ID}.repo"
curl -fsSL "${copr_url}" | sudo tee "${repo_file}" > /dev/null

rpm-ostree refresh-md && \
rpm-ostree install ghostty
