{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fish
  ];
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
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
      '';
    };
  };
}
