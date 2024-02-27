{ userSettings, ...}:

{
  programs.git = {
    enable = true;
    userName = "caio86";
    userEmail = userSettings.email;
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "cache --timeout=7200";
      core = {
        autocrlf = false;
        eol = "lf";
        editor = "vim";
      };
    };
  };
}
