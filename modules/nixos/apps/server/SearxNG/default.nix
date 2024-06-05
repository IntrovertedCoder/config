{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.apps.server.searxng;
in
{
  options.plusultra.apps.server.searxng = with types; {
    enable = mkBoolOpt false "Whether or not to enable searxng container.";
    network = mkOpt str "" "The network id to put this container in.";
    ip = mkOpt str "" "The ip address to apply to the container.";
    serverIp = mkOpt str "" "The servers ip so plex can broadcast that its available at this address";
    version = mkOpt str "" "The container version as found on hub.docker.com";
    ipValkey = mkOpt str "" "The ip address to apply to the container.";
    versionValkey = mkOpt str "" "The container version as found on hub.docker.com";
  };

  config = mkIf cfg.enable {
    system.activationScripts.searxngFolder = ''
      mkdir /data >/dev/null 2>&1 || true
      mkdir /data/searxng >/dev/null 2>&1 || true
      mkdir /data/searxng/caddy >/dev/null 2>&1 || true
      mkdir /data/searxng/caddy/data >/dev/null 2>&1 || true
      mkdir /data/searxng/caddy/config >/dev/null 2>&1 || true
      mkdir /data/searxng/valkey >/dev/null 2>&1 || true
      mkdir /data/searxng/config >/dev/null 2>&1 || true
    '';
    virtualisation.oci-containers.containers = {
      searxng-redis = {
        image = "valkey/valkey:${cfg.versionValkey}";
        hostname = "searxng-valkey";
        autoStart = true;
        # Can be any ip between 172.77.0.1 - 172.77.255.254
        extraOptions = [
          "--network=${cfg.network}"
          "--ip=${cfg.ipValkey}"
          "--cap-drop=ALL"
          "--cap-add=SETGID"
          "--cap-add=SETUID"
          "--cap-add=DAC_OVERRIDE"
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
        entrypoint = "valkey-server";
        # cmd = [
          # "--save 30 1 --loglevel warning"
        # ];
      };
      searxng = {
        image = "searxng/searxng:${cfg.version}";
        hostname = "searxng";
        autoStart = true;
        # Can be any ip between 172.77.0.1 - 172.77.255.254
        extraOptions = [
          "--network=${cfg.network}"
          "--ip=${cfg.ip}"
          "--cap-drop=ALL"
          "--cap-add=SETGID"
          "--cap-add=SETUID"
          "--cap-add=CHOWN"
        ];
        ports = [
          # "externalPort:internalPort";
          "7070:8080"
        ];
        environment = {
          # variable = "string";
          TZ = "${config.time.timeZone}";
          SEARXNG_BASE_URL = "https://${cfg.serverIp}";
        };
        volumes = [
          # "externalLocation:internalLocation"
        ];
      };
    };
  };
}
