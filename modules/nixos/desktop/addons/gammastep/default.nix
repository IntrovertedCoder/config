{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.addons.gammastep;
in
{
  options.plusultra.desktop.addons.gammastep = with types; {
    enable = mkBoolOpt false "Whether or not to enable gammastep.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.gammastep
    ];
  };
}
