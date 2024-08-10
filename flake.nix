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
      pkgs-unstable = import inputs.nixpkgs {
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

      pkgs = pkgs-unstable;

      home-manager = inputs.home-manager;

      # configure lib
      lib = inputs.nixpkgs.lib;

      extraSettings = { inherit inputs systemSettings userSettings myLib; };
      myLib = import ./lib { inherit inputs pkgs lib home-manager extraSettings; };

      nodes = [
        "homelab-0"
        "homelab-1"
        "homelab-2"
      ];
    in

    with myLib;
    {
      nixosConfigurations = {

        system = mkSystem (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix") { };

      } // builtins.listToAttrs (map
        (name: {
          name = name;
          value = mkSystem ./profiles/homelab/configuration.nix {
            meta = { hostname = name; };
          };
        })
        nodes);

      homeConfigurations = {

        user = mkHome (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix");
        lua = mkHome ./profiles/lua/home.nix;

      };
    };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/nixos-wsl";

    stylix.url = "github:danth/stylix";

    sops-nix.url = "github:Mic92/sops-nix";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
