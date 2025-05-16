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
  
  gtk = {
    enable = true;
    theme = {
      package = pkgs.graphite-gtk-theme;
      name = "Graphite-Dark";
    };
    iconTheme = {
      package = pkgs.iconpack-obsidian;
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
      "org/mate/desktop/session/required-components" = {
        filemanager = "";
        windowmanager = "i3";
      };
      "org/mate/desktop/background" = {
        show-desktop-icons = false;
        picture-filename = "${alxpkgs.alx-background}/share/wallpapers/nebula_space_red.jpg";
        picture-options = "zoom";
        color-shading-type = "solid";
        primary-color = "rgb(0,0,0)";
      };
      "org/mate/desktop/sound" = {
        theme-name = "ocean";
        event-sounds = true;
      };
      "org/mate/desktop/interface" = {
        document-font-name = "Sans 10";
        font-name = "Monospace 10";

        gtk-theme = "Graphite-Dark";
	    #gtk-theme = "Adwaita-dark";
	    icon-theme = "Obsidian-Amber";
      };
      "org/mate/caja/desktop" = {
        font = "Monospace Bold 10";
      };
      "org/mate/desktop/peripherals/touchpad" = {
        horizontal-edge-scrolling = true;
      };

      "org/mate/notification-daemon" = {
        theme = "standard";
        popup-location = "bottom_right";
      };

      "org/mate/panel/general" = {
        object-id-list = [ "menu-bar" "notification-area" "clock" "window-list" "workspace-switcher" "object-0" ];
	    toplevel-id-list = [ "top" "bottom" ];
      };
      "org/mate/panel/object/workspace-switcher/prefs" = {
        display-workspace-name = true;
      };
      "org/mate/panel/objects/clock" = {
        applet-iid = "ClockAppletFactory::ClockApplet";
        locked = true;
        object-type = "applet";
	    panel-right-stick = true;
	    position = 0;
	    toplevel-id = "top";
      };
      "org/mate/panel/objects/menu-bar" = {
        locked = true;
        object-type = "menu-bar";
        position = 0; 
	    toplevel-id = "top";
      };
      "org/mate/panel/objects/notification-area" = {
        applet-iid = "NotificationAreaAppletFactory::NotificationArea";
        locked = true;
	    object-type = "applet";
	    panel-right-stick = true;
	    position = 10;
	    toplevel-id = "top";
      };
      "org/mate/panel/objects/object-0" = {
        applet-iid = "MultiLoadAppletFactory::MultiLoadApplet";
        locked = true;
        object-type = "applet";
        panel-right-stick = false;
        position = 1108;
        toplevel-id = "top";
      };
      "org/mate/panel/objects/object-0/prefs" = {
        view-memload = true;
        view-netload = true;
      };
      "org/mate/panel/objects/window-list" = {
        applet-iid = "WnckletFactory::WindowListApplet";
        locked = true;
        object-type = "applet";
        position = 248;
        toplevel-id = "top";
      };
      "org/mate/panel/objects/workspace-switcher" = {
        applet-iid = "WnckletFactory::WorkspaceSwitcherApplet";
        locked = true;
        object-type = "applet";
        panel-right-stick = false;
        position = 0;
        toplevel-id = "bottom";
      };
      "org/mate/panel/objects/workspace-switcher/prefs" = {
        display-all-workspaces = true;
        display-workspace-names = true;
        wrap-workspaces = false;
      };
      "org/mate/panel/toplevels/bottom" = {
        expand = true;
        orientation = "bottom";
        screen = 0;
        size = 24;
        y = 744;
        y-bottom = 0;
      };

      "org/mate/panel/toplevels/top" = {
        expand = true;
        orientation = "top";
        screen = 0;
        size = 24;
      };

      "org/mate/power-manager" = {
        action-critical-battery = "hibernate";
        button-lid-ac = "suspend";
        button-lid-battery = "suspend";
        button-power = "interactive";
        button-suspend = "suspend";
        icon-policy = "present";
        sleep-computer-ac = 0;
        sleep-computer-battery = 1800;
      };

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
