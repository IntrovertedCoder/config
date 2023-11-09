{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.addons.gnomePolkit;
in
{
  options.plusultra.desktop.addons.gnomePolkit = with types; {
    enable = mkBoolOpt false "Whether or not to enable gnomePolkit.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      polkit_gnome
    ];
    security.polkit.enable = true;
    plusultra.desktop.Hyprland.extraConfig2 = mkIf config.plusultra.desktop.Hyprland.enable ''
      exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
    '';
    # This doesn't work because graphical-session.target isn't being reached in Hyprland
    # systemd = {
      # user.services.polkit-gnome-authentication-agent-1 = {
        # description = "polkit-gnome-authentication-agent-1";
        # wantedBy = [ "graphical-session.target" ];
        # wants = [ "graphical-session.target" ];
        # after = [ "graphical-session.target" ];
        # serviceConfig = {
          # Type = "simple";
          # ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          # Restart = "on-failure";
          # RestartSec = 1;
          # TimeoutStopSec = 10;
        # };
      # };
    # };
  };
}
