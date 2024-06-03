{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.server.wireguard;
in
{
  options.plusultra.apps.server.wireguard = with types; {
    enable = mkBoolOpt false "Whether or not to enable wireguard container.";
    network = mkOpt str "" "The network id to put this container in.";
    ip = mkOpt str "" "The ip address to apply to the container.";
    version = mkOpt str "" "The container version as found on hub.docker.com";
  };

  config = mkIf cfg.enable {
    system.activationScripts.containerTemplateFolder = ''
      mkdir /data >/dev/null 2>&1 || true
      mkdir /data/wireguard >/dev/null 2>&1 || true
    '';
    virtualisation.oci-containers.containers = {
      wireguard = {
        image = "linuxserver/wireguard:${cfg.version}";
        hostname = "wireguard";
        autoStart = true;
        # Can be any ip between 172.77.0.1 - 172.77.255.254
        extraOptions = [
          "--network=${cfg.network}"
          "--ip=${cfg.ip}"
          "--cap-add=NET_ADMIN"
          "--cap-add=SYS_MODULE"
        ];
        ports = [
          # "externalPort:internalPort";
          "51820:51820/udp"
        ];
        environment = {
          # variable = "string";
          TZ = "${config.time.timeZone}";
          PEERDNS = "${config.plusultra.apps.server.pihole.ip}";
          PEERS = "aLaptop,aPhone,extra";
          PUID = "1000";
          GUID = "100";
        };
        volumes = [
          # "externalLocation:internalLocation"
          "/data/wireguard:/config"
        ];
      };
    };
  };
}
