#!/usr/bin/env pwsh
# Configures VSCode on the Windows host to match the Nix/home-manager setup in
# modules/home-manager/vscode: the recommended extensions and the editor
# settings (look and feel). VSCode runs on Windows for WSL development, so this
# is the host-side counterpart of that module.
#
#   pwsh -ExecutionPolicy Bypass -File windows/install-vscode.ps1
$ErrorActionPreference = 'Stop'

# Ensure VSCode is installed.
if (-not (Get-Command code -ErrorAction SilentlyContinue)) {
    Write-Host 'Installing Visual Studio Code via winget...'
    winget install --id Microsoft.VisualStudioCode -e `
        --accept-package-agreements --accept-source-agreements --disable-interactivity
}

# Resolve the code CLI (it may not be on PATH yet right after a fresh install).
$codeCmd = Get-Command code -ErrorAction SilentlyContinue
$code = if ($codeCmd) { $codeCmd.Source } else {
    @(
        (Join-Path $env:LOCALAPPDATA 'Programs\Microsoft VS Code\bin\code.cmd'),
        'C:\Program Files\Microsoft VS Code\bin\code.cmd'
    ) | Where-Object { Test-Path $_ } | Select-Object -First 1
}
if (-not $code) { throw 'Could not locate the VSCode `code` CLI.' }

# VSCode/Electron uses Node's bundled CA list, not the Windows cert store, so on
# a network with a TLS-inspecting proxy (corporate root CA) marketplace
# downloads fail with "self signed certificate in certificate chain". Export the
# Windows trusted roots to a PEM and point Node at it for the install.
$caBundle = Join-Path $env:TEMP 'windows-root-cas.pem'
$pem = Get-ChildItem Cert:\LocalMachine\Root | ForEach-Object {
    $b64 = [System.Convert]::ToBase64String($_.RawData, 'InsertLineBreaks')
    "-----BEGIN CERTIFICATE-----`n$b64`n-----END CERTIFICATE-----"
}
Set-Content -Path $caBundle -Value ($pem -join "`n") -Encoding ascii
$env:NODE_EXTRA_CA_CERTS = $caBundle

# Install the recommended extensions. Single source of truth is the Nix module's
# extensions.json, so the host and WSL stay in sync.
$extJson = Join-Path $PSScriptRoot '..\modules\home-manager\vscode\extensions.json'
$extensions = (Get-Content $extJson -Raw | ConvertFrom-Json).recommendations
Write-Host "Installing $($extensions.Count) extensions..."
foreach ($ext in $extensions) {
    & $code --install-extension $ext --force
}

# Apply settings (look and feel), backing up any existing settings.json.
$userDir = Join-Path $env:APPDATA 'Code\User'
New-Item -ItemType Directory -Force -Path $userDir | Out-Null
$dest = Join-Path $userDir 'settings.json'
if (Test-Path $dest) { Copy-Item $dest "$dest.backup" -Force }
Copy-Item (Join-Path $PSScriptRoot 'vscode-settings.json') $dest -Force
Write-Host "Wrote $dest"
