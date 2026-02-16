#!/bin/sh
source _helpers.sh
command_exists "apm"
apm_exists=$?
if [[ $apm_exists -ne 0 ]]; then
  echo >&2 "apm isn't installed. Has Atom been installed?"
  exit 1
fi

apm install --packages-file apm.list

# to generate list:
#     apm list --installed --bare
