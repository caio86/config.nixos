{ inputs, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {

    defaultSopsFile = ../../secrets.yaml;
    validadeSopsFiles = false;

    age = {
      # automatically import host SSH keys as age keys
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      # this will use an age key that is expected to already be in the filesystem
      keyFile = "/var/lib/sops-nix/key.txt";
      # generate a new key if the specified above does not exists
      generateKey = true;
    };
  };
}
