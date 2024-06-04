{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.server.cockpit;
in
{
  options.plusultra.apps.server.cockpit = with types; {
    enable = mkBoolOpt false "Whether or not to enable cockpit.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ packagekit ];
    services.cockpit = {
      enable = true;
      openFirewall = true;
    };
  };
}
