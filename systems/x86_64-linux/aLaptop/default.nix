{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.plusultra;
{
  imports = [ ./hardware.nix ./configuration.nix];
  plusultra = {
    desktop.Hyprland.enable = true;
    desktop.addons.hyprpaper.enable = true;
    desktop.addons.greetd.enable = true;
    desktop.addons.swaylock = enabled;
    desktop.addons.sunshine = enabled;
    desktop.addons.hyprsunset = enabled;

    desktop.addons.tailscale = enabled;
    desktop.addons.yggdrasil = {
      enable = true;
      peers = [ "tls://ygg.jjolly.dev:3443" "tls://ygg8.mk16.de:1338?key=0000000b0683e38d8cb3085cfbf217edf0f0b2de76bb5ac7f02a94cd42a3fed9" "tls://sto01.yggdrasil.hosted-by.skhron.eu:8884" "tls://185.181.60.111:1513?key=00defa4b4b243547f2d5641ac5235ff1e35d393c576e4bb9cd45baefc81e48d9" "tls://ygg-hel-1.wgos.org:45171" ];
      # Available to any yggdrasil machine
      # allowedTCPPorts = [ 9998 ];

      # Only available to the specified yggdrasil IPs
      privatePeers = [
        "204:6d:9661:179c:9102:e01d:92c4:1707" # Phone
        "200:7c2e:4344:a59a:3b59:b1ee:e87:c7a1" # aLaptop
      ];
      privateTCPPorts = [ 9999 ];
    };

    apps = {
      CUPS = enabled;
      waydroid = enabled;
    };
    suites = {
      art.enable = true;
      gaming = enabled;
    };
    user = {
      name = "arik";
      # home = "/home/${name}";
    };
  };
  lib.home-manager = {};

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

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    killall
    comma
  ];
  programs.captive-browser = {
    enable = true;
    interface = "wlp2s0";
  };

  # Networking
    # WPA_Supplicant
      # networking.wireless.enable = true;
    # Network Manager
      networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
      # networking.networkmanager.wifi.macAddress = "96:a9:fd:21:da:3a";
      # networking.networkmanager.wifi.macAddress = "B5:02:C4:EF:69:D0";
      # networking.networkmanager.wifi.macAddress = "random";
      networking.networkmanager.wifi.macAddress = "40:23:43:13:0F:57";
      networking.resolvconf.dnsExtensionMechanism = false;
      plusultra.user.extraGroups = [ "networkmanager" ];
      networking.useDHCP = lib.mkForce true;
      networking.firewall.allowedTCPPorts = [ 8080 ];

    # Set your time zone.
    time.timeZone = "America/Denver";

    # Wireguard
    networking.wg-quick.interfaces = {
      wg0 = {
        autostart = false;
        address = [ "10.8.0.4" ];
        dns = [ "10.123.123.100" ];
        privateKeyFile = "/home/arik/wireguard/privatekey-peer_aLaptop";

        peers = [
          {
            publicKey = "MQ98fEk5/023cmaDa180Gh7pi2xHaJtnXE0YtmRyLD0=";
            # presharedKeyFile = "/home/arik/wireguard/presharedkey-peer_aLaptop";
            allowedIPs = [ "0.0.0.0/0" ];
            endpoint = "216.106.75.41:51820";
            # endpoint = "10.123.123.102:51820";
          }
        ];
      };
    };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-25.05";
}
