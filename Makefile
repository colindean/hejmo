.PHONY: deps
deps: .pre-commit-config.yaml
	brew bundle --file=Brewfile.hejmo
	pre-commit install
	pre-commit install-hooks

