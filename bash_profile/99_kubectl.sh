#!/usr/bin/env bash

if [[ -n "$(command -v kubectl)" ]]; then
	# Cache for 1 day (86400 seconds) since kubectl completion rarely changes
	# shellcheck source=/dev/null
	source <(bkt --ttl=86400 -- kubectl completion bash)
	export KUBECONFIG="${HOME}/.kube/config:${HOME}/.kube/config-contexts:${HOME}/.kube/config-base"
fi
