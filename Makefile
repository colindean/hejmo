.PHONY: deps
deps: .pre-commit-config.yaml
	brew install pre-commit
	pre-commit install
	pre-commit install-hooks

