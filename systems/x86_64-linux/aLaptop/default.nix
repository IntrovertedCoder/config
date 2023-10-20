{ pkgs, lib, nixos-hardware, ... }:

with lib;
{
  imports = [ ./hardware.nix ./configuration.nix];
  lib.plusultra = {
  };
  lib.home-manager = {};
}
