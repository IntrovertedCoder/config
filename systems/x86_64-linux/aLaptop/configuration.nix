# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
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

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };


  # GUI interfaces
    # Display managers
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
      # Hyprland
      programs.xwayland.enable = true;
      # programs.hyprland = {
        # enable = false;
        # xwayland.enable = true;
      # };
      programs.wshowkeys.enable = true;
      programs.steam = {
        enable = true;
      };
      security.polkit.enable = true;
      # Allow swaylock to unlock the laptop
      security.pam.services.swaylock = {};
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
  # Enable the display manager, yes xserver.enable needs to be set to true for gdm
  services.xserver.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.gdm.wayland = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  # services.xserver.displayManager.sddm.enable = true;
  # Hyprland does not launch with lightdm
  # services.xserver.displayManager.lightdm.enable = true;

  # Keep disabled because it messes with hyprland launching speeds
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

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

  # home-manager.users.arik = import /home/arik/.config/nixpkgs/home.nix;

  # Adding the fish shell to /etc/shells?
  # I am not happy about needing this, or setting the shell in users.users.arik
  environment.shells = [ "/home/arik/.nix-profile/bin/fish" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    pciutils
    rocgdb
    # rocmPackages.rocgdb
    killall
    clinfo
    comma

    # Hyprland packages
    swaylock-effects
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services = {
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  networking.firewall.allowedUDPPorts = [ 51820 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-23.05";
  nixpkgs.config = {
    allowUnfree = true;
  };


  # BTRFS mount options
  fileSystems."/" = {
    options = [
      "compress=zstd:1"
      "noatime"
      "datacow"
      "datasum"
      "ssd"
    ];
  };
  fileSystems."/home" = {
    options = [
      "compress=zstd:1"
      "noatime"
      "datacow"
      "datasum"
      "ssd"
    ];
  };
  fileSystems."/log" = {
    options = [
      "compress=zstd:1"
      "noatime"
      "datacow"
      "datasum"
      "ssd"
    ];
  };
  fileSystems."/nix" = {
    options = [
      "compress=zstd:1"
      "noatime"
      "datacow"
      "datasum"
      "ssd"
    ];
  };
  fileSystems."/persist" = {
    options = [
      "compress=zstd:1"
      "noatime"
      "datacow"
      "datasum"
      "ssd"
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

