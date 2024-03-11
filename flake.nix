{
  description = "Flake of C410l";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/nixos-wsl";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:

  let
    # --- SYSTEM SETTINGS --- #
    systemSettings = {
      system = "x86_64-linux";
      hostname = "VEGA";
      profile = "personal";
      timezone = "America/Sao_Paulo";
      locale = "pt_BR.UTF-8";
    };

    # --- USER SETTINGS --- #
    userSettings = {
      username = "caiol";
      name = "Caio Luiz";
      email = "caioluiz86@gmail.com";
      editor = "nvim";
    };

    # configure pkgs
    pkgs = import nixpkgs {
      system = systemSettings.system;
      config = {
        allowUnfree = true;
      };
    };

    # configure lib
    lib = nixpkgs.lib;
  in

  {
    nixosConfigurations = {
      system = lib.nixosSystem {
        system = systemSettings.system;
        modules = [ ./system/configuration.nix ];
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
	  inherit (inputs) nixos-wsl;
        };
      };
    };

    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./user/home.nix ];
        extraSpecialArgs = {
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
  };
}
