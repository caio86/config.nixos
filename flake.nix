{
  description = "Flake of C410l";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:

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
      name = "Caio";
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
        modules = [ ./configuration.nix ];
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };

    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
  };
}
