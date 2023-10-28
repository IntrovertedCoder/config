{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.plusultra;
{
  imports = [ ./hardware.nix ./configuration.nix];
  plusultra = {
    apps = {
      blender = enabled;
      obs.enable = false;
      element.enable = true;
    };
    suites = {
      art.enable = true;
    };
  };
  lib.home-manager = {};
}
