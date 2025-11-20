{ pkgs, ... }:
{
  homebrew = {
    enable = true;
    casks = [ "finch" "ghostty" ];
  };

  nix = {
    settings.trusted-users = [
      "root"
      "ken"
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

  networking.computerName = "ken's MacBook Pro";
  networking.hostName = "Mac";

  system.primaryUser = "ken";

  users.users."ken" = {
    home = "/Users/ken";
    shell = pkgs.zsh;
  };
}
