{pkgs}: {
  type = "app";
  program = toString (pkgs.writeShellScript "install-dotnet" ''
    set -e
    nix profile add nixpkgs#dotnet-sdk
    code --install-extension ms-dotnettools.csdevkit
    code --install-extension ms-dotnettools.csharp
    code --install-extension ms-dotnettools.dotnet-maui
    code --install-extension ms-dotnettools.vscode-dotnet-runtime
  '');
}
