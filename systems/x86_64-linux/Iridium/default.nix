{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.plusultra;
{
  imports = [ ./hardware.nix ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

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
    ${dockerBin} network inspect IridiumNet >/dev/null 2>&1 || ${dockerBin} network create IridiumNet --subnet 172.20.0.0/16
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
