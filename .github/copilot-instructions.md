## Definitions

`hejmo` means "home" in Esperanto. This repo contains and manages a UNIX-like OS home directory, including dotfiles.

## Core principles

- Adhere to the UNIX philosophy: tools in this repo should do one thing and do it well.
- Files should "do what they say on the tin," which means their name should immediately indicate what they do.
- Always write bats tests for shell scripts longer than 10 lines or a cyclomatic complexity greater than 5.
- Prefer bash shell scripts for new software, but it's acceptable to write simple things in Python, Ruby, or Perl.
- Prefer `jq` when manipulating JSON, except when searching it deeply for a value, then use `gron`.
- Do not allow the chezmoi setup tests to fail, since that could break my workstations.
- I use both macOS and Linux, so all scripts and tests should be compatible with both, unless the script is very obviously specific to one OS.

## Best practices for resolving Shellcheck info-level errors

Use the shellcheck_shellcheck tool available to you via MCP, if available.

For files with SC2312 failures:

- If the line contains `bkt_cache_` or `JAVA_HOME` then put `# shellcheck disable=SC2312` on the line above it.
- If the line contains `uname -s`, create a variable at the top of the file with the output of that and refer to that variable through the rest of the file instead of calling `uname -s` multiple times. This is more important than the first item.
- If the line has the format `[[ -n "$(command -v <<thing>>)" ]]`, replace that with `command -v <<thing>> > /dev/null`.
- If the line has the format `[[ -z "$(command -v <<thing>>)" ]]`, replace that with `! command -v <<thing>> > /dev/null`.
- If the line has many commands piped to each other, e.g. `something | something_else | lastly`, then put `# shellcheck disable=SC2312` on the line above it.

For lines with SC2230 failures, replace the `which` usage with `command -v`.

For lines with SC2154 failures, check variable emptiness before usage and error-exit if the variable is empty.

For lines with a SC2249 failure, add the default `*)` case and exit with an error, as shellcheck recommends.

For lines with an SC1091 failure:

- if the line sources an absolute path, e.g. `. /etc/something`, then add `# shellcheck source=/dev/null` above it.
- if the line contains `. ${HOME}`, then add `# shellcheck source=/dev/null` above it.

Use these successful PRs as an example of what to do right:

- <https://github.com/colindean/hejmo/pull/83>
