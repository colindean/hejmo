#!/usr/bin/env bash

if [[ -z "${XDG_CONFIG_HOME}" ]]; then
	XDG_CONFIG_HOME="${HOME}/.config"
fi

if command -v jira >/dev/null && [[ -f "${XDG_CONFIG_HOME}/.jira/.config.yml" ]]; then
	# shellcheck source=/dev/null
	. <(jira completion bash)
fi
