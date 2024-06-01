{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.server.template;
in
{
  options.plusultra.apps.server.template = with types; {
    enable = mkBoolOpt false "Whether or not to enable template container.";
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      template = {
        image = "owner/template:version";
        autoStart = true;
        ports = [
          "externalPort:internalPort"
        ];
        enviornment = {
          # variable = "string";
        };
        volumes = [
          # "externalLocation:internalLocation"
        ];
      };
    };
  };
}
