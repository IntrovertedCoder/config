# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # ./hardware-configuration.nix
    # (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz}/nixos")
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "aLaptop"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # GUI interfaces
    # Display managers
    # Enable the display manager, yes xserver.enable needs to be set to true for gdm
    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "amdgpu" ];
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = "arik";
        };
      };
    };
    # Window managers
      programs.wshowkeys.enable = true;
      programs.steam = {
        enable = true;
      };
  # xdg.portal = {
    # enable = false;
    # wlr.enable = false;
    # extraPortals = with pkgs; [
       # xdg-desktop-portal-hyprland
    # ];
  # };

  services.udev.packages = with pkgs ; [
    vial
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns= true;
  services.avahi.openFirewall = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
     enable = true;
     alsa.enable = true;
     pulse.enable = true;
  };

  # AMD GPU configuration and installation of extra packages
    # Get OpenCL
      hardware.opengl.extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
        amdvlk
      ];
    # Get Vulkan
      hardware.opengl.driSupport = true;
      hardware.opengl.driSupport32Bit = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Docker
  virtualisation = { # {{{
    waydroid.enable = true;
    # docker = { # {{{
      # enable = true;
      # storageDriver = "btrfs";
    # }; # }}}
    oci-containers.backend = "docker";
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
  }; # }}}

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.arik = {
    # shell = "/home/arik/.nix-profile/bin/fish";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "docker" ];
    packages = with pkgs; [
      firefox
      # alacritty
      kitty
    ];
  };


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

