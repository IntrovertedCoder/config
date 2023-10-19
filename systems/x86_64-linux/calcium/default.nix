b, nixos-hardware, ... }:

with lib;
with lib.plusultra;
{
  imports = [ ./hardware.nix ];i{ pkgs, lib, nixos-hardware, ... }:

with lib;
with lib.plusultra;
{
  imports = [ ./hardware.nix /etc/nixos/configuration.nix];
};
