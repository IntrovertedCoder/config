{ lib, inputs, snowfall-inputs }:

rec {
  ## Override a package's metadata
  ##
  ## ```nix
  ## let
  ##  new-meta = {
  ##    description = "My new description";
  ##  };
  ## in
  ##  lib.override-meta new-meta pkgs.hello
  ## ```
  ##
  #@ Attrs -> Package -> Package
  override-meta = meta: package:
    package.overrideAttrs (attrs: {
      meta = (attrs.meta or { }) // meta;
    });

    openOnLan = config: { tcp ? [ ], udp ? [ ] }:
    let
      # Define your known "Internal/LAN" interfaces here if you want to be strict.
      # Or, we can use a trick to apply it to everything and then we
      # "lock down" ygg0 specifically in the yggdrasil module.

      # For Nobelium specifically, it seems you use "enp14s0".
      # If you want this to be truly automatic across all machines,
      # we need to know what the LAN interface is.

      # Better approach: check for common interface prefixes or
      # specific ones defined in your hardware-configuration.
      ifaceNames = lib.attrNames config.networking.interfaces;
    in
    if ifaceNames == [ ] then
      # FALLBACK: If no interfaces are defined in Nix,
      # you might need to hardcode a default or
      # pass the interface name as an argument.
      builtins.trace "WARNING: openOnLan found no interfaces in config.networking.interfaces!" { }
    else
      lib.genAttrs (lib.filter (i: i != "ygg0") ifaceNames) (name: {
        allowedTCPPorts = tcp;
        allowedUDPPorts = udp;
      });
}
