{ pkgs, ... }:

{
  imports = (import ./config);
  manual.manpages.enable = false;
  home = {
    stateVersion = "23.11";
    packages = with pkgs; [
# osx specific
      colima
      utm
# general
      awscli2
      alacritty
      bottom
      cargo
      eza
      fastfetch
      gimp
      gnupg
      go
      hugo
      k9s
      keepassxc
      kubernetes-helm
      kubectx
      kubectl
      lf
      lua
      mpv-unwrapped
      nmap
      nodejs_20
      ollama
      packer
      pre-commit
      qbittorrent
      ripgrep
      rustc
      stylua
      syncthing
      terraform
      teleport
      tflint
      yarn
      yt-dlp
      wireguard-go
    # learning new stuff
      elixir
    ];
  };

  programs = {
    home-manager = {
      enable = true;
    };
    zsh = {
      dotDir = ".config/zsh";
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting = {
	enable = true;
};
      history = {
        expireDuplicatesFirst = true;
        ignoreSpace = true;
        save = 10000;
      };
      shellAliases = {
        ls = "eza --color=auto --git-ignore --git -F --extended";
        grep = "rg";
        diff = "diff --color=auto";
        cp = "cp -iv";
        ka = "killall";
        g = "git";
        sdn = "shutdown -h now";
        v = "nvim";
        z = "zathura";
        ncmp = "ncmpcpp";
      };
      initExtra = ''
        # Nix
        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi
        # End Nix
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
        '';
    };
    starship = {
      enable = true;
      settings = {
        format = builtins.concatStringsSep "" [
        "$directory"
        "$git_branch"
        "$character"
        ];
        git_branch = {
          style = "bold yellow";
        };
        };
    };
    alacritty = {
      enable = true;
      settings = {  
        window = {
          padding = {
          x = 10;
          y = 10;
        };
          decorations = "none";
        };
        font = {
          normal = {
            family = "FiraCode Nerd Font";
            };
          size = 16;
        };
        colors = {
          primary = {
            background = "#001a1d";
            foreground = "#839496";
          };
          normal = {
            black   = "#073642";
            red     = "#dc322f";
            green   = "#859900";
            yellow  = "#b58900";
            blue    = "#268bd2";
            magenta = "#d33682";
            cyan    = "#2aa198";
            white   = "#eee8d5";
          };
          bright = {
            black   = "#4c4c4c";
            red     = "#cb4b16";
            green   = "#586e75";
            yellow  = "#657b83";
            blue    = "#839496";
            magenta = "#6c71c4";
            cyan    = "#93a1a1";
            white   = "#fdf6e3";
        };
        };
      };
    };
    zathura = {
      enable = true;
      options = {
        font = "FiraCode Nerd Font 16";
      };
      };
  };
}
