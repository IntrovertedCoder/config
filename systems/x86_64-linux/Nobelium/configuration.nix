# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "Nobelium"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Docker
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



  # fileSystems."/home/arik/data" = {
    # device = "//192.168.0.37/data";
    # fsType = "cifs";
    # options = ["credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
  # };
  # fileSystems."/home/arik/share" = {
    # device = "//192.168.0.37/data/share";
    # fsType = "cifs";
    # options = ["credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
  # };

}

