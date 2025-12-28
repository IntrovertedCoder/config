{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.addons.dms;
in
{
  options.plusultra.desktop.addons.dms = with types; {
    enable = mkBoolOpt false "Whether or not to enable dms.";
  };

  config = mkIf cfg.enable {
    programs.dankMaterialShell.enable = true;
  };
}
