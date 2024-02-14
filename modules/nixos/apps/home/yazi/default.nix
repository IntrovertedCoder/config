{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.yazi;
in
{
  options.plusultra.apps.home.yazi = with types; {
    enable = mkBoolOpt false "Whether or not to enable yazi.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ yazi ];
    plusultra.home.extraOptions.home.packages = with pkgs; [
      yazi
      exiftool
      mediainfo
    ];
  };
}
