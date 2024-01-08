{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.addons.dunst;
in
{
  options.plusultra.desktop.addons.dunst = with types; {
    enable = mkBoolOpt false "Whether or not to enable dunst.";
  };

  config = mkIf cfg.enable {
    plusultra.desktop.Hyprland.extraConfig = mkIf config.plusultra.desktop.Hyprland.enable ''
      ## Notification control
      bind = $mainMod, n, exec, dunstctl restore
      bind = $mainMod, m, exec, dunstctl dismiss
      bind = $mainMod SHIFT, n, exec, dunstctl dismiss -a
    '';
    plusultra.home.extraOptions.services = {
      dunst = {
        enable = true;
        settings = {
          global = {
            monitor = 0;
            follow = "none";
            width = 300;
            height = 300;
            origin = "top-right";
            offset = "10x50";
            scale = 0;
            notification_limit = 0;
            progress_bar = true;
            progress_bar_height = 10;
            progress_bar_frame_width = 1;
            indicate_hidden = "yes";
            transparency = 0;
            separator_height = 2;
            padding = 8;
            horizontal_padding = 8;
            text_icon_padding = 0;
            frame_width = 3;
            frame_color = config.plusultra.color.Blue;
            gap_size = 3;
            seperator_color = "frame";
            sort = "yes";
            font = config.plusultra.font.Font;
            line_height = 0;
            markup = "full";
            fortmat = "<b>%s</b>\n%b";
            alighment = "left";
            vertical_alignment = "center";
            show_age_threshold = 60;
            ellipsize = "middle";
            ignore_newline = "no";
            stack_duplicates = true;
            hide_duplicate_count = false;
            show_indicators = "yes";
            enable_recursive_icon_lookup = true;
            icon_theme = "Adwaita";
            icon_position = "left";
            min_icon_size = 32;
            max_icon_size = 128;
            # icon_path =
            sticky_history = "yes";
            history_length = 20;
            browser = "xdg-open";
            always_run_script = true;
            title = "Dunst";
            class = "Dunst";
            corner_radius = 0;
            ignore_dbuscluse = false;
            force_xwayland = false;
            force_xinerama = false;
            mouse_left_click = "close_current";
            mouse_middle_click = "do_action, close_current";
            mouse_right_click = "close_all";
          };
          experimental = {
            per_monitor_dpi = false;
          };
          urgency_low = {
            background = config.plusultra.color.Black;
            foreground = config.plusultra.color.brightBlack;
            timeout = 10;
          };
          urgency_normal= {
            background = config.plusultra.color.Black;
            foreground = config.plusultra.color.White;
            timeout = 10;
          };
          urgency_critical= {
            background = config.plusultra.color.Red;
            foreground = config.plusultra.color.White;
            frame_color = config.plusultra.color.Orange;
            timeout = 10;
          };
        };
      };
    };
  };
}
