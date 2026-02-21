#!/usr/bin/env bash
# Add Hejmo scripts directory to PATH
#
# This script is sourced by bash_profile after HEJMO is set.
# Files in bash_profile/ are loaded alphabetically, and HEJMO is set
# in the main bash_profile before these scripts are sourced.

if [[ -n "${HEJMO}" ]] && [[ -d "${HEJMO}/scripts" ]]; then
	export PATH="${HEJMO}/scripts:${PATH}"
fi
