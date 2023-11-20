{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.gomuks;
in
{
  options.plusultra.apps.home.gomuks = with types; {
    enable = mkBoolOpt false "Whether or not to enable gomuks.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ gomuks ];
    plusultra.home.extraOptions.home.packages = with pkgs; [ gomuks ];
  };
}
