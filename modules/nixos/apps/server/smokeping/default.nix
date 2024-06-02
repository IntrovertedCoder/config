{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.server.smokeping;
in
{
  options.plusultra.apps.server.smokeping = with types; {
    enable = mkBoolOpt false "Whether or not to enable smokeping container.";
    network = mkOpt str "" "The network id to put this container in.";
    ip = mkOpt str "" "The ip address to apply to the container.";
    version = mkOpt str "" "The container version as found on hub.docker.com";
  };

  config = mkIf cfg.enable {
    system.activationScripts.smokepingFolder = ''
      mkdir /data >/dev/null 2>&1 || true
      mkdir /data/smokeping >/dev/null 2>&1 || true
      mkdir /data/smokeping/config >/dev/null 2>&1 || true
      mkdir /data/smokeping/data >/dev/null 2>&1 || true
    '';
    virtualisation.oci-containers.containers = {
      smokeping = {
        image = "linuxserver/smokeping:${cfg.version}";
        hostname = "smokeping";
        autoStart = true;
        # Can be any ip between 172.77.0.1 - 172.77.255.254
        extraOptions = [
          "--network=${cfg.network}"
          "--ip=${cfg.ip}"
        ];
        ports = [
          # "externalPort:internalPort";
          "82:80"
        ];
        environment = {
          # variable = "string";
          TZ = "${config.time.timeZone}";
          PUID = "1000";
          GUID = "100";
        };
        volumes = [
          # "externalLocation:internalLocation"
          "/data/smokeping/config:/config"
          "/data/smokeping/data:/data"
        ];
      };
    };
  };
}
