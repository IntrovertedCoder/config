{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.plusultra;
{
  imports = [ ./hardware.nix ./configuration.nix];
  plusultra = {
    desktop.addons.greetd.enable = true;
    apps = {
      CUPS = enabled;
      waydroid = enabled;
      obs = enabled;
      home = {
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

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };

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
