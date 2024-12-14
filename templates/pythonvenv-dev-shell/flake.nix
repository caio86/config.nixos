{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems =
        function: nixpkgs.lib.genAttrs systems (system: function (nixpkgs.legacyPackages.${system}));
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [ python312Packages.venvShellHook ];

          venvDir = "./venv";
          postVenvCreation = ''
            unset SOURCE_DATE_EPOCH
          '';
          postShellHook = ''
            unset SOURCE_DATE_EPOCH
          '';
        };
      });
    };
}
