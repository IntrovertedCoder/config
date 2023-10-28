{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.obs;
in
{
  options.plusultra.apps.obs= with types; {
    enable = lib.plusultra.mkBoolOpt false "Whether or not to enable obs.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ obs-studio]; };
}
