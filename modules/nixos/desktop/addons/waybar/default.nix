{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.addons.waybar;
in
{
  options.plusultra.desktop.addons.waybar = with types; {
    enable = mkBoolOpt false "Whether or not to enable waybar.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ waybar ];
    # plusultra.home.extraOptions.home.packages = with pkgs; [ waybar ];
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "bar" ''
        ${pkgs.waybar}/bin/waybar
      '')
    ];
    plusultra.home.extraOptions = {
      programs.waybar = {
        enable = true;

        style = ''
          * {
            border: none;
            border-radius: 20px;
            padding: 0px 5px 0px 5px;
            font-family: ${config.plusultra.font.Font};
            font-size: 12px;
            min-height: 0;
          }

          window#waybar {
            background: transparent;
            color: ${config.plusultra.color.White};
          }

          tooltip {
            background: ${config.plusultra.color.Black};
            border: 1px solid ${config.plusultra.color.brightBlack};
          }

          tooltip label {
            color: ${config.plusultra.color.White};
          }

          #workspaces {
            background: ${config.plusultra.color.Blue};
          }
          #workspaces button {
            background: transparent;
            color: ${config.plusultra.color.Black};
            padding: 0px 0px 0px 0px;
          }
          #workspaces button.urgent {
            background: ${config.plusultra.color.Red};
            color: ${config.plusultra.color.White};
          }

          #network {
            background: ${config.plusultra.color.Yellow};
            color: ${config.plusultra.color.Black};
          }

          #privacy {
            padding: 0px 0px 0px 0px;
          }
          #privacy-item.screenshare {
            padding: 0px;
            background: ${config.plusultra.color.Orange};
            color: ${config.plusultra.color.White};
          }
          #privacy-item.audio-in {
            padding: 0px;
            background: ${config.plusultra.color.Magenta};
            color: ${config.plusultra.color.White};
          }

          #tray {
            background: ${config.plusultra.color.Green};
            color: ${config.plusultra.color.Black};
          }
          #tray menu {
            background: ${config.plusultra.color.Black};
            color: ${config.plusultra.color.White};
          }
          #tray > .needs-attention {
            background: ${config.plusultra.color.Red};
            color: ${config.plusultra.color.White};
          }

          #disk.ssd {
            background: ${config.plusultra.color.Orange};
            color: ${config.plusultra.color.Black};
            border-radius: 20px 0px 0px 20px;
          }
          #disk.mntStorage {
            background: ${config.plusultra.color.Orange};
            color: ${config.plusultra.color.Black};
            border-radius: 0px 0px 0px 0px;
          }
          #disk.nas {
            background: ${config.plusultra.color.Orange};
            color: ${config.plusultra.color.Black};
            border-radius: 0px 20px 20px 0px;
          }

          #memory {
            background: ${config.plusultra.color.Cyan};
            color: ${config.plusultra.color.Black};
          }

          #custom-gpu-usage-Nobelium {
            background: ${config.plusultra.color.Magenta};
            color: ${config.plusultra.color.Black};
            border-radius: 20px 0px 0px 20px;
          }
          #custom-gpu-temp-Nobelium {
            background: ${config.plusultra.color.Magenta};
            color: ${config.plusultra.color.Black};
            border-radius: 0px 20px 20px 0px;
          }

          #cpu {
            background: ${config.plusultra.color.Blue};
            color: ${config.plusultra.color.Black};
            border-radius: 20px 0px 0px 20px;
          }
          #temperature.cpu {
            background: ${config.plusultra.color.Blue};
            color: ${config.plusultra.color.Black};
            border-radius: 0px 20px 20px 0px;
          }

          #battery {
            background: ${config.plusultra.color.Yellow};
            color: ${config.plusultra.color.Black};
          }

          #backlight {
            background: ${config.plusultra.color.Yellow};
            color: ${config.plusultra.color.Black};
          }

          #clock {
            background: ${config.plusultra.color.Green};
            color: ${config.plusultra.color.Black};
          }

        '';

        settings = { # {{{
          mainBar = {
            layer = "top";
            position = "top";
            height = 30;
            output = [
              "DP-2"
              "eDP-1"
            ];
            modules-left = [ "hyprland/workspaces" "network" ];
            # modules-center = [ "hyprland/window" ];
            modules-right = [ "privacy" "tray" "disk#ssd" "disk#mntStorage" "disk#nas" "memory" "custom/gpu-usage-Nobelium" "custom/gpu-usage-laptop" "custom/gpu-temp-Nobelium" "custom/gpu-temp-laptop" "cpu" "temperature#cpu" "battery" "backlight" "clock" ];

            "hyprland/workspaces" = {
              disable-scroll = true;
              all-outputs = true;
              format = "{icon}";
              format-icons = {
                active = "";
                default = "";
              };
            };

            "network" = {
              interface = "*";
              format = "󰕒{bandwidthUpBits} 󰇚{bandwidthDownBits}";
            };

            "privacy" = {
              icon-size = 12;
              icon-spacing = 0;
              "modules" = [
                {
                  "type" = "screenshare";
                  "tooltip" = true;
                  "tooltip-icon-size" = 12;
                }
                {
                  "type" = "audio-in";
                  "tooltip" = true;
                  "tooltip-icon-size" = 12;
                }
                # {
                  # "type" = "audio-out";
                  # "tooltip" = true;
                  # "tooltip-icon-size" = 12;
                # }
              ];
            };

            "disk#ssd" = {
              path = "/";
              format = " {percentage_used}%";
              unit = "GB";
            };

            "disk#mntStorage" = {
              path = "/mnt/Storage";
              format = " {percentage_used}%";
              unit = "GB";
            };

            "disk#nas" = {
              path = "/home/arik/data";
              format = "󰡰 {percentage_used}%";
              unit = "GB";
            };

            "memory" = {
              format = " {used}G/{total}G";
            };

            "custom/gpu-usage-Nobelium" = {
              format = "󰢮 {}%";
              return-type = "";
              interval = "once";
              exec = pkgs.writeShellScript "gpu-usage-Nobelium" ''
                # while sleep 1; do
                  # cat /sys/class/hwmon/hwmon5/device/gpu_busy_percent
                # done
                echo 100
              '';
              exec-if = pkgs.writeShellScript "gpu-usage-Nobelium-test" ''
                # cat /sys/class/hwmon/hwmon5/device/gpu_busy_percent
                true
              '';
            };

            "custom/gpu-usage-laptop" = {
              format = "󰢮 {}%";
              return-type = "";
              interval = "once";
              exec = pkgs.writeShellScript "gpu-usage-laptop" ''
                while sleep 1; do
                  cat /sys/class/hwmon/hwmon4/device/gpu_busy_percent
                done
              '';
              exec-if = pkgs.writeShellScript "gpu-usage-laptop-test" ''
                cat /sys/class/hwmon/hwmon4/device/gpu_busy_percent
              '';
            };

            "custom/gpu-temp-Nobelium" = {
              format = "{}°C";
              return-type = "";
              interval = "once";
              exec = pkgs.writeShellScript "gpu-usage-Nobelium" ''
                # while sleep 1; do
                  # cat /sys/class/hwmon/hwmon5/device/gpu_busy_percent
                # done
                echo 100
              '';
              exec-if = pkgs.writeShellScript "gpu-usage-Nobelium-test" ''
                # cat /sys/class/hwmon/hwmon5/device/gpu_busy_percent
                true
              '';
            };

            # Might replace with custom module so I can left pad 0s
            "cpu" = {
              format = " {}%";
            };

            # We got lucky with that on both Nobelium and laptop they both have the cpu at hwmon2
            "temperature#cpu" = {
              format = "{temperatureC}°C";
              hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
            };

            # Further testing required on laptop
            "battery" = {
            };

            # Further testing required
            "backight" = {
            };

            "clock" = {
              format = " {:%H:%M}";
              tooltip-format = "<tt><small><span size='9pt' font='${config.plusultra.font.Font}'>{calendar}</span></small></tt>";
              calendar = {
                mode = "year";
                mode-mon-col = 2;
                weeks-pos = "right";
                on-scroll = 1;
                format = {
                  months = "<span color='${config.plusultra.color.White}'><b>{}</b></span>";
                  days = "<span color='${config.plusultra.color.brightRed}'><b>{}</b></span>";
                  weeks = "<span color='${config.plusultra.color.Green}'><b>W{}</b></span>";
                  weekdays = "<span color='${config.plusultra.color.Yellow}'><b>{}</b></span>";
                  today = "<span color='${config.plusultra.color.Blue}'><b><u>{}</u></b></span>";
                };
              };
            };

          };
        };
        # }}}
      };
    };
  };
}
