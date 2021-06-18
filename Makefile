install-brew:
	brew update
	brew bundle

setup-pre-commit:
	pre-commit install

setup: install-brew setup-pre-commit
