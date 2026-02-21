#!/usr/bin/env bash

MINICONDA_PATH="${MINICONDA_PATH:-"$(${BREW_PREFIX})/Caskroom/miniconda"}}"
CONDA_BASE_PATH="${MINICONDA_PATH}/base"
CONDA_BIN="${CONDA_BASE_PATH}/bin/conda"

if [[ -x "${CONDA_BIN}" ]]; then
	# Cache for 1 hour (3600 seconds) since conda configuration may change during development
	# shellcheck disable=SC2312
	__conda_setup="$(bkt_cache_hourly "${CONDA_BIN}" shell.bash hook 2>/dev/null)"
	# shellcheck disable=SC2181
	if [[ $? -eq 0 ]]; then
		eval "${__conda_setup}"
	else
		if [[ -f "${CONDA_BASE_PATH}/etc/profile.d/conda.sh" ]]; then
			# shellcheck disable=SC1091
			. "${CONDA_BASE_PATH}/etc/profile.d/conda.sh"
		else
			export PATH="${CONDA_BASE_PATH}/bin:${PATH}"
		fi
	fi
	unset __conda_setup
fi
