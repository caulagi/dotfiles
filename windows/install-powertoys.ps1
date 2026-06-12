#!/usr/bin/env pwsh
# Installs Microsoft PowerToys on the Windows host.
#
#   pwsh -ExecutionPolicy Bypass -File windows/install-powertoys.ps1
$ErrorActionPreference = 'Stop'

Write-Host 'Installing PowerToys via winget...'
winget install --id Microsoft.PowerToys -e `
    --accept-package-agreements --accept-source-agreements --disable-interactivity
