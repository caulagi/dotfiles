# Windows host setup for WSL

Companion setup that runs on the **Windows** side to support the WSL
environment configured by Nix/home-manager (the `wsl` host in `hosts.nix`).

A terminal emulator and fonts live on the Windows host, not inside the distro,
so they cannot be managed by home-manager. Run these scripts from Windows
PowerShell (`pwsh`).

Because the scripts live on the WSL `\\wsl.localhost\...` path, Windows treats
them as remote and the default execution policy blocks them, so each command
passes `-ExecutionPolicy Bypass`.

## WezTerm

```powershell
pwsh -ExecutionPolicy Bypass -File windows/install-wezterm.ps1
```

Installs WezTerm via `winget` and copies `wezterm.lua` to
`%USERPROFILE%\.wezterm.lua`. The config opens directly into the Ubuntu WSL
distro and mirrors the look of the old in-distro WezTerm config.

## FiraCode Nerd Font

```powershell
pwsh -ExecutionPolicy Bypass -File windows/install-firacode.ps1
```

Installs FiraCode Nerd Font for the current user. Referenced by the WezTerm
config above and the VSCode editor font.

## VSCode

```powershell
pwsh -ExecutionPolicy Bypass -File windows/install-vscode.ps1
```

Installs VSCode (if missing), the recommended extensions, and the editor
settings (look and feel) on the host. Mirrors `modules/home-manager/vscode`;
extensions come from that module's `extensions.json` so host and WSL stay in
sync, and settings are written to `%APPDATA%\Code\User\settings.json`.

## PowerToys

```powershell
pwsh -ExecutionPolicy Bypass -File windows/install-powertoys.ps1
```

Installs Microsoft PowerToys via `winget`.
