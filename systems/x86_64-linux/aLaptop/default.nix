{ pkgs, lib, nixos-hardware, ... }:

with lib;
{
  imports = [ ./hardware.nix ./configuration.nix];
  lib.plusultra = {
    apps = {
      blender.enable = true;
    };
  };
  lib.home-manager = {};
}
