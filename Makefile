.PHONY: deps
deps: .pre-commit-config.yaml
	brew bundle --file=Brewfile.hejmo --no-lock
	pre-commit install
	pre-commit install-hooks

