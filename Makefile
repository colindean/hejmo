.PHONY: deps
deps: .pre-commit-config.yaml
	brew bundle --file=Brewfile
	prek install
	prek install-hooks

