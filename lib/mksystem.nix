{
  nixpkgs,
  inputs,
}: name: {
  system,
  user,
  darwin ? false,
}: let
  hostConfig = ../hosts/${name}.nix;
  userOSConfig =
    ../users/${user}/${
      if darwin
      then "darwin"
      else "nixos"
    }.nix;
  userHMConfig = ../users/${user}/home-manager.nix;

  systemFunc =
    if darwin
    then inputs.darwin.lib.darwinSystem
    else nixpkgs.lib.nixosSystem;
  home-manager =
    if darwin
    then inputs.home-manager.darwinModules
    else inputs.home-manager.nixosModules;
in
  systemFunc rec {
    inherit system;

    modules = [
      hostConfig
      userOSConfig
      home-manager.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = import userHMConfig {
          inputs = inputs;
        };
      }

      {
        config._module.args = {
          currentSystem = system;
          currentSsytem = name;
          currentSystemUser = user;
          inputs = inputs;
        };
      }
    ];
  }
