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

    #inputs.ninecraft.homeManagerModule
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

  # Steam doesn't exist on home-manager >:(
  #programs.steam.enable = true;

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [  
    prismlauncher   # Official Minecraft launcher is broken on NixOS
    #minetest
    luanti
  ];

#  programs.ninecraft = {
#    enable = true;
#    version = "0.6.0";
#    apk = lib.fetchzip {
#      url = "https://archive.org/download/MCPEAlpha/PE-a0.7.0-x86.apk";
#      hash = lib.fakeHash;
#    };
#    options = {
#      "mp_username"="Steve";
#      "mp_server"="Steve";
#      "mp_server_visible_default"=true;
#      "gfx_fancygraphics"=true;
#      "gfx_lowquality"=false;
#      "ctrl_sensitivity"=0.5;
#      "ctrl_invertmouse"=false;
#      "ctrl_islefthanded"=false;
#      "ctrl_usetouchscreen"=false;
#      "ctrl_usetouchjoypad"=false;
#      "feedback_vibration"=false;
#      "game_difficulty"=4;
#    };
#  };
  

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
