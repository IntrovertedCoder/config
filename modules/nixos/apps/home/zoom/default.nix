{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.zoom;
in
{
  options.plusultra.apps.home.zoom = with types; {
    enable = mkBoolOpt false "Whether or not to enable zoom.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ zoom ];
    plusultra.home.extraOptions.home.packages = with pkgs; [ zoom-us ];
  };
}
