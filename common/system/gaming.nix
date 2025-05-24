{config, pkgs, specialArgs, ...}: {
  imports = [
    #specialArgs.inputs.ninecraft.nixosModule
  ];

  programs.steam.enable = true;
  #programs.ninecraft.enable = true;

  system.stateVersion = "24.05";
}
