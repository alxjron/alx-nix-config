# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  specialArgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix

  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = specialArgs.username;
    homeDirectory = specialArgs.homeDir;
  };

  services = {
    redshift = {
      enable = true;
      provider = "manual";

      latitude = "40";
      longitude = "-110";

      dawnTime = "6:00-7:45";
      duskTime = "18:00-20:00";

      temperature = {
        day = 5500;
        night = 3700;
      };
      tray = true;
    };
  };

  # some nice shell functions
  programs.bash = {
    enable = true;
    shellAliases = {
      sd = "cd $(fd -t d | fzf)";
      sdh = "cd $(fd -t d --search-path ~ | fzf)";
      sdr = "cd $(fd -t d --search-path / | fzf)";
    };
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [ 
    libsForQt5.okular
    celluloid
    rhythmbox
    evolution
    libreoffice-fresh
    hunspell
    hunspellDicts.en_US
    libsForQt5.spectacle
    isoimagewriter
    gparted
    protonvpn-gui
    libsForQt5.kalgebra
    rclone
    tmux
    libsForQt5.kalarm
    brave
    librewolf
    keepassxc
    gimp
    ffmpeg
    # torrent client idk which one
    zip
    unzip

    fd
    fzf
  ];
  

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
