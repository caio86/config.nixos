{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };
  outputs = { self, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations = {
        user = inputs.home-manager.lib.homeManagerConfigurations {
          inherit pkgs;
          modules = [ ./home.nix ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
