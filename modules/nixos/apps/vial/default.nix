{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.vial;
in
{
  options.plusultra.apps.vial = with types; {
    enable = mkBoolOpt false "Whether or not to enable vial.";
  };

  config = mkIf cfg.enable {
    services.udev.packages = with pkgs; [
      vial
      qmk
      qmk-udev-rules
    ];
  };
}
