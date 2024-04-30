{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.RadarOmega;
in
{
  options.plusultra.apps.home.RadarOmega = with types; {
    enable = mkBoolOpt false "Whether or not to enable RadarOmega.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ RadarOmega ];
    plusultra.home.extraOptions.home.packages = with pkgs.plusultra; [ RadarOmega ];
  };
}
