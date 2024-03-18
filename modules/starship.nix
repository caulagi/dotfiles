{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    starship
  ];
  home-manager.users.pradipcaulagi = {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        gcloud.disabled = true;
        kubernetes.disabled = false;
        shell.disabled = false;
        python.disabled = false;
        character.vimcmd_symbol = "[ ](bold green)";
        git_commit.only_detached = false;

        battery = {
          disabled = true;
          display = [
            {
              threshold = "30";
              style = "bold red";
            }
            {
              threshold = "90";
              style = "bold yellow";
            }
          ];
        };
      };
    };
  };
}
