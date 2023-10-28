{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.plusultra;
{
  imports = [ ./hardware.nix ./configuration.nix];
  lib.plusultra = {
    apps = {
      blender = enabled;
      obs.enable = true;
      element = enabled;
    };
    suites = {
      art.enable = true;
    };
  };
  lib.home-manager = {};
}
