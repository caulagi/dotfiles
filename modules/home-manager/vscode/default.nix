{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        dbaeumer.vscode-eslint
        eamodio.gitlens
        editorconfig.editorconfig
        github.copilot
        golang.go
        hashicorp.terraform
        jdinhlife.gruvbox
        ms-python.python
        ms-python.vscode-pylance
        pkief.material-icon-theme
        redhat.vscode-yaml
        rust-lang.rust-analyzer
        timonwong.shellcheck
        vscode-icons-team.vscode-icons
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
      };
    };
  };
}
