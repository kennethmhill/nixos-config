{
  description = "Ken's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    systems.url = "github:nix-systems/default";

    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      home-manager,
      nix-darwin,
      nixpkgs,
      nixpkgs-unstable,
      systems,
      ...
    }@inputs:
    let
      overlays = [
        (import ./overlays { nixpkgs = nixpkgs-unstable; })
      ];

      mkSystem = import ./lib/mksystem.nix {
        inherit overlays inputs;
      };
      eachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      darwinConfigurations."Mac" = mkSystem "macbook-pro-mx" {
        system = "aarch64-darwin";
        user = "ken";
        darwin = true;
      };

      formatter = eachSystem (system: (import nixpkgs { inherit system; }).nixfmt-tree);
    };
}
