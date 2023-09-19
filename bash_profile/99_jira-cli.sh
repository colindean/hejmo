#!/usr/bin/env bash

if command -v jira >/dev/null && [[ -f "${XDG_CONFIG_HOME}/.jira/.config.yml" ]]; then
	# shellcheck source=/dev/null
	. <(jira completion bash)
fi
