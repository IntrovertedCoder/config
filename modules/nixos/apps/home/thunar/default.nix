{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.thunar;
in
{
  options.plusultra.apps.home.thunar = with types; {
    enable = mkBoolOpt false "Whether or not to enable thunar.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ thunar ];
    plusultra.home.extraOptions.home.packages = with pkgs; [
      xfce.thunar
      gvfs
      xfce.thunar-archive-plugin
      xfce.thunar-media-tags-plugin
      xfce.thunar-volman
      xfce.tumbler
    ];
  };
}
