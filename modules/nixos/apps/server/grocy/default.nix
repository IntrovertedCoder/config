{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.server.grocy;
in
{
  options.plusultra.apps.server.grocy = with types; {
    enable = mkBoolOpt false "Whether or not to enable grocy container.";
    network = mkOpt str "" "The network id to put this container in.";
    ip = mkOpt str "" "The ip address to apply to the container.";
    serverIp = mkOpt str "" "The servers ip so grocy can broadcast that its available at this address";
    version = mkOpt str "" "The container version as found on hub.docker.com";
  };

  config = mkIf cfg.enable {
    system.activationScripts.plexFolder = ''
      mkdir /data >/dev/null 2>&1 || true
      mkdir /data/grocy >/dev/null 2>&1 || true
      mkdir /data/grocy/config >/dev/null 2>&1 || true
    '';
    virtualisation.oci-containers.containers = {
      grocy = {
        image = "linuxserver/grocy:${cfg.version}";
        hostname = "grocy";
        autoStart = true;
        # Can be any ip between 172.77.0.1 - 172.77.255.254
        extraOptions = [
          "--network=${cfg.network}"
          # "--network=host"
          "--ip=${cfg.ip}"
        ];
        ports = [
          # "externalPort:internalPort";
          "47629:80/tcp"
        ];
        environment = {
          # variable = "string";
          TZ = "${config.time.timeZone}";
          HOSTNAME = "${config.networking.hostName}Plex";
          PUID = "1000";
          PGID = "100";
        };
        volumes = [
          # "externalLocation:internalLocation"
          "/data/grocy/config:/config"
        ];
      };
    };
  };
}
