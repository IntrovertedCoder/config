{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.teams;
in
{
  options.plusultra.apps.home.teams = with types; {
    enable = mkBoolOpt false "Whether or not to enable teams.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ teams ];
    plusultra.home.extraOptions.home.packages = with pkgs; [ teams-for-linux ];
  };
}
