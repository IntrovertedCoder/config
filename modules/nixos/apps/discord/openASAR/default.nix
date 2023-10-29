{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.openASAR;
in
{
  options.plusultra.apps.openASAR= with types; {
    enable = mkBoolOpt false "Whether or not to enable discord/openASAR.";
  };

  config =
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ (discord.override {withOpenASAR = true; withVencord = false;}) ];
    };
}
