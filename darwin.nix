{ pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  users.users.pvl = {
    home = "/Users/pvl";
    shell = pkgs.zsh;
  };

  networking = {
    computerName = "darwin";
    hostName = "darwin";
  };

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.commit-mono
  ];

  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      git
      curl
      coreutils
      jq
      wget
    ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  programs = {
    zsh.enable = true;
  };

  services = {
    skhd = {
      enable = true;
      skhdConfig = builtins.readFile ./skhdrc;
    };
  };

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    brews = [
      "syncthing"
      "tailscale"
    ];
    casks = [
      "appcleaner"
      "battery"
      "caffeine"
      "chatgpt"
      "dbeaver-community"
      "obs"
      "aws-vpn-client"
      "session-manager-plugin"
      "slack"
      "openvpn-connect"
      "discord"
      "spotify"
      "raycast"
      "nikitabobko/tap/aerospace"
      "windows-app"
      "obsidian"
      "ghostty"
      "firefox"
      "whisky"
      "brave-browser"
      "iina"
    ];
  };

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
  };

  system = {
    primaryUser = "pvl";
    defaults = {
      NSGlobalDomain = {
        KeyRepeat = 1;
        InitialKeyRepeat = 14;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };
      dock = {
        autohide = true;
        autohide-delay = 0.2;
        static-only = true;
      };
      finder = {
        _FXShowPosixPathInTitle = true;
        CreateDesktop = false;
        FXPreferredViewStyle = "Nlsv";
        QuitMenuItem = true;
      };
      screencapture.disable-shadow = true;
    };
    activationScripts.postActivation.text = ''sudo chsh -s ${pkgs.zsh}/bin/zsh''; # declare shell
    stateVersion = 4;
  };
}
