{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.server.plex;
in
{
  options.plusultra.apps.server.plex = with types; {
    enable = mkBoolOpt false "Whether or not to enable plex container.";
    network = mkOpt str "" "The network id to put this container in.";
    ip = mkOpt str "" "The ip address to apply to the container.";
    serverIp = mkOpt str "" "The servers ip so plex can broadcast that its available at this address";
    version = mkOpt str "" "The container version as found on hub.docker.com";
  };

  config = mkIf cfg.enable {
    system.activationScripts.plexFolder = ''
      mkdir /data >/dev/null 2>&1 || true
      mkdir /data/plex >/dev/null 2>&1 || true
      mkdir /data/plex/config >/dev/null 2>&1 || true
      mkdir /data/plex/transcode >/dev/null 2>&1 || true
    '';
    virtualisation.oci-containers.containers = {
      plex = {
        image = "plexinc/pms-docker:${cfg.version}";
        hostname = "plex";
        autoStart = true;
        # Can be any ip between 172.77.0.1 - 172.77.255.254
        extraOptions = [
          "--network=${cfg.network}"
          # "--network=host"
          "--ip=${cfg.ip}"
        ];
        ports = [
          # "externalPort:internalPort";
          "32400:32400/tcp"
        ];
        environment = {
          # variable = "string";
          TZ = "${config.time.timeZone}";
          ADVERTISE_IP = "http://${cfg.ip}:32400,http://${cfg.serverIp}:32400";
          HOSTNAME = "${config.networking.hostName}Plex";
          PLEX_UID = "1000";
          PLEX_GID = "100";
        };
        volumes = [
          # "externalLocation:internalLocation"
          "/data/plex/config:/config"
          "/data/plex/transcode:/transcode"
          "/data/share/Movies Shows:/data"
          "/data/share/music:/music"
          "/data/share/podcasts:/podcasts"
        ];
      };
    };
  };
}
