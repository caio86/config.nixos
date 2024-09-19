{
  modifications = final: prev: {
    dwm = prev.dwm.overrideAttrs (oldAttrs: rec {
      configFile = prev.writeText "config.h" (builtins.readFile ./dwm-config.h);
      postPatch =
        oldAttrs.postPatch or "" + "\necho 'Using own config file...'\n cp ${configFile} config.def.h";
    });

    st = prev.st.overrideAttrs (oldAttrs: rec {
      src = prev.fetchFromGitHub {
        owner = "LukeSmithxyz";
        repo = "st";
        rev = "36d225d71d448bfe307075580f0d8ef81eeb5a87";
        hash = "sha256-u8E8/aqbL3T4Sz0olazg7VYxq30haRdSB1SRy7MiZiA=";
      };

      buildInputs = oldAttrs.buildInputs ++ [ prev.harfbuzz ];

      configFile = prev.writeText "config.h" (builtins.readFile ./st-config.h);
      postPatch = "${oldAttrs.postPatch}\ncp ${configFile} config.h\n";
    });
  };
}
