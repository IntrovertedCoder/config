{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.heroic;
in
{
  options.plusultra.apps.home.heroic = with types; {
    enable = mkBoolOpt false "Whether or not to enable heroic.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ heroic ];
    plusultra.home.extraOptions.home.packages = with pkgs; [ heroic ];
  };
}
