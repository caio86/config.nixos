{ pkgs-stable, userSettings, ... }:

{
  programs.waybar = {
    package = pkgs-stable.waybar;
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
          format = "{:%H:%M %a}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
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
  };
}
