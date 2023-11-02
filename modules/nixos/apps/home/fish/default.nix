{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.fish;
in
{
  options.plusultra.apps.home.fish = with types; {
    enable = mkBoolOpt false "Whether or not to enable fish.";
  };

  config = mkIf cfg.enable {
    programs.fish.enable = true;
    users.users.${config.plusultra.user.name}.shell = pkgs.fish;
    plusultra.home.extraOptions.programs.fish = { # {{{
      enable = true;
      loginShellInit = ''
      '';
      # interactiveShellInit {{{
      interactiveShellInit = ''
        function fish_greeting
          if test -n "$SSH_TTY"  # Tell if running on ssh
          else if test "$USER" = 'root'  # Or if root
          else  # If neither then clear
            clear
          end

          # Start ssh-agent on startup
          # Note this doesn't add identity files
          if ps -p $SSH_AGENT_PID > /dev/null
            set sshagent "SET"
          else
            ssh-agent fish && exit
          end

          # Custom keybinds {{{
            # Bind F2 to insert sudo to beginning of line
            bind -k f2 __fish_prepend_sudo
            # Bind F3 to open command in EDITOR/VISUAL
            bind -k f3 edit_command_buffer
          # }}}

          fortune -s
        end

        function ex --description "Extract bundled & compressed files"
          if test -f "$argv[1]"
            switch $argv[1]
              case '*.tar.bz2'
                tar xjf $argv[1]
              case '*.tar.gz'
                tar xzf $argv[1]
              case '*.bz2'
                bunzip2 $argv[1]
              case '*.rar'
                unrar $argv[1]
              case '*.gz'
                gunzip $argv[1]
              case '*.tar'
                tar xf $argv[1]
              case '*.tbz2'
                tar xjf $argv[1]
              case '*.tgz'
                tar xzf $argv[1]
              case '*.zip'
                unzip $argv[1]
              case '*.Z'
                uncompress $argv[1]
              case '*.7z'
                7z $argv[1]
              case '*.deb'
                ar $argv[1]
              case '*.tar.xz'
                tar xf $argv[1]
              case '*.tar.zst'
                tar xf $argv[1]
              case '*'
                echo "'$argv[1]' cannot be extracted via ex"
            end
          else
            echo "'$argv[1]' is not a valid file"
          end
        end

        function mkcd
          mkdir -- $argv
          if [ $status = '0' ]
            builtin cd -- $argv
          end
        end

        function cd
          set cwd $PWD
          # builtin cd $argv
          z $argv
          if [ $PWD != $cwd ]
            exa -ax --icons --git
          end
        end

        set NIX_PATH /home/arik/.nix-defexpr/channels $NIX_PATH
      ''; # }}}
      functions = {
        ls = "exa -ax --icons --git $argv";
        ll = "exa -alhg --icons --git --octal-permissions $argv";
        tree = "exa -a --icons --tree --level 3 -F -I='.git.' --color=always $argv | less -r +g";
        lg = "ssh-add ~/.ssh/github && gitui";
        cp = "xcp $argv";
        cat = "bat $argv";
      };
    }; # }}}
  };
}
