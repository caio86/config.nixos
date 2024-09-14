{
  dev-shell = {
    path = ./dev-shell;
    description = "dev shell with nix flakes";
  };

  python-dev-shell = {
    path = ./python-dev-shell;
    description = "python dev shell flake";
  };

  nixos = {
    path = ./nixosModule;
    description = "nixos flake template";
  };

  home-manager = {
    path = ./home-managerModule;
    description = "home-manager flake template";
  };

  nixosWithHome = {
    path = ./nixosWithHomeManager;
    description = "flake with nixos and home-manager configuration modules";
  };

  impermanence = {
    path = ./impermanence;
    description = "example configuration for an impermanent setup";
  };
}
