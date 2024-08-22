{ inputs, pkgs, systemSettings, config, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      (import ./disko.nix { device = "/dev/vda"; })
      inputs.disko.nixosModules.disko
      ../../system/security/sops.nix
      ../../system/app/docker.nix
    ];
  # Ensure nix flakes are enabled
  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Boot loader
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  networking.hostName = "lua";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  # Set your time zone.
  time.timeZone = systemSettings.timezone;
  # Select internationalisation properties.
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."caiol" = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.caiol_password.path;
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.fish.enable = true;

  sops.secrets."caiol_password".neededForUsers = true;

  system.stateVersion = "23.11";
}
