{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.discord.ASAR-Vencord;
in
{
  options.plusultra.apps.home.discord.ASAR-Vencord = with types; {
    enable = mkBoolOpt false "Whether or not to enable discord/openASAR/Vencord.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions = {
      home.packages = with pkgs; [
        (discord.override {withOpenASAR = true; withVencord = true;})
      ];
    };
  };
}
