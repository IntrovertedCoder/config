{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.apps.discord;
in
{
  options.plusultra.apps.discord = with types; {
    enable = mkBoolOpt false "Whether or not to enable Discord.";
  };

  config = mkIf (cfg.enable or cfg.Vencord.enable or cfg.discord.openASAR.enable) {
    environment.systemPackages = with pkgs; [ (discord.override {withOpenASAR = false; withVencord = false;}) ];
  };
}
