{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.addons.hyprsunset;
in
{
  options.plusultra.desktop.addons.hyprsunset = with types; {
    enable = mkBoolOpt false "Whether or not to enable hyprsunset.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ hyprsunset ];
    # plusultra.home.extraOptions.home.packages = with pkgs; [ hyprsunset ];
    plusultra.home.extraOptions = {
    };
  };
}
