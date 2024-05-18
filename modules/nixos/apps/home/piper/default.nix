{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.piper;
in
{
  options.plusultra.apps.home.piper = with types; {
    enable = mkBoolOpt false "Whether or not to enable piper.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ piper ];
    services.ratbagd.enable = true;
    plusultra.home.extraOptions.home.packages = with pkgs; [ piper ];
  };
}
