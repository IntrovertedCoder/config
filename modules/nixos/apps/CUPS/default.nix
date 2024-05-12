{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.CUPS;
in
{
  options.plusultra.apps.CUPS = with types; {
    enable = mkBoolOpt false "Whether or not to enable CUPS.";
  };

  config = mkIf cfg.enable {
    services.printing.enable = true;
    services.avahi.enable = true;
    services.avahi.nssmdns = true;
    services.avahi.openFirewall = true;
    services.printing.drivers = [ pkgs.brlaser ];
  };
}
