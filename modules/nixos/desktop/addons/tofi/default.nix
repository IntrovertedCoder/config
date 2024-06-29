{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.addons.tofi;
in
{
  options.plusultra.desktop.addons.tofi = with types; {
    enable = mkBoolOpt false "Whether or not to enable tofi.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ tofi ];
    # plusultra.home.extraOptions.home.packages = with pkgs; [ tofi ];
    plusultra.home.extraOptions = {
      programs.tofi = {
        enable = true;
        settings = {
          font = "${config.plusultra.font.Font}";
          font-size = 11;
          background-color = "${config.plusultra.color.Black}";
          border-width = 2;
          border-color = "${config.plusultra.color.Green}";
          corner-radius = 5;
          text-color = "${config.plusultra.color.White}";
          selection-color = "${config.plusultra.color.Blue}";
          selection-background = "${config.plusultra.color.Black}";
          prompt-text = "» ";
          width = 300;
          height = 300;
        };
      };
    };
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "launcher" ''
        command=$(${pkgs.tofi}/bin/tofi-run)
        exec ''${command} > "/tmp/$command-$(date)"
      '')
    ];
  };
}
