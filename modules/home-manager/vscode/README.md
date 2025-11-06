# VSCode Configuration

This module configures VSCode through Nix with settings and extensions.

## Extensions

Extensions are defined in `extensions.json` and can be installed by running:

```bash
vscode-install-extensions
```

This script is automatically available after building the Nix configuration.

## Adding New Extensions

1. Add the extension ID to `extensions.json` in the `recommendations` array
2. Rebuild your Nix configuration: `sudo darwin-rebuild switch --flake .#pradipcaulagi`
3. Run `vscode-install-extensions` to install the new extensions

## Extensions Directory

Extensions are installed to `~/.vscode-extensions/` which is a writable directory, allowing extensions like GitHub Copilot to download additional components as needed.
