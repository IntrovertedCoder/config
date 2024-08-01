{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.suites.communication;
in
{
  options.plusultra.suites.communication = with types; {
    enable = lib.plusultra.mkBoolOpt false "Whether or not to enable communication configuration.";
  };

  config = mkIf cfg.enable {
    plusultra = {
      apps = {
        home = {
          # discord = enabled;
          # discord.Vencord = enabled;
          discord.Vesktop = enabled;
          # discord.ASAR-Vencord = enabled;
          element = enabled;
          signal = enabled;
          gomuks = enabled;
          teams = enabled;
        };
      };
    };
  };
}
