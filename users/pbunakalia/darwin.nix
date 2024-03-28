{ inputs, pkgs, ... }:
{

users.users.pbunakalia = {
    home = "/Users/pbunakalia";
    shell = pkgs.zsh;
  };
homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    taps = [ "koekeishiya/formulae" ];
    masApps = { };
    casks = [
      "amethyst"
      "battery"
      "discord"
      "firefox"
      "obs"
      "mullvadvpn"
      "raycast"
      "aws-vpn-client"
      "session-manager-plugin"
      "slack"
      "tor-browser"
      "telegram-desktop"
      "tunnelblick"
    ];
  };
}
