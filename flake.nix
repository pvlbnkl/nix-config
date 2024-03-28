{
  description = "pvl flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs: let 

    mkSystem = import ./lib/mksystem.nix {
      inherit nixpkgs inputs;
      };
  in {
    darwinConfigurations.darwin = mkSystem "darwin" {
        system = "aarch64-darwin";
        user   = "pbunakalia";
        darwin = true;
    };
  };
}
