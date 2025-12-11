{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.bash = {
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps -p $PPID -o command | tail -n +2) != "fish"  ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -xg theme_color_scheme gruvbox
      set -xg theme_nerd_fonts no
      set -xg fish_key_bindings fish_vi_key_bindings
      set -xg theme_show_exit_status no

      zoxide init fish | source
      starship init fish | source
    '';

    plugins = with pkgs; [
      # https://github.com/oh-my-fish/plugin-config
      # omf under the hood stuff
      {
        name = "omf-config";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-config";
          rev = "13c424efb73b153d9b8ad92916cf51159d44099d";
          sha256 = "23hjWq1xdFs8vTv56ebD4GdhcDtcwShaRbHIehPSOXQ=";
          fetchSubmodules = true;
        };
      }
    ];
    shellAliases = {
      k = "kubectl";
      kfi = "kubectl --context gke_fyndiq_europe-west1-b_integration-cluster";
      kfp = "kubectl --context gke_fyndiq_europe-north1-a_prod-cluster";
      kci = "kubectl --context gke_cdon-qlty_europe-west1-b_integration-cluster";
      kcp = "kubectl --context gke_cdon-qlty_europe-north1-a_prod-cluster";
    };
  };

  # Create omf directory structure for plugins
  home.activation.setupOmf = lib.hm.dag.entryAfter ["writeBoundary"] ''
    OMF_DIR="${config.home.homeDirectory}/.local/share/omf"
    if [ ! -d "$OMF_DIR" ]; then
      echo "Creating OMF directory structure..."
      mkdir -p "$OMF_DIR"
      touch "$OMF_DIR/init.fish"
    fi
  '';
}
