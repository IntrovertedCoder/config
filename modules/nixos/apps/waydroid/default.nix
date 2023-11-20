{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.waydroid;
in
{
  options.plusultra.apps.waydroid = with types; {
    enable = mkBoolOpt false "Whether or not to enable waydroid.";
  };

  config = mkIf cfg.enable {
    virtualisation.waydroid.enable = true;
  };
}
