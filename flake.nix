{
  description = "Nix config using Mate as the desktop and i3 as the window manager";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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

      nighthound = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};

        modules = [
          ./nighthound/configuration.nix
        ];
      };

      malevolence = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};

        modules = [
          ./malevolence/configuration.nix
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

      "alxjron@nighthound" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
          username = "alxjron";
          homeDir = "/home/alxjron";
        };

        modules = [
          inputs.plasma-manager.homeManagerModules.plasma-manager
          ./nighthound/home.nix
        ];
      };

      "alxjron@malevolence" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
          username = "alxjron";
          homeDir = "/home/alxjron";
        };

        modules = [
          inputs.plasma-manager.homeManagerModules.plasma-manager
          ./malevolence/home.nix
        ];
      };

    };
  };
}
