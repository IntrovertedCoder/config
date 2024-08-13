{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.plusultra;
{
  imports = [ ./hardware.nix ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # When changing hostName be sure to replaca all since we cant access config.network.hostName in this file for some reason
  networking.hostName = "Iridium"; # Define your hostname.
  networking.defaultGateway = "192.168.0.1";
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];
  networking.interfaces.enp87s0.ipv4.addresses = [ {
    address = "192.168.0.77";
    prefixLength = 24;
  } ];
  networking.interfaces.enp89s0.ipv4.addresses = [ {
    address = "192.168.0.78";
    prefixLength = 24;
  } ];
  networking.interfaces.wlp90s0.ipv4.addresses = [ {
    address = "192.168.0.75";
    prefixLength = 24;
  } ];

  time.timeZone = "America/Chicago";

  # virtualisation = { # {{{
    # docker = { # {{{
      # enable = true;
      # storageDriver = "btrfs";
    # }; # }}}
    # oci-containers.backend = "docker";
    # oci-containers.containers = {
      # SearxNG = {
        # image = "searxng/searxng:latest";
        # # extraOptions = [ "--restart=unless-stopped" ];
        # extraOptions = [ "--cap-add=SYS_ADMIN" ];
        # # autoStart = true;
        # ports = [ "8888:8080" ];
        # environment = {
          # BASE_URL = "http://localhost:8888";
          # INSTANCE_NAME = "aLaptop SearxNG";
          # container="docker";
        # };
        # volumes = [
          # "/etc/nixos/SearxNG.yml:/etc/searxng/settings.yml"
        # ];
      # };
    # };
  # }; # }}}

  plusultra = {
    desktop.addons.greetd.enable = true;
    apps = {
      CUPS = enabled;
      ssh = enabled;
      home = {
      };
      server = {
        samba = enabled;
        cockpit = enabled;
        pihole = {
          enable = true;
          network = "IridiumNet";
          ip = "172.77.0.10";
          # https://hub.docker.com/r/pihole/pihole/tags
          version = "2024.05.0";
        };
        unbound = {
          enable = true;
          network = "IridiumNet";
          ip = "172.77.0.11";
          # https://hub.docker.com/r/mvance/unbound/tags
          version = "1.12.0";
        };
        speedtest = {
          enable = true;
          network = "IridiumNet";
          ip = "172.77.0.12";
          # https://hub.docker.com/r/linuxserver/speedtest-tracker/tags
          version = "0.21.1";
        };
        smokeping = {
          enable = true;
          network = "IridiumNet";
          ip = "172.77.0.13";
          # https://hub.docker.com/r/linuxserver/smokeping/tags
          version = "2.8.2";
        };
        wireguard = {
          enable = true;
          network = "IridiumNet";
          ip = "172.77.0.14";
          # https://hub.docker.com/r/linuxserver/wireguard/tags
          version = "1.0.20210914";
        };
        wireguard-ui = {
          enable = true;
          network = "IridiumNet";
          ip = "172.77.0.15";
          # https://hub.docker.com/r/ngoduykhanh/wireguard-ui/tags
          version = "0.6.2";
        };
        plex = {
          enable = true;
          network = "IridiumNet";
          ip = "172.77.0.16";
          serverIp = "192.168.0.77";
          # https://hub.docker.com/r/plexinc/pms-docker/tags
          # Make sure to read
          # https://github.com/plexinc/pms-docker?tab=readme-ov-file#running-on-a-headless-server-with-container-using-host-networking
          # Before first setup
          version = "1.40.2.8395-c67dce28e";
        };
        searxng = {
          enable = true;
          serverIp = "192.168.0.77";
          network = "IridiumNet";
          ip = "172.77.0.17";
          # https://hub.docker.com/r/searxng/searxng/tags
          version = "2024.5.31-18fb701be";
          ipValkey = "172.77.0.18";
          # https://hub.docker.com/r/valkey/valkey/tags
          versionValkey = "7.2.5-alpine";
        };
      };
    };
    suites = {
    };
    user = {
      name = "arik";
      # home = "/home/${name}";
    };
    desktop = {
    };
  };
  lib.home-manager = {
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.arik = {
    # shell = "/home/arik/.nix-profile/bin/fish";
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "docker" ];
    packages = with pkgs; [
      firefox
      # alacritty
      kitty
    ];
  };
  virtualisation.oci-containers.backend = "docker";

  system.activationScripts.mkIridiumNet = let
    # docker = config.virtualisation.oci-containers.backend;
    docker = "docker";
    dockerBin = "${pkgs.${docker}}/bin/${docker}";
  in ''
    ${dockerBin} network inspect IridiumNet >/dev/null 2>&1 || ${dockerBin} network create IridiumNet --subnet 172.77.0.0/16
  '';

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    killall
    comma
  ];

  # Networking
    # Network Manager
      networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
      plusultra.user.extraGroups = [ "networkmanager" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-23.11";
}
