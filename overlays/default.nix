{
  modifications = final: prev: {
    st = prev.st.overrideAttrs (oldAttrs: {
      src = prev.fetchFromGitHub {
        owner = "LukeSmithxyz";
        repo = "st";
        rev = "8ab3d03681479263a11b05f7f1b53157f61e8c3b";
        sha256 = "1brwnyi1hr56840cdx0qw2y19hpr0haw4la9n0rqdn0r2chl8vag";
      };

      buildInputs = oldAttrs.buildInputs ++ [ prev.harfbuzz ];

      # configFile = prev.writeText "config.h" (builtins.readFile ./st-config.h);
      # postPatch = "${oldAttrs.postPatch}\ncp ${configFile} config.h\n";
    });
  };
}
