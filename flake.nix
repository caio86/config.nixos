{
  description = "Flake of C410l";

  outputs = { self, ... }@inputs:

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
        theme = "catppuccin-mocha";
        browser = "brave";
        term = "kitty";
        editor = "nvim";
      };

      # configure pkgs
      pkgs = import inputs.nixpkgs {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
        };
      };

      # Unused for now
      pkgs-stable = import inputs.nixpkgs-stable {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
        };
      };

      # configure lib
      lib = inputs.nixpkgs.lib;

      myLib = import ./lib { inherit inputs systemSettings userSettings; };
    in

    with myLib;
    {
      nixosConfigurations = {
        # system = lib.nixosSystem {
        #   system = systemSettings.system;
        #   modules = [
        #     (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")
        #   ]; # load configuration.nix from selected PROFILE
        #   specialArgs = {
        #     inherit systemSettings;
        #     inherit userSettings;
        #     inherit inputs;
        #   };
        # };

        system = mkSystem systemSettings.system
          (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix");
      };

      homeConfigurations = {
        # user = inputs.home-manager.lib.homeManagerConfiguration {
        #   inherit pkgs;
        #   modules = [
        #     (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix")
        #   ]; # load home.nix from selected PROFILE
        #   extraSpecialArgs = {
        #     inherit systemSettings;
        #     inherit userSettings;
        #     inherit inputs;
        #   };
        # };

        user =
          mkHome pkgs
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix");

        "caiol@lua" =
          mkHome pkgs ./profiles/lua/home.nix;
      };
    };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/nixos-wsl";

    stylix.url = "github:danth/stylix";
  };
}
