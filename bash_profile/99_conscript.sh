#!/usr/bin/env bash

export CONSCRIPT_HOME="${HOME}/.conscript"
if [[ -d "${CONSCRIPT_HOME}" ]]; then
	export CONSCRIPT_OPTS="-XX:MaxPermSize=512M -Dfile.encoding=UTF-8"
	export PATH="${CONSCRIPT_HOME}/bin:${PATH}"
fi
