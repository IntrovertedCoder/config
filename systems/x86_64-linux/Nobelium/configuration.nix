# edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{


  # Set your time zone.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Docker



  # fileSystems."/home/arik/data" = {
    # device = "//192.168.0.37/data";
    # fsType = "cifs";
    # options = ["credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
  # };
  # fileSystems."/home/arik/share" = {
    # device = "//192.168.0.37/data/share";
    # fsType = "cifs";
    # options = ["credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
  # };

}

