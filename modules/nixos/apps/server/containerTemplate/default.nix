{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.server.containerTemplate;
in
{
  options.plusultra.apps.server.containerTemplate = with types; {
    enable = mkBoolOpt false "Whether or not to enable containerTemplate container.";
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      containerTemplate = {
        image = "owner/containerTemplate:version";
        hostname = "containerTemplate";
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
