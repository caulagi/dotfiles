switch:
	sudo darwin-rebuild switch --flake .#office-laptop

switch-linux:
	export PATH=/nix/var/nix/profiles/default/bin:$$HOME/.nix-profile/bin:$$PATH && home-manager switch --flake .#home-laptop
	@# Replace Nix store symlinks with writable copies for Cloud Shell compatibility
	@for f in ~/.bashrc ~/.profile; do \
		if [ -L "$$f" ]; then \
			cp --remove-destination "$$(readlink -f $$f)" "$$f"; \
		fi; \
	done

switch-wsl:
	export PATH=/nix/var/nix/profiles/default/bin:$$HOME/.nix-profile/bin:$$PATH && home-manager switch --flake .#wsl

bootstrap-cloudshell:
	curl -fsSL https://install.determinate.systems/nix | sh -s -- install linux --no-start-daemon
	. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
	sudo /nix/var/nix/profiles/default/bin/nix-daemon &
	export PATH=/nix/var/nix/profiles/default/bin:$$PATH && nix run home-manager/master -- switch --flake .#home-laptop -b backup

# Bootstrap a WSL (Windows Subsystem for Linux) distro: install Nix if missing,
# then home-manager, which pulls in neovim and gcloud (declared in
# modules/home-manager/default.nix) along with the rest of the environment.
bootstrap-wsl:
	@if ! command -v nix >/dev/null 2>&1 && [ ! -x /nix/var/nix/profiles/default/bin/nix ]; then \
		curl -fsSL https://install.determinate.systems/nix | sh -s -- install linux --init none --no-confirm; \
	fi
	export PATH=/nix/var/nix/profiles/default/bin:$$HOME/.nix-profile/bin:$$PATH && \
		nix run home-manager/master -- switch --flake .#wsl -b backup

.PHONY: switch switch-linux switch-wsl bootstrap-cloudshell bootstrap-wsl
