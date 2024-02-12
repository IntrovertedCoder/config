{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.parsec;
in
{
  options.plusultra.apps.home.parsec = with types; {
    enable = mkBoolOpt false "Whether or not to enable parsec.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ parsec ];
    plusultra.home.extraOptions.home.packages = with pkgs; [ parsec-bin ];
  };
}
