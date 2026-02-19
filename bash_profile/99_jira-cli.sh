#!/usr/bin/env bash

# XDG_CONFIG_HOME is an optional XDG standard variable - set default if not already set
if [[ -z "${XDG_CONFIG_HOME}" ]]; then
	export XDG_CONFIG_HOME="${HOME}/.config"
fi

if command -v jira >/dev/null && [[ -f "${XDG_CONFIG_HOME}/.jira/.config.yml" ]]; then
	# shellcheck source=/dev/null
	. <(jira completion bash)
fi
