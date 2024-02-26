{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.wine;
in
{
  options.plusultra.apps.home.wine = with types; {
    enable = mkBoolOpt false "Whether or not to enable wine.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ wine ];
    plusultra.home.extraOptions.home.packages = with pkgs; [
      wineWowPackages.stable
      winetricks
    ];
  };
}
