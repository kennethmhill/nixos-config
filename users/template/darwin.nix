{ pkgs, ... }:
{
  homebrew = {
    enable = true;
    casks = [ "finch" "ghostty" ];
  };

  nix = {
    settings.trusted-users = [
      "root"
      "<YOUR_USERNAME>"
      "@admin"
    ];

    linux-builder = {
      enable = true;
      ephemeral = true;
      maxJobs = 4;
      config = {
        virtualisation = {
          darwin-builder = {
            diskSize = 40 * 1024;
            memorySize = 8 * 1024;
          };
          cores = 6;
        };
      };  
    };

    distributedBuilds = true;

    extraOptions = ''
      builders-use-substitutes = true
    '';
  };

  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;

  services.lorri.enable = true;

  networking.computerName = "<YOUR_COMPUTER_NAME>";
  networking.hostName = "<YOUR_HOSTNAME>";

  system.primaryUser = "<YOUR_USERNAME>";

  users.users."<YOUR_USERNAME>" = {
    home = "<YOUR_HOME_DIRECTORY>";
    shell = pkgs.zsh;
  };
}
