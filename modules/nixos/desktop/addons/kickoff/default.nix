{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.desktop.addons.kickoff;
in
{
  options.plusultra.desktop.addons.kickoff = with types; {
    enable = mkBoolOpt false "Whether or not to enable kickoff.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ kickoff ];
    plusultra.home.extraOptions.home.packages = with pkgs; [ kickoff ];
    plusultra.home.configFile = {
      "kickoff/config.toml".text = ''
      # Kickoff default config

      # space between window border and the content in pixel
        padding = 100

      fonts = [
        '${config.plusultra.font.Font}',
        'Noto Sans Mono',
      ] # list of otf or ttf fonts. later elements work as fallback
      font_size = 32.0

        [history]
        decrease_interval = 48 # interval to decrease the number of launches in hours

        [colors]
        # color format: rgb or rgba, if transparency is desired
        background = '${config.plusultra.color.Black}aa'
        prompt = '${config.plusultra.color.Gray}'
        text = '${config.plusultra.color.darkWhite}'          # for search results
        text_query = '${config.plusultra.color.brightWhite}'    # for the search query
        text_selected = '${config.plusultra.color.Blue}' # for the currently selected result

        [keybindings]
        # keybindings syntax: ctrl/shift/alt/logo as modifiers and a key joined by '+' signs
        # A list of available keys can be found here: https://docs.rs/crate/x11-keysymdef/0.2.0/source/src/keysym.json
        paste = ["ctrl+v"]
        execute = ["KP_Enter", "Return"]
        delete = ["KP_Delete", "Delete", "BackSpace"]
        delete_word = ["ctrl+KP_Delete", "ctrl+Delete", "ctrl+BackSpace"]
        complete = ["Tab"]
        nav_up = ["Up"]
        nav_down = ["Down"]
        exit = ["Escape"]
      '';
    };
  };
}
