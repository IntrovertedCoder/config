{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.discord.Vencord;
in
{
  options.plusultra.apps.discord.Vencord = with types; {
    enable = mkBoolOpt false "Whether or not to enable Vencord.";
  };

  config =
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ (discord.override {withOpenASAR = false; withVencord = true;}) ];
    };
}
