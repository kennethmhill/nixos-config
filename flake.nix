{

  description = "Ken's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    systems.url = "github:nix-systems/default";

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      darwin,
      systems,
      ...
    }@inputs:
    let
      overlays = [ ];

      mkSystem = import ./lib/mksystem.nix {
        inherit overlays nixpkgs inputs;
      };
      eachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {

      darwinConfigurations."Mac" = mkSystem "macbook-pro-mx" {
        system = "aarch64-darwin";
        user = "ken";
        darwin = true;
      };

      devShells = eachSystem (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        with pkgs;
        {
          default = mkShell {
            packages = [ ];
          };
        }
      );

      formatter = eachSystem (system: (import nixpkgs { inherit system; }).nixfmt-rfc-style);
    };
}
