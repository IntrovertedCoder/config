{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.gitui;
in
{
  options.plusultra.apps.home.gitui = with types; {
    enable = mkBoolOpt false "Whether or not to enable gitui.";
  };

  config = mkIf cfg.enable {
    plusultra.apps.home.git.enable = true;
    plusultra.home.extraOptions.programs = {
      gitui = {
        enable = true;
        keyConfig = ''
          (
            open_help: Some(( code: F(1), modifiers: "")),

            move_left: Some(( code: Char('h'), modifiers: "")),
            move_right: Some(( code: Char('l'), modifiers: "")),
            move_up: Some(( code: Char('k'), modifiers: "")),
            move_down: Some(( code: Char('j'), modifiers: "")),

            popup_up: Some(( code: Char('p'), modifiers: "CONTROL")),
            popup_down: Some(( code: Char('n'), modifiers: "CONTROL")),
            page_up: Some(( code: Char('b'), modifiers: "CONTROL")),
            page_down: Some(( code: Char('f'), modifiers: "CONTROL")),
            home: Some(( code: Char('g'), modifiers: "")),
            end: Some(( code: Char('G'), modifiers: "SHIFT")),
            shift_up: Some(( code: Char('K'), modifiers: "SHIFT")),
            shift_down: Some(( code: Char('J'), modifiers: "SHIFT")),

            edit_file: Some(( code: Char('I'), modifiers: "SHIFT")),

            status_reset_item: Some(( code: Char('U'), modifiers: "SHIFT")),

            diff_reset_lines: Some(( code: Char('u'), modifiers: "")),
            diff_stage_lines: Some(( code: Char('s'), modifiers: "")),

            stashing_save: Some(( code: Char('w'), modifiers: "")),
            stashing_toggle_index: Some(( code: Char('m'), modifiers: "")),

            stash_open: Some(( code: Char('l'), modifiers: "")),

            abort_merge: Some(( code: Char('M'), modifiers: "SHIFT")),
          )
        '';
        # theme = ''
          # (
            # selected_tab: ${config.plusultra.color.Gray},
            # command_fg: ${config.plusultra.color.White},
            # selection_bg: ${config.plusultra.color.Blue},
            # selection_fg: ${config.plusultra.color.White},
            # cmdbar_bg: ${config.plusultra.color.Blue},
            # cmdbar_extra_lines_bg: ${config.plusultra.color.Blue},
            # disabled_fg: ${config.plusultra.color.darkGray},
            # diff_line_add: ${config.plusultra.color.Green},
            # diff_line_delete: ${config.plusultra.color.Red},
            # diff_file_added: ${config.plusultra.color.brightGreen},
            # diff_file_removed: ${config.plusultra.color.brightRed},
            # diff_file_moved: ${config.plusultra.color.brightMagenta},
            # diff_file_modified: ${config.plusultra.color.Yellow},
            # commit_hash: ${config.plusultra.color.Magenta},
            # commit_time: ${config.plusultra.color.brightCyan},
            # commit_author: ${config.plusultra.color.Green},
            # danger_fg: ${config.plusultra.color.Red},
            # push_gauge_bg: ${config.plusultra.color.Blue},
            # push_gauge_fg: ${config.plusultra.color.Gray},
            # tag_fg: ${config.plusultra.color.brightMagenta},
            # branch_fg: ${config.plusultra.color.brightYellow},
          # )
        # '';
      };
      fish.shellAliases = mkIf config.plusultra.apps.home.fish.enable {
        lg = "ssh-add ~/.ssh/github && gitui";
      };
    };
  };
}
