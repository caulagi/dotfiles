# Windows host setup for WSL

Companion setup that runs on the **Windows** side to support the WSL
environment configured by Nix/home-manager (the `wsl` host in `hosts.nix`).

A terminal emulator and fonts live on the Windows host, not inside the distro,
so they cannot be managed by home-manager. Run these scripts from Windows
PowerShell (`pwsh`):

## WezTerm

```powershell
pwsh -File windows/install-wezterm.ps1
```

Installs WezTerm via `winget` and copies `wezterm.lua` to
`%USERPROFILE%\.wezterm.lua`. The config opens directly into the Ubuntu WSL
distro and mirrors the look of the old in-distro WezTerm config.

## FiraCode Nerd Font

```powershell
pwsh -File windows/install-firacode.ps1
```

Installs FiraCode Nerd Font for the current user. Referenced by the WezTerm
config above and the VSCode editor font.
