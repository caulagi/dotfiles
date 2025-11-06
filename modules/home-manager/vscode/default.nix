{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.vscode = {
    enable = true;
    # Wrap VSCode to use custom extensions directory
    package =
      (pkgs.symlinkJoin {
        name = "vscode-wrapped";
        paths = [pkgs.vscode];
        nativeBuildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/code \
            --add-flags "--extensions-dir ${config.home.homeDirectory}/.vscode-extensions"
        '';
      })
      // {
        pname = pkgs.vscode.pname;
        version = pkgs.vscode.version;
      };
    mutableExtensionsDir = true;

    profiles.default = {
      # Let Nix be the single source of truth
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions =
        # Curated extensions that exist in nixpkgs:
        (with pkgs.vscode-extensions; [
          dbaeumer.vscode-eslint
          eamodio.gitlens
          editorconfig.editorconfig
          github.copilot
          github.copilot-chat
          github.vscode-github-actions
          golang.go
          hashicorp.terraform
          jdinhlife.gruvbox
          pkief.material-icon-theme
          redhat.vscode-yaml
          rust-lang.rust-analyzer
        ])
        # Marketplace-only (or newer) extensions fetched generically:
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            publisher = "anthropic";
            name = "claude-code";
            version = "2.0.33";
            sha256 = "sha256-Bl/Rjp3nvY8KmftajnXu/OW+O9MXq3mYii0tLZTMXoA=";
          }
          {
            publisher = "ms-python";
            name = "python";
            version = "2025.17.2025110501";
            sha256 = "sha256-Ge3ZSobngd0WnIE6eyoOmICQm5ANS5mBR1GPp9/FJag=";
          }
        ];

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
}
