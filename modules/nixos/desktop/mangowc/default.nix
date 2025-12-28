{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.desktop.mangowc;
  term = config.plusultra.desktop.addons.term;
in
{
  options.plusultra.desktop.mangowc = with types; {
    enable = mkBoolOpt false "Whether or not to enable mangowc.";
    extraConfig = mkOpt str "" "Additional configuration for the mangowc config file.";
    extraConfig1 = mkOpt str "" "Additional configuration for the mangowc config file.";
    extraConfig2 = mkOpt str "" "Additional configuration for the mangowc config file.";
    extraConfig3 = mkOpt str "" "Additional configuration for the mangowc config file.";
    masterConfig = mkOpt str "" "Additional configuration for the mangowc config file.";
    easyeffects = mkOpt str "" "Additional configuration for the mangowc config file.";
    pulsemixer = mkOpt str "" "Additional configuration for the mangowc config file.";
    ncpamixer = mkOpt str "" "Additional configuration for the mangowc config file.";
    wallpaper = mkOpt str "" "Additional configuration for the mangowc config file.";
  };

  config = mkIf cfg.enable {
    plusultra.desktop.addons = {
      dms.enable = true;
    };
    programs.mango.enable = true;

  };
}
