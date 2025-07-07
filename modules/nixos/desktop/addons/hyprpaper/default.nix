{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.addons.hyprpaper;
in
{
  options.plusultra.desktop.addons.hyprpaper = with types; {
    enable = mkBoolOpt false "Whether or not to enable hyprpaper.";

    assets = mkOption {
      type = path;
      default = pkgs.runCommand "hyprpaper-assets" { } ''
        mkdir -p $out
        cp ${./Default.png} $out/Default.png
        cp ${./Horizontal.png} $out/Horizontal.png
        cp ${./Vertical.png} $out/Vertical.png
      '';
      description = "Folder containing all Hyprpaper wallpapers.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ hyprpaper ];
    # plusultra.home.extraOptions.home.packages = with pkgs; [ hyprpaper ];
    plusultra.desktop.Hyprland.pulsemixer = "exec-once=hyprpaper";
    plusultra.home.extraOptions = {
      services.hyprpaper = {
        enable = true;
        settings = {
          ipc = "on";
          splash = false;
          splash_offset = 2.0;
          preload = [
            "${cfg.assets}/Horizontal.png"
            "${cfg.assets}/Vertical.png"
            "${cfg.assets}/Default.png"
          ];
          wallpaper = [
            "DP-1,${cfg.assets}/Horizontal.png"
            "DP-2,${cfg.assets}/Vertical.png"
            ",${cfg.assets}/Default.png"
          ];
        };
      };
    };
  };
}
