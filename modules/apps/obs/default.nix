{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.apps.obs;
in
{
  options.plusultra.apps.obs = with types; {
    enable = mkBoolOpt false "Whether or not to enable support for OBS.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      obs-studio;
      (wrapOBS {
        plugins = with obs-studio-plugins; [
          wlrobs
          obs-multi-rtmp
          obs-move-transition
          looking-glass-obs
        ];
      })
    ];
  };
}
