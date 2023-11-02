{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.discord.openASAR;
in
{
  options.plusultra.apps.discord.openASAR= with types; {
    enable = mkBoolOpt false "Whether or not to enable discord/openASAR.";
  };

  config =
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ (discord.override {withOpenASAR = true; withVencord = false;}) ];
    };
}
