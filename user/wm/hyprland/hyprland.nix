{ config, pkgs, pkgs-stable, userSettings, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
  };

  home.packages = with pkgs; [
    bibata-cursors
    hyprlock
    hypridle
    swww
    wofi
    dunst
    wlogout
    pkgs-stable.waybar
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      # --------------------------------------#
      # Monitor Settings                      #
      # --------------------------------------#

      monitor = ",preferred,auto,1";

      # --------------------------------------#
      # Auto exec                             #
      # --------------------------------------#

      exec-once = [
        "hyprctl setcursor ${config.gtk.cursorTheme.name} ${builtins.toString config.gtk.cursorTheme.size}"
        "dunst"
        "hypridle"
        "swww init"
        "waybar"
      ];

      # --------------------------------------#
      # Variables                             #
      # --------------------------------------#

      "$terminal" = "${userSettings.term}";
      "$fileManager" = "dolphin";
      "$browser" = "${userSettings.browser}";
      "$menu" = "wofi --show drun";

      env = "QT_QPA_PLATFORM,wayland";

      # --------------------------------------#
      # Keyboard                              #
      # --------------------------------------#


      input = {
        kb_layout = "br";
        kb_variant = "";
        kb_model = "";
        kb_options = "";

        follow_mouse = "1";

        touchpad = {
          natural_scroll = "no";
        };

        sensitivity = "0";
      };

      # --------------------------------------#
      # Window                                #
      # --------------------------------------#


      general = {
        gaps_in = 10; # 5
        gaps_out = 14; # 20
        border_size = 3; # 2
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";
      };

      # --------------------------------------#
      # Decoration                            #
      # --------------------------------------#


      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 6; # 3
          passes = 2; # 1
        };
        active_opacity = 1.0;
        inactive_opacity = 0.8;
        fullscreen_opacity = 1.0;

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      # --------------------------------------#
      # Layout                                #
      # --------------------------------------#

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true;
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = false;
      };

      misc = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
        disable_splash_rendering = false;
      };

      # --------------------------------------#
      # Keybindins                            #
      # --------------------------------------#

      # SUPER KEY
      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, T, toggleFloating,"
        "$mainMod SHIFT, T, workspaceopt, allfloat"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, G, togglegroup"
        "$mainMod, F, fullscreen"
        "$mainMod, B, exec, $browser"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, DELETE, exec, wlogout"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "ALT, TAB, cyclenext"
        "ALT, TAB, bringactivetotop"
        "ALTSHIFT, TAB, cyclenext, prev"
        "ALTSHIFT, TAB, bringactivetotop"

        # Workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Special Workspace
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
  programs.swaylock.enable = true;
}

