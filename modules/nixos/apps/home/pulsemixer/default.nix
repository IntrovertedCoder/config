{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.pulsemixer;
in
{
  options.plusultra.apps.home.pulsemixer = with types; {
    enable = mkBoolOpt false "Whether or not to enable pulsemixer.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ pulsemixer ];
    plusultra.home.extraOptions.home.packages = with pkgs; [ pulsemixer ];
    plusultra.desktop.Hyprland.pulsemixer = "bind = $mainMod, F5, exec, foot -o colors.alpha=0.5 --app-id floating,pulsemixer -e pulsemixer";
  };
}
