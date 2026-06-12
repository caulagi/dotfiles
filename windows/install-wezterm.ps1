#!/usr/bin/env pwsh
# Installs WezTerm on the Windows host and the WezTerm config that opens
# straight into the Ubuntu WSL distro.
#
# WezTerm is the terminal emulator; it runs on Windows, not inside WSL, so it
# cannot be installed via Nix/home-manager. Run this from Windows PowerShell:
#
#   pwsh -ExecutionPolicy Bypass -File windows/install-wezterm.ps1
#
# After install, set WezTerm as the default terminal in
# Settings -> Privacy & security -> For developers -> Terminal, or just launch
# it directly. Use Ctrl+Shift+R to reload the config in a running window.
$ErrorActionPreference = 'Stop'

Write-Host 'Installing WezTerm via winget...'
winget install --id wez.wezterm -e `
    --accept-package-agreements --accept-source-agreements --disable-interactivity

$src = Join-Path $PSScriptRoot 'wezterm.lua'
$dest = Join-Path $env:USERPROFILE '.wezterm.lua'
Write-Host "Installing config -> $dest"
Copy-Item $src $dest -Force

Write-Host 'Done. Note: the FiraCode Nerd Font referenced by the config is'
Write-Host 'installed separately by windows/install-firacode.ps1.'
