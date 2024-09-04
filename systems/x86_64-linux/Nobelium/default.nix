{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.plusultra;
{
  imports = [ ./hardware.nix ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "Nobelium"; # Define your hostname.

  networking.nameservers = [ "192.168.0.77" "1.1.1.1" "1.1.2.2" ];
  networking.resolvconf.enable = pkgs.lib.mkForce false;
  networking.dhcpcd.extraConfig = "nohook resolv.conf";
  networking.networkmanager.dns = "none";
  services.resolved.enable = false;

  # networking.interfaces.enp14s0.ipv4.addresses = [ {
    # address = "192.168.0.102";
    # prefixLength = 24;
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
    desktop.addons.greetd.enable = true;
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
      Hyprland = {
        enable = true;
        masterConfig = ''
          orientation = center
          mfact = 0.5
        '';
        extraConfig3  = ''
          workspace=1, monitor:DP-1
          workspace=2, monitor:DP-2
          workspace=3, monitor:DP-1
          workspace=4, monitor:DP-2
          workspace=5, monitor:DP-1
          workspace=6, monitor:DP-2
          workspace=7, monitor:DP-1
          workspace=8, monitor:DP-2
          workspace=9, monitor:DP-1
          workspace=0, monitor:DP-2
          workspace = 11, monitor=DP-1
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
