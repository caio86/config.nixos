{ inputs, ... }@args:

rec {

  pkgsFor = sys: inputs.nixpkgs.legacyPackages.${sys};

  #=================== Buildables =====================#

  # @param {String} system - the system type
  # @param {Path} config - the path to a configuration.nix file
  mkSystem = system: config:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        config
      ];

      specialArgs = {
        inherit (args) userSettings systemSettings;
        inherit inputs;
      };
    };

  # @param {Nixpkgs} pkgs - the pkgs to use
  # @param {Path} config - the path to a configuration.nix file
  mkHome = pkgs: config:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        config
      ];

      extraSpecialArgs = {
        inherit (args) userSettings systemSettings;
        inherit inputs;
      };
    };

  #===================== Helpers ======================#

  filesIn = dir: (map (fname: dir + "/${fname}")
    (builtins.attrNames (builtins.readDir dir)));

  dirsIn = dir:
    inputs.nixpkgs.lib.filterAttrs (name: value: value == "directory")
      (builtins.readDir dir);

  fileNameOf = path: (builtins.head (builtins.split "\\." (baseNameOf path)));

  #====================== Extenders ======================#

  # Evaluates nixos/home-manager module and extends it's options / config
  extendModule = { path, ... }@extenderArgs: { pkgs, ... }@moduleArgs:
    let
      eval =
        if (builtins.isString path) || (builtins.isPath path)
        then import path moduleArgs
        else path moduleArgs;

      evalOnlyConfig = builtins.removeAttrs eval [ "imports" "options" ];

      extra =
        if (builtins.hasAttr "extraOptions" extenderArgs) || (builtins.hasAttr "extraConfig" extenderArgs)
        then [
          ({ ... }: {
            options = extenderArgs.extraOptions or { };
            config = extenderArgs.extraConfig or { };
          })
        ]
        else [ ];
    in
    {
      imports =
        (eval.imports or [ ])
        ++ extra;

      options =
        if builtins.hasAttr "optionsExtension" extenderArgs
        then (extenderArgs.optionsExtension (eval.options or { }))
        else (eval.options or { });

      config =
        if builtins.hasAttr "configExtension" extenderArgs
        then (extenderArgs.configExtension (eval.config or evalOnlyConfig))
        else (eval.config or evalOnlyConfig);
    };

  # Applies extendModules to all modules
  # modules can be defined in the same way
  # as regular imports, or taken from "filesIn"
  extendModules = extension: modules:
    map
      (file:
        let
          name = fileNameOf file;
        in
        (extendModule ((extension name) // { path = file; })))
      modules;
}

