{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.signal;
in
{
  options.plusultra.apps.home.signal = with types; {
    enable = mkBoolOpt false "Whether or not to enable signal.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ signal ];
    plusultra.home.extraOptions.home.packages = with pkgs; [ signal-desktop ];
  };
}
