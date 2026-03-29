.PHONY: deps
deps: .prek-config.yaml
	brew bundle --no-lock --file=Brewfile
	prek install
	prek install-hooks

