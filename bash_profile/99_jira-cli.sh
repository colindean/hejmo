#!/usr/bin/env bash

if command -v jira >/dev/null && [[ -f "${XDG_CONFIG_HOME:-${HOME}/.config}/.jira/.config.yml" ]]; then
	# shellcheck source=/dev/null disable=SC2312
	. <(jira completion bash)
fi
