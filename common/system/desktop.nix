{config, pkgs, ...}: 
let 
  alxpkgs = import ../../pkgs {inherit pkgs;}; 
in
{

  xdg.portal.enable = true;
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

    flatpak.enable = true;
  };

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1h
  '';

  services.pulseaudio.enable = false;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  security.rtkit.enable = true;

  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.tumbler.enable = true; # Thumbnail support for images

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

  environment.mate.excludePackages = with pkgs; [
    mate.caja
    mate.pluma
    mate.mate-terminal
  ];

  system.stateVersion = "24.05";
}
