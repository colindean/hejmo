.PHONY: deps
deps: .pre-commit-config.yaml
	brew bundle --no-lock --file=Brewfile
	pre-commit install
	pre-commit install-hooks

