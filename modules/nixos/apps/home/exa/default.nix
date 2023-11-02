{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.exa;
in
{
  options.plusultra.apps.home.exa = with types; {
    enable = mkBoolOpt false "Whether or not to enable exa.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions.programs = {
      exa = {
        enable = true;
      };
      fish.functions = mkIf config.plusultra.apps.home.fish.enable {
        ls = "exa -ax --icons --git $argv";
        ll = "exa -alhg --icons --git --octal-permissions $argv";
        tree = "exa -a --icons --tree --level 3 -F -I='.git.' --color=always $argv | less -r +g";
      };
    };
  };
}
