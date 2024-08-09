# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ meta, pkgs, systemSettings, userSettings, ... }:

let
  disk = "/dev/vda";
in
{
  imports =
    [
      # Include the results of the hardware scan.
      (import ./disko-config.nix { device = disk; })
      ./hardware-configuration.nix
      ../../system/security/sops.nix
      ../../system/app/docker.nix
      (import ../../system/security/sshd.nix {
        authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICzUs/mygVOuJC+/M16vzINcpUXHsS85EI55V4NL7Oaq caiol@vega" ];
        inherit userSettings;
      })
    ];

  # Ensure nix flakes are enabled
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.enable = true;
  # boot.loader.grub.device = disk;

  # Networking
  networking.hostName = meta.hostname; # Define your hostname.
  networking.networkmanager.enable = true;

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
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
    hashedPassword = "$6$hf3aPlHmdbfeZczH$NTqZ7WcaJ4gDaI/yFWkRWISL6Agz8eYYSw9Ya68/PezMBvpTZl.bPrASWxgxkYrXr5U3e/7h4eLEuhMEw5LaH/";
  };

  environment.systemPackages = with pkgs; [
    neovim
    k3s
    cifs-utils
    nfs-utils
    vim
    wget
    zsh
    git
  ];


  sops = {
    secrets = {
      "k3s_token" = { };
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
