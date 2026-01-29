#!/usr/bin/env bash
# Add Hejmo scripts directory to PATH

# HEJMO is set in bash_profile, which is loaded before these scripts
if [[ -n "${HEJMO}" ]] && [[ -d "${HEJMO}/scripts" ]]; then
  export PATH="${HEJMO}/scripts:${PATH}"
fi
