{config, pkgs, ...}: 
let 
  alxpkgs = import ../../pkgs {inherit pkgs;}; 
in
{

  services = {
    #displayManager.defaultSession = "mate";
    xserver = {
      displayManager.lightdm.enable = true;
      desktopManager.gnome.enable = true;

      excludePackages = [
        pkgs.xterm
      ];

      xkb.layout = "us";
      xkb.variant = "";
    };
    gvfs.enable = true;
    #picom = {
    #  enable = true;
    #  vSync = true;
    #};

    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish.enable = true;
      publish.userServices = true;
    };

    blueman.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    logind = {
      lidSwitch = "suspend-then-hibernate";
    };
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1h
  '';

  services.pulseaudio.enable = false;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  security.rtkit.enable = true;

  programs.thunar.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  environment.systemPackages = with pkgs; [
    rofi
    rofimoji
    rofi-calc
    networkmanagerapplet
    #mate.mate-tweak
    xclip
    alacritty

    # The package is broken now because of course it is
    #iconpack-obsidian
    alxpkgs.iconpack-obsidian

    graphite-gtk-theme
    graphite-kde-theme
    kdePackages.ocean-sound-theme
    kdePackages.breeze-icons

    libgcc
    curl
    gnutar
    file
  ];

  environment.variables = {
    QT_STYLE_OVERRIDE = "kvantum";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    GTK_USE_PORTAL = 1;
  };

  services.gnome.core-apps.enable = false;

  environment.gnome.excludePackages = with pkgs; [
    gnome-characters
    gnome-music
    gnome-photos
    gnome-terminal
    gnome-tour
    gnome-calculator
  ];

  system.stateVersion = "24.05";
}
