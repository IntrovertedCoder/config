{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.desktop.Hyprland;
  term = config.plusultra.desktop.addons.term;
  substitutedConfig = pkgs.substituteAll {
    src = ./hyprland.Conf;
  };
in
{
  options.plusultra.desktop.Hyprland = with types; {
    enable = mkBoolOpt false "Whether or not to enable Hyprland.";
    wallpaper = mkOpt (nullOr package) null "The wallpaper to display.";
    extraConfig =
      mkOpt str "" "Additional configuration for the Hyprland config file.";
  };

  config = mkIf cfg.enable {
    # Other needed apps
    plusultra.apps = {
      home.mako.enable = true;
    };

    # Adding the hyprland config
    plusultra.home.configFile."hypr/hyprland.conf".text = ''
      # See https://wiki.hyprland.org/Configuring/Monitors/
      # Desktop Displays
      monitor=HDMI-A-1,1920x1080,1080x420,1
      workspace=HDMI-A-1,2
      monitor=DP-2,1920x1080@75,0x0,1
      workspace=DP-2,1
      monitor=DP-2,transform,3
      # Laptop Display
      monitor=eDP-1,1920x1080@60,0x0,0.9
      # For running hypr in a x11 session
      monitor=X11-1,1900x1036,0x0,1


      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch
      # exec-once = waybar & hyprpaper & firefox
      exec-once = eww open mainMonitor & easyeffects --gapplication-service

      # Turn monitors off if locked (swaylock running) and idle for 10 seconds
      exec-once = swayidle -w timeout 10 'if pgrep -x swaylock; then hyprctl dispatch dpms off; fi' resume 'hyprctl dispatch dpms on'
      # Lock screen after idle for 300 seconds and turn off monitors after 330
      exec-once = swayidle -w timeout 300 'swaylock --screenshots --clock --indicator --effect-blur 10x10 --ring-color=${config.plusultra.color.BlueNum} --text-color=${config.plusultra.color.brightGreenNum} --ring-clear-color=${config.plusultra.color.MagentaNum} --text-wrong-color=${config.plusultra.color.RedNum} --text-color=${config.plusultra.color.WhiteNum} --text-wrong-color=${config.plusultra.color.MagentaNum} --fade-in=3 --grace=3' timeout 330 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'

      # Some default env vars.
      env = XCURSOR_SIZE,24

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          touchpad {
              natural_scroll = yes
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 3
          gaps_out = 6
          border_size = 2
          col.active_border = rgba(${config.plusultra.color.BlueNum}FF) rgba(${config.plusultra.color.RedNum}FF) rgba(${config.plusultra.color.GreenNum}FF) 30deg
          col.inactive_border = rgba(${config.plusultra.color.BlueNum}19) rgba(${config.plusultra.color.RedNum}19) rgba(${config.plusultra.color.GreenNum}19) 30deg

          layout = master
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 2

          drop_shadow = yes
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(${config.plusultra.color.darkGrayNum}FF)
          dim_inactive = true
          dim_strength = 0.3
      }

      animations {
          enabled = yes

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = customIn, 1, 0.44, 0.84, 0.165
          bezier = customOut, 0.165, 0.84, 0.44, 1
          bezier = workspaces, 0.39, 0.575, 0.565, 1

          animation = windows, 1, 1, customIn
          animation = windowsOut, 1, 7, customOut
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, workspaces
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = false
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = off
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      device:epic mouse V1 {
          sensitivity = -0.5
      }

      # Example windowrule v1
      # windowrule = float, ^(alacritty)$
      windowrule = float, floating
      windowrule = size 720 433, floating
      windowrule = center, floating
      windowrule = float, xfce-polkit
      # Example windowrule v2
      # windowrulev2 = float,class:^(alacritty)$,title:^(alacritty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = ALT
      # $mainMod = SUPER

      # Custom keybinds
      # bind = $mainMOD, , exec,
      ## General
      bind = $mainMod, return, exec, alacritty
      bind = $mainMod, T, exec, firefox
      bind = $mainMod SHIFT, T , exec, firefox --private-window
      bind = $mainMod SHIFT, Q, killactive
      bind = $mainMod SHIFT, E, exit
      bind = $mainMod, D, exec, kickoff
      bind = ,Print, exec, grim -g "$(slurp)"
      ## Mouse control
      # G9
      bind = ,XF86Tools, exec, mpc prev
      # G10
      bind = ,XF86Launch5, exec, mpc toggle
      # G11
      bind = ,XF86Launch6, exec, mpc next
      # G12
      bind = ,XF86Launch7, exec, echo hi
      # G13
      bind = ,XF86Launch8, exec, echo hi
      # G14
      bind = ,XF86Launch9, exec, echo hi
      # G15
      # Unbindable unless changed wayland's verson of xmodmap
      # G16
      bind = ,XF86AudioMicMute, exec, echo hi
      # G17
      bind = ,XF86TouchpadToggle, exec, echo hi
      # G18
      bind = ,XF86TouchpadOn, exec, echo hi
      # G19
      bind = ,XF86TouchpadOff, exec, echo hi
      # G20
      # Unbindable unless changed wayland's verson of xmodmap
      #
      bind = $mainMod SHIFT, F1, exec, mpc toggle

      ## Brightness
      bind = $mainMod, F11, exec, brightnessctl s 17-
      bind = $mainMod, F12, exec, brightnessctl s +17

      ## Floating windows
      bind = $mainMod, F1, exec, alacritty -o window.opacity=0.5 --class floating,ranger -e ranger
      bind = $mainMod, F2, exec, alacritty -o window.opacity=0.5 --class floating,btop -e btop
      bind = $mainMod, F3, exec, alacritty -o window.opacity=0.5 --class floating,ncmpcpp -e ncmpcpp
      bind = $mainMod, F4, exec, eww open --toggle dock && eww open --toggle dock-closer

      ### Screenkey

      # Window management
      ## Move focus with mainMod + arrow keys
      bind = $mainMod, H, movefocus, l
      bind = $mainMod, L, movefocus, r
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, J, movefocus, d
      ## Move current window
      bind = $mainMod SHIFT, H, movewindow, l
      bind = $mainMod SHIFT, L, movewindow, r
      bind = $mainMod SHIFT, K, movewindow, u
      bind = $mainMod SHIFT, J, movewindow, d
      ## Resize current window
      bind = $mainMod CONTROL, H, resizeactive,-10 0
      bind = $mainMod CONTROL, L, resizeactive,10 0
      bind = $mainMod CONTROL, K, resizeactive,0 -10
      bind = $mainMod CONTROL, J, resizeactive,0 10
      ## Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10
      ## Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
      bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
      bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
      bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
      bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
      bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
      bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
      bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
      bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
      bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10
      ## Toggle stuff with windows
      bind = $mainMod, SPACE, togglefloating
      bind = $mainMod, F, fullscreen

      ## Window Rules
      ### Discord
      windowrulev2 = workspace 4 silent,class:(discord)
      ### Obsidian
      windowrulev2 = workspace 6 silent,class:(obsidian)
      windowrulev2 = size 711 453, class:(floating)


      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow


      # Screensharing support
      exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

      # Extra config from flakes
      ${cfg.extraConfig}
    '';

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
