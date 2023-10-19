{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.plusultra;
{
  imports = [ /etc/nixos/hardware.nix /etc/nixos/configuration.nix];
}
