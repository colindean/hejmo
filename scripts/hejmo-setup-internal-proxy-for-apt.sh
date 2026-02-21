#!/usr/bin/env bash

PROXY_DETECTION_SCRIPT_PATH=/usr/local/bin/cadcx-proxy-detect
PROXY_DETECTION_APT_CONF_PATH=/etc/apt/apt.conf.d/99cadcx-proxy-detect
# quotes around the keyword makes bash not substitute inside the HEREDOC
# inside _must_ be tabs for <<- to remove them when writing
sudo tee "${PROXY_DETECTION_SCRIPT_PATH}" >/dev/null <<-"SCRIPT"
	#!/bin/bash
	HOST=proxy
	PORT=3128
	# in minutes
	FREQUENCY_CHECK=5

	LAST_RESULT_FILE=/tmp/last-proxy-result

	file_if_newer_than_minutes() {
		find "${1}" -mmin "-${2}"
	}

	write_last_result() {
		cat - > "${LAST_RESULT_FILE}"
		chmod 644 "${LAST_RESULT_FILE}"
	}

	LAST_RESULT="$(file_if_newer_than_minutes "${LAST_RESULT_FILE}" "${FREQUENCY_CHECK}")"

	if [ -n "${LAST_RESULT}" ]; then
		cat "${LAST_RESULT}"
	else
		>&2 echo "Checking proxy for ${@}"
		if nc -w2 -z $HOST $PORT; then
				>&2 echo "✓ $HOST:$PORT"
				echo -n "http://${HOST}:${PORT}" | write_last_result
		else
				>&2 echo "🗴 DIRECT"
				echo -n "DIRECT" | write_last_result
		fi
	fi
SCRIPT
sudo chmod +x "${PROXY_DETECTION_SCRIPT_PATH}"
sudo tee "${PROXY_DETECTION_APT_CONF_PATH}" >/dev/null <<APTCONF
    Acquire::http::Proxy-Auto-Detect "${PROXY_DETECTION_SCRIPT_PATH}";
    Acquire::https::Proxy-Auto-Detect "${PROXY_DETECTION_SCRIPT_PATH}";
APTCONF
