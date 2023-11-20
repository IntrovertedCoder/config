{ options, config, pkgs, lib, ... }:

with lib;
with lib.plusultra;
let
  cfg = config.plusultra.user;
  defaultIconFileName = "profile.png";
  defaultIcon = pkgs.stdenvNoCC.mkDerivation {
    name = "default-icon";
    src = ./. + "/${defaultIconFileName}";

    dontUnpack = true;

    installPhase = ''
      cp $src $out
    '';

    passthru = { fileName = defaultIconFileName; };
  };
  propagatedIcon = pkgs.runCommandNoCC "propagated-icon"
    { passthru = { fileName = cfg.icon.fileName; }; }
    ''
      local target="$out/share/plusultra-icons/user/${cfg.name}"
      mkdir -p "$target"

      cp ${cfg.icon} "$target/${cfg.icon.fileName}"
    '';
in
{
  options.plusultra.user = with types; {
    name = mkOpt str "arik" "The name to use for the user account.";
    fullName = mkOpt str "Arik Trotnic" "The full name of the user.";
    email = mkOpt str "NATrotnic@gmail.com" "The email of the user.";
    initialPassword = mkOpt str "password"
      "The initial password to use when the user is first created.";
    icon = mkOpt (nullOr package) defaultIcon
      "The profile picture to use for the user.";
    prompt-init = mkBoolOpt true "Whether or not to show an initial message when opening a new shell.";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { }
      (mdDoc "Extra options passed to `users.users.<name>`.");
  };

  config = {
    environment.systemPackages = with pkgs; [
      cowsay
      fortune
      lolcat
      propagatedIcon
        kickoff
        gparted
        xorg.xhost # Allow for gparted sudo "xhost +SI:localuser:root"
        libnotify
        # Python Stuff
          python311
          pipx
          python311Packages.pip
        # AI Stuff
          openai-whisper  # Audio to test
        # GUI Text editors
          sublime
          obsidian
        # Office Stuff
          onlyoffice-bin
        # Terminal Tools
          fend            # Calculator            # fend
          bottom          # Terminal task manager # btm
          gh              # Github CLI            # gh
          fd              # Rust file finder      # fd
          neofetch        # Showoff               # neofetch
          tealdeer        # Rust tldr             # tldr
          wthrr           # Rust weather          # wthrr
          ranger          # TUI file manager      # ranger
          fortune         # Random quote          # fortune
          btop            # Terminal task manager # btop
        # Phone stuff
          scrcpy
        # Video
          vlc
          libsForQt5.koko
        # Audio
          audacity
          helvum
          mpc-cli
          pavucontrol
        # Replay Gain
          r128gain
        # Games
          ## Minecraft
            prismlauncher
          ## Steam
            # steam
            # steam-tui

        # Network debugging
          speedtest-cli
          trippy
        # Wayland
          # Screenshot
            grim
            slurp
          # Bar
            eww-wayland
            python311
            radeontop
          # Brightnessc ontrol
            brightnessctl
          # Obs?
          wl-clipboard
    ];

    plusultra.home = {
      file = { # {{{
        "Pictures/${
          cfg.icon.fileName or (builtins.baseNameOf cfg.icon)
        }".source = cfg.icon;
      }; # }}}

      # Home manager options
      extraOptions = {
        programs = {
          git = {
            enable = true;
            userName = "IntrovertedCoder";
            userEmail = "natrotnic@gmail.com";
          };
        };

      };
    };
    plusultra.apps = {
      home = {
        fish.enable = true;
        starship.enable = true;
        discord.openASAR.enable = true;
        alacritty.enable = true;
        vim.enable = true;
        zoxide.enable = true;
        exa.enable = true;
        bat.enable = true;
        xcp.enable = true;
        firefox.enable = true;
        mpd.enable = true;
        ncmpcpp.enable = true;
        gitui.enable = true;
        vial.enable = true;
        gomuks.enable = true;
        thunar.enable = true;
      };
    };

    users.users.${cfg.name} = {
      extraGroups = [ ] ++ cfg.extraGroups;
    };
  };
}
