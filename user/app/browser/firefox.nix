{ pkgs, ... }:

{
  home.packages = [ pkgs.firefox ];

  # home.sessionVariables = {
  #   DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
  # };

  # xdg.mimeApps.defaultApplications = {
  #   "text/html" = "firefox.desktop";
  #   "x-scheme-handler/http" = "firefox.desktop";
  #   "x-scheme-handler/https" = "firefox.desktop";
  #   "x-scheme-handler/about" = "firefox.desktop";
  #   "x-scheme-handler/unknown" = "firefox.desktop";
  #   "application/pdf" = "firefox.desktop";
  # };
}

