{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.server.wireguard-ui;
in
{
  options.plusultra.apps.server.wireguard-ui = with types; {
    enable = mkBoolOpt false "Whether or not to enable wireguard-ui container.";
    network = mkOpt str "" "The network id to put this container in.";
    ip = mkOpt str "" "The ip address to apply to the container.";
    version = mkOpt str "" "The container version as found on hub.docker.com";
  };

  config = mkIf cfg.enable {
    system.activationScripts.wireguard-uiFolder = ''
      mkdir /data >/dev/null 2>&1 || true
      mkdir /data/wireguard-ui >/dev/null 2>&1 || true
    '';
    virtualisation.oci-containers.containers = {
      wireguard-ui = {
        image = "ngoduykhanh/wireguard-ui:${cfg.version}";
        hostname = "wireguard-ui";
        autoStart = true;
        # Can be any ip between 172.77.0.1 - 172.77.255.254
        extraOptions = [
          "--network=${cfg.network}"
          "--ip=${cfg.ip}"
          "--cap-add=NET_ADMIN"
        ];
        ports = [
          # "externalPort:internalPort";
          "51821:5000"
        ];
        environment = {
          # variable = "string";
          TZ = "${config.time.timeZone}";
          WGUI_USERNAME = "arik";
          WGUI_PASSWORD = "password";
          WGUI_MANAGE_START = "true";
          WGUI_MANAGE_RESTART = "true";
        };
        volumes = [
          # "externalLocation:internalLocation"
          "/data/wireguard:/etc/wireguard"
          "/data/wireguard-ui:/app/db"
        ];
      };
    };
  };
}
