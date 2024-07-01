{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.discord.Vesktop;
in
{
  options.plusultra.apps.home.discord.Vesktop = with types; {
    enable = mkBoolOpt false "Whether or not to enable vesktop.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions = {
      home.packages = with pkgs; [
        vesktop
      ];
    };
  };
}
