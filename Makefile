install-brew:
	brew update
	brew bundle

setup-pre-commit:
	pre-commit install
	pre-commit install --hook-type commit-msg

setup: install-brew setup-pre-commit
