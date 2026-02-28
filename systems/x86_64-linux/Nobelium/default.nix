{ pkgs, lib, nixos-hardware, config, ... }:

with lib;
with lib.plusultra;
{
  imports = [ ./hardware.nix ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "Nobelium"; # Define your hostname.

  # networking.nameservers = [ "10.123.123.100" "10.123.123.101" "1.1.1.1" "1.1.2.2" ];
  # networking.resolvconf.enable = pkgs.lib.mkForce false;
  # networking.dhcpcd.extraConfig = "nohook resolv.conf";
  # networking.networkmanager.dns = "none";
  # services.resolved.enable = false;
  networking.firewall.interfaces = lib.plusultra.openOnLan config {
    # tcp = [ 7575 46287 ];
    # udp = [ 631 5353 ];
  };
  # networking.firewall.enable = false;

  networking.interfaces.enp14s0 = { }; # Declaring for openOnLan to work
  # networking.interfaces.enp14s0.ipv4.addresses = [ {
    # address = "10.123.0.102";
    # prefixLength = 16;
  # } ];

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
    desktop.addons.hyprpaper.enable = true;
    desktop.addons.greetd.enable = true;
    desktop.addons.swaylock = enabled;
    desktop.addons.tailscale = enabled;

    desktop.addons.yggdrasil = {
      enable = true;
      peers = [ "tls://ygg.jjolly.dev:3443" "tls://ygg8.mk16.de:1338?key=0000000b0683e38d8cb3085cfbf217edf0f0b2de76bb5ac7f02a94cd42a3fed9" "tls://sto01.yggdrasil.hosted-by.skhron.eu:8884" "tls://185.181.60.111:1513?key=00defa4b4b243547f2d5641ac5235ff1e35d393c576e4bb9cd45baefc81e48d9" "tls://ygg-hel-1.wgos.org:45171" ];
      # Available to any yggdrasil machine
      # allowedTCPPorts = [ 9998 ];

      # Only available to the specified yggdrasil IPs
      privatePeers = [
        "204:6d:9661:179c:9102:e01d:92c4:1707" # Phone
      ];
      privateTCPPorts = [ 9999 ];
    };

    apps = {
      CUPS = enabled;
      waydroid = disabled;
      obs = enabled;
      virtmanager = enabled;
      vial = enabled;
      home = {
        piper = enabled;
      };
    };
    suites = {
      art.enable = true;
      gaming = enabled;
    };
    user = {
      name = "arik";
      # home = "/home/${name}";
    };
    desktop = {
      mangowc.enable = true;
      Hyprland = {
        enable = true;
        masterConfig = ''
          orientation = center
          mfact = 0.5
        '';
        extraConfig3  = ''
          workspace=2, monitor:DP-1
          workspace=1, monitor:DP-2
          workspace=3, monitor:DP-1
          workspace=4, monitor:DP-2
          workspace=5, monitor:DP-1
          workspace=6, monitor:DP-2
          workspace=7, monitor:DP-1
          workspace=8, monitor:DP-2
          workspace=9, monitor:DP-1
          workspace=0, monitor:DP-2
          workspace = 11, monitor=DP-1


          workspace = 1, layoutopt:orientation:bottom
          workspace = 4, layoutopt:orientation:bottom
          workspace = 6, layoutopt:orientation:bottom
          workspace = 8, layoutopt:orientation:bottom
          workspace = 0, layoutopt:orientation:bottom

          workspace = 2, layoutopt:orientation:center
          workspace = 3, layoutopt:orientation:center
          workspace = 5, layoutopt:orientation:center
          workspace = 7, layoutopt:orientation:center
          workspace = 9, layoutopt:orientation:center
          bind = $mainMod, g, workspace, 11
          bind = $mainMod SHIFT, g, movetoworkspacesilent, 11
        '';
      };
    };
    # virtualisation.kvm = {
      # enable = true;
      # vfioIds = [ "1002:164e" "1002:1640" ];
      # platform = "amd";
    # };
  };
  lib.home-manager = {
    backupFileExtension = "bak";
  };

  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.arik = {
    # shell = "/home/arik/.nix-profile/bin/fish";
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "docker" ];
    packages = with pkgs; [
      # firefox
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

  # Networking
    # Network Manager
      networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
      plusultra.user.extraGroups = [ "networkmanager" "dialout" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-25.05";
}
