.PHONY: deps
deps: .pre-commit-config.yaml
	brew bundle --file=brewfiles/Brewfile.hejmo --no-lock
	pre-commit install
	pre-commit install-hooks

