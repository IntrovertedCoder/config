{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.plusultra;
{
  imports = [ ./hardware.nix ./configuration.nix];
  plusultra = {
    apps = {
      blender = disabled;
      # Obs is still busted for some reason
      obs = disabled;
      element = disabled;
    };
    suites = {
      art.enable = true;
    };
  };
  lib.home-manager = {};
}
