#!/usr/bin/env pwsh
# Installs FiraCode Nerd Font for the current user (no admin required).
# Used by the WezTerm terminal config and the VSCode editor font.
#
#   pwsh -ExecutionPolicy Bypass -File windows/install-firacode.ps1
$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$url = 'https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip'
$tmp = Join-Path $env:TEMP 'FiraCodeNF.zip'
$ext = Join-Path $env:TEMP 'FiraCodeNF'

Write-Host "Downloading $url ..."
Invoke-WebRequest -Uri $url -OutFile $tmp
if (Test-Path $ext) { Remove-Item -Recurse -Force $ext }
Expand-Archive -Path $tmp -DestinationPath $ext -Force

$dest = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
$reg = 'HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts'

$count = 0
foreach ($f in Get-ChildItem $ext -Filter '*.ttf' -Recurse) {
    $target = Join-Path $dest $f.Name
    Copy-Item $f.FullName $target -Force
    $name = [System.IO.Path]::GetFileNameWithoutExtension($f.Name) + ' (TrueType)'
    New-ItemProperty -Path $reg -Name $name -Value $target -PropertyType String -Force | Out-Null
    $count++
}
Write-Host "Installed $count FiraCode Nerd Font files to $dest"
