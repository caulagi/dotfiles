{
  pkgs,
  lib,
  config,
  ...
}: let
  extensionsJson = ./extensions.json;
  extensionsData = builtins.fromJSON (builtins.readFile extensionsJson);
  extensionsList = builtins.concatStringsSep " " extensionsData.recommendations;
in {
  programs.vscode = {
    enable = true;
    # Wrap VSCode to use custom extensions directory and install extensions
    package =
      (pkgs.symlinkJoin {
        name = "vscode-wrapped";
        paths = [pkgs.vscode];
        nativeBuildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/code \
            --add-flags "--extensions-dir ${config.xdg.dataHome}/vscode/extensions"

          # Create a script to install extensions
          cat > $out/bin/vscode-install-extensions << 'EOF'
          #!/bin/sh
          EXTENSIONS="${extensionsList}"
          for ext in $EXTENSIONS; do
            ${pkgs.vscode}/bin/code --extensions-dir ${config.xdg.dataHome}/vscode/extensions --install-extension "$ext" 2>/dev/null || true
          done
          EOF
          chmod +x $out/bin/vscode-install-extensions
        '';
      })
      // {
        pname = pkgs.vscode.pname;
        version = pkgs.vscode.version;
        meta = pkgs.vscode.meta // {
          mainProgram = "code";
        };
      };
    mutableExtensionsDir = true;

    profiles.default = {
      # Let Nix be the single source of truth
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      userSettings = {
        # Kubernetes settings
        "vs-kubernetes.crd-code-completion" = "enabled";

        # Editor settings
        "editor.fontLigatures" = true;
        "editor.fontFamily" = "'FiraCode Nerd Font', Menlo, Monaco, 'Courier New', monospace";
        "editor.renderWhitespace" = "all";
        "editor.suggestSelection" = "first";
        "editor.find.addExtraSpaceOnTop" = false;
        "editor.minimap.enabled" = false;
        "editor.inlineSuggest.enabled" = true;
        "editor.fontSize" = 13;
        "editor.multiCursorModifier" = "ctrlCmd";

        # Workbench settings
        "workbench.startupEditor" = "newUntitledFile";
        "workbench.editor.enablePreview" = false;
        "workbench.editor.enablePreviewFromQuickOpen" = false;
        "workbench.iconTheme" = "vscode-icons";
        "workbench.colorTheme" = "Gruvbox Dark Medium";
        "workbench.editorAssociations" = {
          "*.ipynb" = "jupyter.notebook.ipynb";
        };

        # Files settings
        "files.autoSave" = "afterDelay";
        "files.trimTrailingWhitespace" = true;
        "files.associations" = {
          "*.hcl" = "terraform";
          "*.j2" = "python";
          "*.tfvars" = "terraform";
          "*.yml" = "yaml";
        };

        # Explorer settings
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;

        # Language specific settings
        "[dockerfile]" = {
          "editor.defaultFormatter" = "ms-azuretools.vscode-docker";
        };
        "[python]" = {
          "editor.formatOnPaste" = false;
          "editor.formatOnSave" = true;
        };
        "[json]" = {
          "editor.tabSize" = 2;
        };
        "[terraform]" = {
          "editor.defaultFormatter" = "hashicorp.terraform";
        };

        # Python settings
        "python.formatting.provider" = "black";
        "python.linting.flake8Enabled" = true;
        "python.linting.flake8Args" = [
          "--ignore = E302"
          "--max-line-length = 119"
        ];
        "python.testing.unittestEnabled" = true;

        # Terraform settings
        "terraform.indexing" = {
          "enabled" = false;
          "liveIndexing" = false;
          "delay" = 500;
          "exclude" = [
            ".terraform/**/*"
            "**/.terraform/**/*"
          ];
        };
        "terraform.languageServer.enable" = true;

        # YAML settings
        "yaml.schemaStore.enable" = true;
        "yaml.validate" = true;

        # Go settings
        "go.toolsManagement.autoUpdate" = true;

        # Other settings
        "vsintellicode.modify.editor.suggestSelection" = "automaticallyOverrodeDefaultValue";
        "redhat.telemetry.enabled" = false;
        "docker.showStartPage" = false;

        # GitHub Copilot settings
        "github.copilot.enable" = {
          "*" = true;
          "yaml" = true;
          "plaintext" = true;
          "markdown" = true;
        };
        "github.copilot.chat.enable" = {
          "*" = true;
        };

        "claudeCode.environmentVariables" = [
          {
            "name" = "CLAUDE_CODE_USE_VERTEX";
            "value" = "true";
          }
          {
            "name" = "CLOUD_ML_REGION";
            "value" = "europe-west1";
          }
          {
            "name" = "ANTHROPIC_VERTEX_PROJECT_ID";
            "value" = "platform-ai-hub-infra-0c91";
          }
          {
            "name" = "ANTHROPIC_MODEL";
            "value" = "claude-sonnet-4-5@20250929";
          }
        ];
        "claudeCode.selectedModel" = "claude-sonnet-4-5@20250929";
      };
    };
  };

  # Automatically install extensions on activation
  home.activation.installVSCodeExtensions = lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo "Installing VSCode extensions..."
    EXTENSIONS="${extensionsList}"
    for ext in $EXTENSIONS; do
      $DRY_RUN_CMD ${pkgs.vscode}/bin/code --extensions-dir ${config.xdg.dataHome}/vscode/extensions --install-extension "$ext" 2>/dev/null || true
    done
  '';
}
