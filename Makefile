switch:
	sudo darwin-rebuild switch --flake .#darwin

switch-linux:
	export PATH=/nix/var/nix/profiles/default/bin:$$HOME/.nix-profile/bin:$$PATH && home-manager switch --flake .#playgroundpc
	@# Replace Nix store symlinks with writable copies for Cloud Shell compatibility
	@for f in ~/.bashrc ~/.profile; do \
		if [ -L "$$f" ]; then \
			cp --remove-destination "$$(readlink -f $$f)" "$$f"; \
		fi; \
	done

bootstrap-cloudshell:
	curl -fsSL https://install.determinate.systems/nix | sh -s -- install linux --no-start-daemon
	. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
	sudo /nix/var/nix/profiles/default/bin/nix-daemon &
	export PATH=/nix/var/nix/profiles/default/bin:$$PATH && nix run home-manager/master -- switch --flake .#playgroundpc -b backup
