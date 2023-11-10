{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.plusultra;
{
  imports = [ ./hardware.nix ./configuration.nix];
  plusultra = {
    desktop.Hyprland.enable = true;
    desktop.addons.greetd.enable = true;
    apps = {
      # Obs is still busted for some reason
      obs = disabled;
      element = disabled;
      CUPS = enabled;
    };
    suites = {
      art.enable = true;
    };
    user = {
      name = "arik";
      # home = "/home/${name}";
    };
  };
  lib.home-manager = {};

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    killall
    comma
  ];

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
}
