{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.lutris;
in
{
  options.plusultra.apps.home.lutris = with types; {
    enable = mkBoolOpt false "Whether or not to enable lutris.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ lutris ];
    plusultra.home.extraOptions.home.packages = with pkgs; [ lutris-free ];
  };
}
