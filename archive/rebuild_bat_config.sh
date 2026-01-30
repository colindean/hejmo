#!/usr/bin/env bash
BAT_CONFIG_DIR="$(bat --config-dir)"

clone_or_update() {
  local dir="${1}"
  local repo_url="${2}"

  if [ -d "${dir}" ]; then
    echo "${dir} exists, updating…"
    pushd "${dir}" > /dev/null || exit 8
    git pull
    popd > /dev/null || exit 9
  else
    echo "${dir} doesn't exist, cloning…"
    git clone "${repo_url}" "${dir}"
  fi
}


echo "Rebuilding bat config in ${BAT_CONFIG_DIR}…"
##
# Syntaxes
##
BAT_SYNTAXES="${BAT_CONFIG_DIR}/syntaxes"
mkdir -p "${BAT_SYNTAXES}"
cd "${BAT_SYNTAXES}" || (echo "Unable to cd to ${BAT_SYNTAXES}" && exit 2)

# List syntaxes here!
clone_or_update "Ledger" "https://github.com/vqv/Ledger3.git"

##
# Themes
##

BAT_THEMES="${BAT_CONFIG_DIR}/themes"
mkdir -p "${BAT_THEMES}"
cd "${BAT_THEMES}" || (echo "Unable to cd to ${BAT_THEMES}" && exit 2)

# List themes here!
# None right now…

echo "Rebuilding bat cache…"
bat cache --build

last="$?"
if [ "${last}" -eq 0 ]; then
  echo "It probably worked!"
else
  echo "It probably failed."
  echo "Reset with [bat cache --clear] if things went real bad."
  exit "${last}"
fi
