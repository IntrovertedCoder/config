{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.eza;
in
{
  options.plusultra.apps.home.eza = with types; {
    enable = mkBoolOpt false "Whether or not to enable eza.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions.programs = {
      eza = {
        enable = true;
      };
      fish.shellAliases= mkIf config.plusultra.apps.home.fish.enable {
        ls = "eza -ax --icons --git $argv";
        ll = "eza -alhg --icons --git --octal-permissions $argv";
        tree = "eza -a --icons --tree --level 3 -F -I='.git.' --color=always $argv | less -r +g";
      };
    };
  };
}
