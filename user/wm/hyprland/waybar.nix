{ config, pkgs, userSettings, ... }:

{
  programs.waybar = {
    package = pkgs.waybar;
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin = "0";
        spacing = 0;

        modules-left = [
          "custom/os"
          "custom/appmenu"
          "group/settings"
          "group/quicklinks"
          "hyprland/window"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "pulseaudio"
          "bluetooth"
          "battery"
          "network"
          "group/hardware"
          "custom/cliphist"
          "idle_inhibitor"
          "tray"
          "custom/exit"
          "clock"
        ];

        "custom/os" = {
          format = " {} ";
          exec = ''echo "" '';
          interval = "once";
        };

        "hyprland/workspaces" = {
          on-click = "activate";
          active-only = false;
          all-outputs = true;
          format = "{}";
          persistent-workspaces = {
            "*" = 5;
          };
        };

        "hyprland/window" = {
          rewrite = {
            "(.*) - Brave" = "$1";
            "(.*) - Chromium" = "$1";
            "(.*) - Brave Search" = "$1";
            "(.*) - Outlook" = "$1";
            "(.*) Microsoft Teams" = "$1";
          };
          separate-outputs = true;
        };

        "custom/cliphist" = {
          format = "";
          on-click = "sleep 0.1 && clip-history";
          on-click-right = "sleep 0.1 && clip-history d";
          on-click-middle = "sleep 0.1 && clip-history w";
          tooltip = false;
        };

        # TODO
        "custom/wallpaper" = {
          format = "";
          on-click = "";
          tooltip = false;
        };

        # TODO
        "custom/waybarthemes" = {
          format = "";
          on-click = "";
          tooltip = false;
        };

        "custom/settings" = {
          format = "";
          tooltip = false;
        };

        "custom/filemanager" = {
          format = "";
          on-click = "nautilus";
          tooltip = false;
        };

        "custom/browser" = {
          format = "";
          on-click = "${userSettings.browser}";
          tooltip = false;
        };

        "custom/chatgpt" = {
          format = "";
          on-click = "${userSettings.browser} --app=https://chat.openai.com";
          tooltip = false;
        };

        "custom/whatsapp" = {
          format = "";
          on-click = "${userSettings.browser} --app=https://web.whatsapp.com";
          tooltip = false;
        };

        "custom/appmenu" = {
          format = "Apps";
          on-click = "wofi -i --show drun";
          tooltip = false;
        };

        "custom/exit" = {
          format = "";
          on-click = "wlogout";
          tooltip = false;
        };

        "keyboard-state" = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };

        "tray" = {
          icon-size = 21;
          spacing = 10;
        };

        "clock" = {
          format = "{:L%H:%M %a}";
          tooltip-format = "<big>{:L%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        "custom/system" = {
          format = "";
          tooltip = false;
        };

        "cpu" = {
          format = "/ C {usage}% ";
          on-click = "${userSettings.term} -e btm";
        };

        "memory" = {
          format = "/ M {}%";
          on-click = "${userSettings.term} -e btm";
        };

        "disk" = {
          interval = 30;
          format = "D {percentage_used}% ";
          path = "/";
          on-click = "${userSettings.term} -e btm";
        };

        "hyprland/language" = {
          format = "/ K {short}";
        };

        "group/hardware" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            children-class = "not-memory";
            transition-left-to-right = false;
          };
          modules = [
            "custom/system"
            "disk"
            "cpu"
            "memory"
            "hyprland/language"
          ];
        };

        "group/quicklinks" = {
          orientation = "horizontal";
          modules = [
            "custom/filemanager"
            "custom/browser"
            "custom/whatsapp"
            "custom/chatgpt"
          ];
        };

        "network" = {
          format = "{ifname}";
          format-wifi = "   {signalStrength}%";
          format-ethernet = "  {ipaddr}";
          format-disconnected = "Not connected";
          tooltip-format = " {ifname} via {gwaddri}";
          tooltip-format-wifi = "   {essid} ({signalStrength}%)";
          tooltip-format-ethernet = "  {ifname} ({ipaddr}/{cidr})";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "${userSettings.term} -e nmtui";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}   {capacity}%";
          format-charging = "  {capacity}%";
          format-plugged = "  {capacity}%";
          format-alt = "{icon}  {time}";
          format-icons = [ " " " " " " " " " " ];
        };

        "pulseaudio" = {
          scroll-step = 1;
          format = "{icon}   {volume}%";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" " " " " ];
          };
          on-click = "pavucontrol";
        };

        "bluetooth" = {
          format-disabled = "";
          format-off = "";
          interval = 30;
          on-click = "blueman-manager";
          format-no-controller = "";
        };

        "user" = {
          format = "{user}";
          interval = 60;
          icon = false;
        };

        "idle_inhibitor" = {
          format = "{icon}";
          tooltip = true;
          format-icons = {
            activated = "";
            deactivated = "";
          };
          on-click-right = "hyprlock";
        };

      };
    };
    style = ''
      @define-color color8 #${config.lib.stylix.colors.base03};

      @define-color backgroundlight @color8;
      @define-color backgrounddark #${config.lib.stylix.colors.base07};
      @define-color waybarbackground #${config.lib.stylix.colors.base01};
      @define-color workspacesbackground1 @color8;
      @define-color workspacesbackground2 #${config.lib.stylix.colors.base07};
      @define-color bordercolor @color8;
      @define-color textcolor1 @color8;
      @define-color textcolor2 #${config.lib.stylix.colors.base05};
      @define-color textcolor3 #${config.lib.stylix.colors.base02};
      @define-color iconcolor @color8;

      * {
          font-family: ${config.stylix.fonts.sansSerif.name};
          border: none;
          border-radius: 0px;
      }

      window#waybar {
          background-color: rgba(0,0,0,0.8);
          border-bottom: 0px solid #ffffff;
          /* color: #FFFFFF; */
          background: transparent;
          transition-property: background-color;
          transition-duration: .5s;
      }

      /* -----------------------------------------------------
       * Workspaces 
       * ----------------------------------------------------- */

      #workspaces {
          background: @workspacesbackground1;
          margin: 2px 1px 3px 1px;
          padding: 0px 1px;
          border-radius: 15px;
          border: 0px;
          font-weight: bold;
          font-style: normal;
          opacity: 0.8;
          font-size: 16px;
          color: @textcolor1;
      }

      #workspaces button {
          padding: 0px 5px;
          margin: 4px 3px;
          border-radius: 15px;
          border: 0px;
          color: @textcolor1;
          background-color: @workspacesbackground2;
          transition: all 0.3s ease-in-out;
          opacity: 0.4;
      }

      #workspaces button.active {
          color: @textcolor1;
          background: @workspacesbackground2;
          border-radius: 15px;
          min-width: 40px;
          transition: all 0.3s ease-in-out;
          opacity:1.0;
      }

      #workspaces button:hover {
          color: @textcolor1;
          background: @workspacesbackground2;
          border-radius: 15px;
          opacity:0.7;
      }

      /* -----------------------------------------------------
       * Tooltips
       * ----------------------------------------------------- */

      tooltip {
          border-radius: 10px;
          background-color: @backgroundlight;
          opacity:0.8;
          padding:20px;
          margin:0px;
      }

      tooltip label {
          color: @textcolor2;
      }

      /* -----------------------------------------------------
       * Window
       * ----------------------------------------------------- */

      #window {
          background: @backgroundlight;
          margin: 5px 15px 5px 0px;
          padding: 2px 10px 0px 10px;
          border-radius: 12px;
          color:@textcolor2;
          font-size:16px;
          font-weight:normal;
          opacity:0.8;
      }

      window#waybar.empty #window {
          background-color:transparent;
      }

      /* -----------------------------------------------------
       * Taskbar
       * ----------------------------------------------------- */

      #taskbar {
          background: @backgroundlight;
          margin: 3px 15px 3px 0px;
          padding:0px;
          border-radius: 15px;
          font-weight: normal;
          font-style: normal;
          opacity:0.8;
          border: 3px solid @backgroundlight;
      }

      #taskbar button {
          margin:0;
          border-radius: 15px;
          padding: 0px 5px 0px 5px;
      }

      /* -----------------------------------------------------
       * Modules
       * ----------------------------------------------------- */

      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      /* -----------------------------------------------------
       * Custom Quicklinks
       * ----------------------------------------------------- */

      #custom-brave, 
      #custom-browser, 
      #custom-keybindings, 
      #custom-outlook, 
      #custom-filemanager, 
      #custom-teams, 
      #custom-chatgpt, 
      #custom-whatsapp,
      #custom-calculator, 
      #custom-windowsvm, 
      #custom-cliphist, 
      #custom-wallpaper, 
      #custom-settings, 
      #custom-wallpaper, 
      #custom-system,
      #custom-waybarthemes {
          margin-right: 23px;
          font-size: 20px;
          font-weight: bold;
          opacity: 0.8;
          color: @iconcolor;
      }

      #custom-system {
          margin-right:15px;
      }

      #custom-wallpaper {
          margin-right:25px;
      }

      #custom-waybarthemes, #custom-settings {
          margin-right:20px;
      }

      #custom-chatgpt {
          margin-right: 15px;
          background-image: url("../assets/ai-icon.png");
          background-repeat: no-repeat;
          background-position: center;
          padding-right: 24px;
      }

      #custom-ml4w-welcome {
          margin-right: 15px;
          background-image: url("../assets/ml4w-icon.png");
          background-repeat: no-repeat;
          background-position: center;
          padding-right: 24px;
      }

      /* -----------------------------------------------------
       * Idle Inhibator
       * ----------------------------------------------------- */

      #idle_inhibitor {
          margin-right: 15px;
          font-size: 22px;
          font-weight: bold;
          opacity: 0.8;
          color: @iconcolor;
      }

      #idle_inhibitor.activated {
          margin-right: 15px;
          font-size: 20px;
          font-weight: bold;
          opacity: 0.8;
          color: #dc2f2f;
      }

      /* -----------------------------------------------------
       * Custom Modules
       * ----------------------------------------------------- */

      #custom-appmenu, #custom-appmenuwlr {
          background-color: @backgrounddark;
          font-size: 16px;
          color: @textcolor1;
          border-radius: 15px;
          padding: 0px 10px 0px 10px;
          margin: 3px 15px 3px 14px;
          opacity:0.8;
          border:3px solid @bordercolor;
      }

      /* -----------------------------------------------------
       * Custom Exit
       * ----------------------------------------------------- */

      #custom-exit {
          margin: 0px 20px 0px 0px;
          padding:0px;
          font-size:20px;
          color: @iconcolor;
      }

      /* -----------------------------------------------------
       * Custom Updates
       * ----------------------------------------------------- */

      #custom-updates {
          background-color: @backgroundlight;
          font-size: 16px;
          color: @textcolor2;
          border-radius: 15px;
          padding: 2px 10px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
      }

      #custom-updates.green {
          background-color: @backgroundlight;
      }

      #custom-updates.yellow {
          background-color: #ff9a3c;
          color: #FFFFFF;
      }

      #custom-updates.red {
          background-color: #dc2f2f;
          color: #FFFFFF;
      }

      /* -----------------------------------------------------
       * Custom Youtube
       * ----------------------------------------------------- */

      #custom-youtube {
          background-color: @backgroundlight;
          font-size: 16px;
          color: @textcolor2;
          border-radius: 15px;
          padding: 2px 10px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
      }

      /* -----------------------------------------------------
       * Hardware Group
       * ----------------------------------------------------- */

      #disk,#memory,#cpu,#language {
          margin:0px;
          padding:0px;
          font-size:16px;
          color:@iconcolor;
      }

      #language {
          margin-right:10px;
      }

      /* -----------------------------------------------------
       * Clock
       * ----------------------------------------------------- */

      #clock {
          background-color: @backgrounddark;
          font-size: 16px;
          color: @textcolor1;
          border-radius: 15px;
          padding: 1px 10px 0px 10px;
          margin: 3px 15px 3px 0px;
          opacity:0.8;
          border:3px solid @bordercolor;   
      }

      /* -----------------------------------------------------
       * Pulseaudio
       * ----------------------------------------------------- */

      #pulseaudio {
          background-color: @backgroundlight;
          font-size: 16px;
          color: @textcolor2;
          border-radius: 15px;
          padding: 2px 10px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
      }

      #pulseaudio.muted {
          background-color: @backgrounddark;
          color: @textcolor1;
      }

      /* -----------------------------------------------------
       * Network
       * ----------------------------------------------------- */

      #network {
          background-color: @backgroundlight;
          font-size: 16px;
          color: @textcolor2;
          border-radius: 15px;
          padding: 2px 10px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
      }

      #network.ethernet {
          background-color: @backgroundlight;
          color: @textcolor2;
      }

      #network.wifi {
          background-color: @backgroundlight;
          color: @textcolor2;
      }

      /* -----------------------------------------------------
       * Bluetooth
       * ----------------------------------------------------- */

      #bluetooth, #bluetooth.on, #bluetooth.connected {
          background-color: @backgroundlight;
          font-size: 16px;
          color: @textcolor2;
          border-radius: 15px;
          padding: 2px 10px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
      }

      #bluetooth.off {
          background-color: transparent;
          padding: 0px;
          margin: 0px;
      }

      /* -----------------------------------------------------
       * Battery
       * ----------------------------------------------------- */

      #battery {
          background-color: @backgroundlight;
          font-size: 16px;
          color: @textcolor2;
          border-radius: 15px;
          padding: 2px 15px 0px 10px;
          margin: 5px 15px 5px 0px;
          opacity:0.8;
      }

      #battery.charging, #battery.plugged {
          color: @textcolor2;
          background-color: @backgroundlight;
      }

      @keyframes blink {
          to {
              background-color: @backgroundlight;
              color: @textcolor2;
          }
      }

      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: @textcolor3;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      /* -----------------------------------------------------
       * Tray
       * ----------------------------------------------------- */

      #tray {
          padding: 0px 15px 0px 0px;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
      }

      window#waybar {
          background-color: @waybarbackground;
      }
    '';
  };
}
