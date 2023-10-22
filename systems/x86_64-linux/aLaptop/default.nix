{ pkgs, lib, nixos-hardware, ... }:

with lib;
{
  imports = [ ./hardware.nix ./configuration.nix];
  lib.plusultra = {
    apps = {
      blender.enable = false;
      obs.enable = true;
    };
    suites = {
      art.enable = true;
    };
  };
  lib.home-manager = {};
}
