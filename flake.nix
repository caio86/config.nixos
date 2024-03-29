{
  description = "Flake of C410l";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/nixos-wsl";

    stylix.url = "github:danth/stylix";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, stylix, ... }:

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
        browser = "brave";
        term = "kitty";
        editor = "nvim";
      };

      # configure pkgs
      pkgs = import nixpkgs {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
        };
      };

      pkgs-stable = import nixpkgs-stable {
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
          modules = [
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
          ]; # load configuration.nix from selected PROFILE
          specialArgs = {
            inherit pkgs-stable;
            inherit systemSettings;
            inherit userSettings;
            inherit (inputs) nixos-wsl;
            inherit (inputs) stylix;
          };
        };
      };

      homeConfigurations = {
        user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix")
          ]; # load home.nix from selected PROFILE
          extraSpecialArgs = {
            inherit pkgs-stable;
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };
    };
}
