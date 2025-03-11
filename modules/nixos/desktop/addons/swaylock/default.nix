{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.addons.swaylock;
in
{
  options.plusultra.desktop.addons.swaylock = with types; {
    enable = mkBoolOpt false "Whether or not to enable swaylock.";
    timeout = mkOpt str "300" "Swaylock timeout time";
  };

  config = mkIf cfg.enable {
    plusultra.desktop.Hyprland.extraConfig1 = mkIf config.plusultra.desktop.Hyprland.enable ''
      exec-once = swayidle -w timeout 10 'if pgrep -x swaylock; then hyprctl dispatch dpms off; fi' resume 'hyprctl dispatch dpms on'
      exec-once = swayidle -w timeout ${cfg.timeout} 'swaylock --screenshots --clock --indicator --effect-blur 10x10 --ring-color=${config.plusultra.color.BlueNum} --text-color=${config.plusultra.color.brightGreenNum} --ring-clear-color=${config.plusultra.color.MagentaNum} --text-wrong-color=${config.plusultra.color.RedNum} --text-color=${config.plusultra.color.WhiteNum} --text-wrong-color=${config.plusultra.color.MagentaNum} --fade-in=3 --grace=3' timeout 330 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
    '';
    environment.systemPackages = with pkgs; [
      swaylock-effects
      swayidle
      hypridle
    ];
    security.pam.services.swaylock = {};
  };
}
