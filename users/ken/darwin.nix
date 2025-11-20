{ pkgs, ... }:
{
  homebrew = {
    enable = true;
    casks = [ "finch" "ghostty" ];
  };

  nix = {
    enable = false;
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
