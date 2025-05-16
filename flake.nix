{
  description = "Nix config using plasma 6 as the desktop";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Plasma manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    plasma-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      vantage = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};

        modules = [
          ./vantage/configuration.nix
        ];
      };
       
      newmoon = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};

        modules = [
          ./newmoon/configuration.nix
        ];
      };

      prevalance = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};

        modules = [
          ./prevalance/configuration.nix
        ];
      };

    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "alxjron@vantage" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
          username = "alxjron";
          homeDir = "/home/alxjron";
        };

        modules = [
          inputs.plasma-manager.homeManagerModules.plasma-manager
          ./vantage/home.nix
        ];
      };
      
      "alxjron@newmoon" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
          username = "alxjron";
          homeDir = "/home/alxjron";
        };

        modules = [
          inputs.plasma-manager.homeManagerModules.plasma-manager
          ./newmoon/home.nix
        ];
      };

      "alxjron@prevalance" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
          username = "alxjron";
          homeDir = "/home/alxjron";
        };

        modules = [
          inputs.plasma-manager.homeManagerModules.plasma-manager
          ./prevalance/home.nix
        ];
      };

    };
  };
}
