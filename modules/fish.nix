{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fish
  ];
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps -p $PPID -o command | tail -n +2) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
  home-manager.users.pradipcaulagi = {
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
        ki = "kubectl --context gke_fyndiq_europe-west1-b_integration-cluster";
      };
    };
  };
}
