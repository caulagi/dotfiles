USER ?= $(shell whoami)

switch:
	sudo -E darwin-rebuild switch --impure --flake .#$(USER)
