{ pkgs, ... }:
{
  system.primaryUser = "ken";

  homebrew = {
    enable = true;
    casks = [
      "finch"
    ];
  };

  programs.zsh.enable = true;

  services.lorri.enable = true;

  networking.computerName = "ken's MacBook Pro";
  networking.hostName = "Mac";

  users.users."ken" = {
    home = "/Users/ken";
    shell = pkgs.zsh;
  };
}
