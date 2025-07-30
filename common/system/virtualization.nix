{config, pkgs, ...}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
      #vhostUserPackages = with pkgs; [ virtiofsd ];
    };
  };

  virtualisation.podman.enable = true;
  users.users = {
    alxjron.extraGroups = ["libvirtd"];
  };
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    virtiofsd
  ];

  system.stateVersion = "24.05";
}
