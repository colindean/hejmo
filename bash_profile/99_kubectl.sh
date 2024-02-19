#!/usr/bin/env bash

if [[ -n "$(command -v kubectl)" ]]; then
	# shellcheck source=/dev/null
	source <(kubectl completion bash)
	export KUBECONFIG="${HOME}/.kube/config:${HOME}/.kube/config-contexts:${HOME}/.kube/config-base"
fi
