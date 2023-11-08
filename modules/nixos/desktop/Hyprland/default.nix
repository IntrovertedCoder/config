{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.desktop.Hyprland;
  term = config.plusultra.desktop.addons.term;
  substitutedConfig = pkgs.substituteAll {
    src = ./config;
    term = term.pkg.pname or term.pkg.name;
  };
in
{
  options.plusultra.desktop.Hyprland= with types; {
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
    plusultra.home.configFile."hypr/hyprland.conf".source = ./hyprland.conf;

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
