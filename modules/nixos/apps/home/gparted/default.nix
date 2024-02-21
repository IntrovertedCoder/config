{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.apps.home.gparted;
in
{
  options.plusultra.apps.home.gparted = with types; {
    enable = mkBoolOpt false "Whether or not to enable gparted.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
        (pkgs.writeShellScriptBin "wgparted" ''
            exec ${pkgs.xorg.xhost}/bin/xhost +SI:localuser:root
            exec ${pkgs.gparted}/bin/gparted
        '')
      ];
  };
}
