{ inputs, pkgs, lib, home-manager, ... }@args:

rec {

  #=================== Buildables =====================#

  # @param {Path} config - the path to a configuration.nix file
  mkSystem = config: { ... }@xargs:
    lib.nixosSystem {
      system = args.extraSettings.systemSettings.system;

      modules = [
        config
      ];

      specialArgs = args.extraSettings // xargs;
    };

  # @param {Path} config - the path to a home.nix file
  mkHome = config:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        config
      ];

      extraSpecialArgs = args.extraSettings;
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

