{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.zoxide;
in
{
  options.plusultra.apps.home.zoxide = with types; {
    enable = mkBoolOpt false "Whether or not to enable zoxide.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions.programs.zoxide = {
      enable = true;
      enableFishIntegration = config.plusultra.apps.home.fish.enable;
    };
  };
}
