.PHONY: deps
deps: .pre-commit-config.yaml
	brew bundle --no-lock
	pre-commit install
	pre-commit install-hooks

