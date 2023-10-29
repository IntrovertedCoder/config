{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.apps.discord;
in
{
  options.plusultra.apps.discord = with types; {
    enable = mkBoolOpt false "Whether or not to enable Discord.";
    openASAR.enable = mkBoolOpt false "Whether or not to enable Discord with openASAR.";
    Vencord.enable = mkBoolOpt false "Whether or not to enable Discord with Vencord.";
    ASAR-Vencord.enable = mkBoolOpt false "Whether or not to enable Discord with both openASAR and Vencord.";
  };

  config = mkIf (cfg.enable or cfg.Vencord.enable or cfg.discord.openASAR.enable) {
    environment.systemPackages = with pkgs;
      # Vanilla Discord
      lib.optional cfg.enable (discord.override {withOpenASAR = false; withVencord = false;})
      # OpenASAR
      ++ lib.optional cfg.openASAR.enable (discord.override {withOpenASAR = true; withVencord = false;})
      # Vencord
      ++ lib.optional cfg.Vencord.enable (discord.override {withOpenASAR = false; withVencord = true;})
      # Both
      ++ lib.optional cfg.ASAR-Vencord.enable (discord.override {withOpenASAR = true; withVencord = true;})
    # environment.systemPackages = with pkgs; [ (discord.override {withOpenASAR = false; withVencord = false;}) ];
  ;};
}
