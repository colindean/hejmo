.PHONY: deps
deps: .pre-commit-config.yaml
	brew bundle --no-lock --file=Brewfile
	prek install
	prek install-hooks

