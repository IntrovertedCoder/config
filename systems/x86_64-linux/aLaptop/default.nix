{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.plusultra;
{
  imports = [ ./hardware.nix ./configuration.nix];
  plusultra = {
    desktop.Hyprland.enable = true;
    desktop.addons.greetd.enable = true;
    desktop.addons.swaylock = enabled;
    desktop.addons.sunshine = enabled;
    desktop.addons.hyprsunset = enabled;
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
      plusultra.user.extraGroups = [ "networkmanager" ];
      networking.useDHCP = lib.mkForce true;
    # Wireguard
    networking.wg-quick.interfaces = {
      wg0 = {
        address = [ "10.8.0.3" ];
        dns = [ "172.77.0.51" ];
        privateKeyFile = "/home/arik/wireguard/privatekey-peer_aLaptop";

        peers = [
          {
            publicKey = "n7p60n0iXx42pEeh7WpnN7rGZqxgbbXkBOEE+6lVOC0=";
            presharedKeyFile = "/home/arik/wireguard/presharedkey-peer_aLaptop";
            allowedIPs = [ "0.0.0.0/0" ];
            endpoint = "216.229.90.51:51820";
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
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-23.11";
}
