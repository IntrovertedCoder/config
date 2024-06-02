{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.server.containerTemplate;
in
{
  options.plusultra.apps.server.containerTemplate = with types; {
    enable = mkBoolOpt false "Whether or not to enable containerTemplate container.";
    network = mkOpt str "" "The network id to put this container in.";
    ip = mkOpt str "" "The ip address to apply to the container.";
    version = mkOpt str "" "The container version as found on hub.docker.com";
  };

  config = mkIf cfg.enable {
    system.activationScripts.piholeFolder = ''
      mkdir /data >/dev/null 2>&1 || true
      mkdir /data/containerTemplate >/dev/null 2>&1 || true
    '';
    virtualisation.oci-containers.containers = {
      containerTemplate = {
        image = "containerTemplate/containerTemplate:${cfg.version}";
        hostname = "containerTemplate";
        autoStart = true;
        # Can be any ip between 172.77.0.1 - 172.77.255.254
        extraOptions = [
          "--network=${cfg.network}"
          "--ip=${cfg.ip}"
        ];
        ports = [
          # "externalPort:internalPort";
        ];
        environment = {
          # variable = "string";
          TZ = "${config.time.timeZone}";
        };
        volumes = [
          # "externalLocation:internalLocation"
        ];
      };
    };
  };
}
