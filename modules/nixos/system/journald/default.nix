{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.system.journald;
in
{
  options.plusultra.system.journald = with types; {
    enable = mkBoolOpt true "Whether or not to enable journald.";
    maxUse = mkOpt str "400M" "Additional configuration";
    retentionSec = mkOpt str "14day" "Additional configuration";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ journald ];
    services.journald.extraConfig = ''
      SystemMaxUse=${cfg.maxUse}
      MaxRetentionSec=${cfg.retentionSec}
    '';
  };
}
