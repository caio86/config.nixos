{ inputs, config, ... }:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {

    defaultSopsFile = ../../secrets.yaml;
    validadeSopsFiles = false;

    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };
}
