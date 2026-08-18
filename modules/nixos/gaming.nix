{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.gaming;
in
{
  options.modules.nixos.gaming.enable =
    lib.mkEnableOption "gaming (Steam, gamemode, mangohud, hardware video accel)";
  config = lib.mkIf cfg.enable {
    hardware.graphics.enable = true;

    services.hardware.bolt.enable = true;

    programs.gamemode = {
      enable = true;
        enableRenice = true;
      settings = {
        cpu = {
          park_cores = "no";
          pin_cores = "4-11";
        };
      };
    };
    programs.steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [ gamemode gamemode.lib ];
      };
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };

    environment.systemPackages = with pkgs; [
      mangohud
      vulkan-tools
      clinfo
    ];
  };
}
