{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.addons.tailscale;
in
{
  options.plusultra.desktop.addons.tailscale = with types; {
    enable = mkBoolOpt false "Whether or not to enable tailscale.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ tailscale ];
    # plusultra.home.extraOptions.home.packages = with pkgs; [ tailscale ];
    # plusultra.home.extraOptions = {
    services.tailscale = {
      enable = true;
    };
    # };
    # environment.systemPackages = [
      # (pkgs.writeShellScriptBin "launcher" ''
        # command=$(${pkgs.tailscale}/bin/tofi-run)
        # exec ''${command} > "/tmp/$command-$(date)"
      # '')
    # ];
  };
}
