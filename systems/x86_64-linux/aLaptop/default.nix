{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.plusultra;
{
  imports = [ ./hardware.nix ./configuration.nix];
  plusultra = {
    desktop.Hyprland.enable = true;
    apps = {
      # Obs is still busted for some reason
      obs = disabled;
      element = disabled;
      # Discord
        # discord = enabled;
        # Vencord = enabled;
        openASAR = enabled;
        # ASAR-Vencord = enabled;
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
}
