#!/usr/bin/env bash

if command -v kubectl > /dev/null; then
	# Cache for 1 day (86400 seconds) since kubectl completion rarely changes
	# shellcheck source=/dev/null
	# shellcheck disable=SC2312
	source <(bkt_cache_daily kubectl completion bash)
	export KUBECONFIG="${HOME}/.kube/config:${HOME}/.kube/config-contexts:${HOME}/.kube/config-base"
fi
