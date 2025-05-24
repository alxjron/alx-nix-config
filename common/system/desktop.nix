{config, pkgs, ...}: {

  services = {
    displayManager.defaultSession = "mate";
    xserver = {
      displayManager.lightdm.enable = true;
      desktopManager.mate.enable = true;
      desktopManager.mate.enableWaylandSession = false;
      windowManager.i3.enable = true;

      excludePackages = [
        pkgs.xterm
      ];

      xkb.layout = "us";
      xkb.variant = "";
    };
    gvfs.enable = true;
    picom = {
      enable = true;
      vSync = true;
    };

    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
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

  hardware.pulseaudio.enable = false;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
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
    mate.mate-tweak
    xclip
    alacritty

    iconpack-obsidian
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

  environment.mate.excludePackages = with pkgs; [
    mate.caja
    mate.pluma
    mate.mate-terminal
  ];

  system.stateVersion = "24.05";
}
