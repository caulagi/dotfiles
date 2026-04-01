switch:
	sudo -E darwin-rebuild switch --impure --flake .#darwin

switch-linux:
	export PATH=/nix/var/nix/profiles/default/bin:$$HOME/.nix-profile/bin:$$PATH && home-manager switch --flake .#playgroundpc

bootstrap-cloudshell:
	curl -fsSL https://install.determinate.systems/nix | sh -s -- install linux --no-start-daemon
	. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
	sudo /nix/var/nix/profiles/default/bin/nix-daemon &
	export PATH=/nix/var/nix/profiles/default/bin:$$PATH && nix run home-manager/master -- switch --flake .#playgroundpc -b backup
