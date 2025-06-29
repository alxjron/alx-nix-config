# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  specialArgs,
  ...
}: 
let 
  alxpkgs = import ../../pkgs {inherit pkgs;}; 
in
{
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

  xdg.enable = true;

  #programs.plasma = {
  #  enable = true;

  #  workspace = {
  #    clickItemTo = "select";
  #    lookAndFeel = "com.github.vinceliuice.Graphite-dark";
  #    colorScheme = "GraphiteDark";
  #    iconTheme = "breeze-dark";
  #  };
  #};

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
    };
  };

  
  gtk = {
    enable = true;
    theme = {
      package = pkgs.graphite-gtk-theme;
      name = "Graphite-Dark";
    };
    iconTheme = {
      # Again icon pack is broken
      package = alxpkgs.iconpack-obsidian;
      name = "Obsidian-Amber";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = lib.mkForce "qt5ct";
    style = {
      name = "kvantum";
    };
  };

  xdg.configFile = {
    "Kvantum/Graphite".source = "${pkgs.graphite-kde-theme}/share/Kvantum/Graphite";
    "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=GraphiteDark";
    "qt5ct/qt5ct.conf".text = ''
        [Appearance]
        icon_theme=breeze-dark
        style=kvantum
    '';
  };

  home.file.".config" = {
    source = ./dotfiles/.config;
    recursive = true;
  };

  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=alacritty
  '';

  dconf = {
    enable = true;

    settings = {
      "org/gnome/desktop/background" = {
        picture-uri = "file://${alxpkgs.alx-background}/share/wallpapers/nebula_space_red.jpg";
        picture-uir-dark = "file://${alxpkgs.alx-background}/share/wallpapers/nebula_space_red.jpg";
        picture-options = "zoom";
        primary-color = "#000000";
        secondary-color = "#000000";
        color-shading-type = "solid";
      };
      "org/gnome/desktop/interface" = {
        gtk-theme = "Graphite-Dark"; 
	    icon-theme = "Obsidian-Amber";
        accent-color = "red";
        color-scheme = "prefer-dark";
      };
      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Shift><Super>c" ];
      };
      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-timeout = 3600;
      };
      "org/gnome/desktop/session".idle-delay = 0;
      "org/gnome/desktop/screensaver".lock-enabled = false;
    };
  };

  # Add stuff for your user as you see fit:
  programs.alacritty.enable = true;

  home.packages = with pkgs; [ 
    #kdePackages.kde-gtk-config
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    alxpkgs.alx-background
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
