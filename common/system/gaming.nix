{config, pkgs, specialArgs, ...}: {
  imports = [
    #specialArgs.inputs.ninecraft.nixosModule
  ];

  programs.steam.enable = true;
  #programs.ninecraft.enable = true;
  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
  ];

  system.stateVersion = "24.05";
}
