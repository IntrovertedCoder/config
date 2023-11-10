{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.addons.greetd;
in
{
  options.plusultra.desktop.addons.greetd = with types; {
    enable = mkBoolOpt false "Whether or not to enable greetd.";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "amdgpu" ];
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = config.plusultra.user.name;
        };
      };
    };
  };
}
