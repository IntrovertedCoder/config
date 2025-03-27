{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.Snapchat;
in
{
  options.plusultra.apps.home.Snapchat = with types; {
    enable = mkBoolOpt false "Whether or not to enable Snapchat.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ RadarOmega ];
    plusultra.home.extraOptions.home.packages = with pkgs.plusultra; [ Snapchat ];
  };
}
