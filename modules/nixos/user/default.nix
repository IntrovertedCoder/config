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

# Define colors for configurations {{{
# Examples
# format = "[ $duration](${Yellow})" ;
# background = Black;
  darkBlack = "#040404";
  Black = "#060606";
  brightBlack = "#3B3B3B";

  darkRed = "#9C000A";
  Red = "#C7000C";
  brightRed = "#FF0B1B";

  darkerGreen = "#235A00";
  darkGreen = "#3C9C00";
  Green = "#4CC700";
  brightGreen = "#68FF0B";

  darkYellow = "#AAA206";
  Yellow = "#D8C308";
  brightYellow = "#F7ED26";

  darkBlue = "#0050D0";
  Blue = "#0B68FF";
  brightBlue = "#3F88FF";

  darkMagenta = "#63457B";
  Magenta = "#7E599D";
  brightMagenta = "#6A7AB4";

  darkCyan = "#006DC0";
  Cyan = "#008CF7";
  brightCyan = "#0BBAFF";

  darkWhite = "#949494";
  White = "#BCBCBC";
  brightWhite = "#EFEFEF";

  darkOrange = "#A55108";
  Orange = "#D0670A";
  brightOrange = "#F58825";

  darkGray = "#4C4C4C";
  Gray = "#616161";
  brightGray = "#838383";

  Font = "Hack Regular Nerd Font Complete Mono";
  #}}}
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
        pipx
        libnotify
        # Python Stuff
          python311
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
          gitui           # Git tui manager       # gitui
          gh              # Github CLI            # gh
          fd              # Rust file finder      # fd
          neofetch        # Showoff               # neofetch
          tealdeer        # Rust tldr             # tldr
          wthrr           # Rust weather          # wthrr
          ranger          # TUI file manager      # ranger
          xcp             # Better rust cp        # xcp
          fortune         # Random quote          # fortune
          btop            # Terminal task manager # btop
          mdcat           # Rust cat for markdown # mdcat
        # Phone stuff
          scrcpy
        # Communications
          gomuks
          # (discord.override { withOpenASAR = false; withVencord = false; })
        # Video
          vlc
          # davinci-resolve
        # Image Manipulation
          inkscape
          gimp
          # blender
          libsForQt5.koko
        # Audio
          audacity
          helvum
          mpc-cli
          pavucontrol
        # QMK
          vial
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
        # Thunar
          xfce.thunar
          gvfs
          xfce.thunar-archive-plugin
          xfce.thunar-media-tags-plugin
          xfce.thunar-volman
          xfce.tumbler
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
          # Screenlocker
            # swaylock-effects
            swayidle
          # Obs?
            xdg-desktop-portal-hyprland
          wl-clipboard
    ];

    plusultra.home = {
      file = { # {{{
        # Monokai-bold {{{
        ".vim/colors/monokai-bold.vim".text = ''
  if !has("gui_running") && &t_Co < 256
    finish
  endif

  if ! exists("g:monokai_gui_italic")
      let g:monokai_gui_italic = 1
  endif

  if ! exists("g:monokai_term_italic")
      let g:monokai_term_italic = 0
  endif

  let g:monokai_termcolors = 256 " does not support 16 color term right now.

  set background=dark
  hi clear

  if exists("syntax_on")
    syntax reset
  endif

  let colors_name = "monokai-bold"

  function! s:h(group, style)
    let s:ctermformat = "NONE"
    let s:guiformat = "NONE"
    if has_key(a:style, "format")
      let s:ctermformat = a:style.format
      let s:guiformat = a:style.format
    endif
    if g:monokai_term_italic == 0
      let s:ctermformat = substitute(s:ctermformat, ",italic", "", "")
      let s:ctermformat = substitute(s:ctermformat, "italic,", "", "")
      let s:ctermformat = substitute(s:ctermformat, "italic", "", "")
    endif
    if g:monokai_gui_italic == 0
      let s:guiformat = substitute(s:guiformat, ",italic", "", "")
      let s:guiformat = substitute(s:guiformat, "italic,", "", "")
      let s:guiformat = substitute(s:guiformat, "italic", "", "")
    endif
    if g:monokai_termcolors == 16
      let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm16 : "NONE")
      let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm16 : "NONE")
    else
      let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm : "NONE")
      let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm : "NONE")
    end
    execute "highlight" a:group
      \ "guifg="   (has_key(a:style, "fg")      ? a:style.fg.gui   : "NONE")
      \ "guibg="   (has_key(a:style, "bg")      ? a:style.bg.gui   : "NONE")
      \ "guisp="   (has_key(a:style, "sp")      ? a:style.sp.gui   : "NONE")
      \ "gui="     (!empty(s:guiformat) ? s:guiformat   : "NONE")
      \ "ctermfg=" . l:ctermfg
      \ "ctermbg=" . l:ctermbg
      \ "cterm="   (!empty(s:ctermformat) ? s:ctermformat   : "NONE")
  endfunction

  " Palettes
  " --------

  let s:white       = { "gui": "${brightWhite}", "cterm": "255" }
  let s:white2      = { "gui": "${White}", "cterm": "253" }
  let s:black       = { "gui": "${Black}", "cterm": "0" }
  let s:black       = { "gui": "${Black}", "cterm": "0" }
  let s:lightblack  = { "gui": "${Black}", "cterm": "0" }
  let s:lightblack2 = { "gui": "${brightBlack}", "cterm": "235" }
  let s:lightblack3 = { "gui": "${darkGray}", "cterm": "237" }
  let s:darkblack   = { "gui": "${darkBlack}", "cterm": "0" }
  let s:grey        = { "gui": "${Gray}", "cterm": "241" }
  let s:lightgrey   = { "gui": "${darkWhite}", "cterm": "246" }
  let s:darkgrey    = { "gui": "${darkGray}", "cterm": "238" }
  let s:warmgrey    = { "gui": "${brightGray}", "cterm": "59" }
  let s:NonText     = { "gui": "${brightBlack}", "cterm": "233" }

  let s:pink        = { "gui": "${brightRed}", "cterm": "9" }
  let s:green       = { "gui": "${Green}", "cterm": "76" }
  let s:aqua        = { "gui": "${Blue}", "cterm": "27" }
  let s:yellow      = { "gui": "${Yellow}", "cterm": "184" }
  let s:orange      = { "gui": "${Orange}", "cterm": "214" }
  let s:purple      = { "gui": "${Magenta}", "cterm": "97" }
  let s:red         = { "gui": "${Red}", "cterm": "1" }
  let s:purered     = { "gui": "#ff0000", "cterm": "52" }
  let s:darkred     = { "gui": "${darkRed}", "cterm": "124" }

  let s:addfg       = { "gui": "${brightGreen}", "cterm": "193" }
  let s:addbg       = { "gui": "${Green}", "cterm": "65" }
  let s:delbg       = { "gui": "${brightRed}", "cterm": "167" }
  let s:changefg    = { "gui": "${brightBlue}", "cterm": "189" }
  let s:changebg    = { "gui": "${darkBlue}", "cterm": "60" }

  let s:cyan        = { "gui": "${Cyan}" }
  let s:br_green    = { "gui": "${Green}" }
  let s:br_yellow   = { "gui": "${Yellow}" }
  let s:br_blue     = { "gui": "${Blue}" }
  let s:br_purple   = { "gui": "${Magenta}" }
  let s:br_cyan     = { "gui": "${Cyan}" }
  let s:br_white    = { "gui": "${White}" }

  " Highlighting
  " ------------

  " editor
  call s:h("Normal",        { "fg": s:white,      "bg": s:black })
  call s:h("ColorColumn",   {                     "bg": s:lightblack })
  call s:h("Cursor",        { "fg": s:black,      "bg": s:white })
  call s:h("CursorColumn",  {                     "bg": s:lightblack2 })
  call s:h("CursorLine",    {                     "bg": s:lightblack2 })
  call s:h("NonText",       { "fg": s:NonText})
  call s:h("StatusLine",    { "fg": s:warmgrey,   "bg": s:black,        "format": "reverse" })
  call s:h("StatusLineNC",  { "fg": s:darkgrey,   "bg": s:warmgrey,     "format": "reverse" })
  call s:h("TabLine",       { "fg": s:white,      "bg": s:darkblack,    "format": "reverse" })
  call s:h("Visual",        {                     "bg": s:lightgrey })
  call s:h("Search",        { "fg": s:black,      "bg": s:yellow })
  call s:h("MatchParen",    { "fg": s:purple,                           "format": "underline,bold" })
  call s:h("Question",      { "fg": s:yellow })
  call s:h("ModeMsg",       { "fg": s:yellow })
  call s:h("MoreMsg",       { "fg": s:yellow })
  call s:h("ErrorMsg",      { "fg": s:black,      "bg": s:red,          "format": "standout" })
  call s:h("WarningMsg",    { "fg": s:red })
  call s:h("VertSplit",     { "fg": s:darkgrey,   "bg": s:darkblack })
  call s:h("LineNr",        { "fg": s:grey,       "bg": s:lightblack })
  call s:h("CursorLineNr",  { "fg": s:orange,     "bg": s:lightblack })
  call s:h("SignColumn",    {                     "bg": s:lightblack })

  " spell
  call s:h("SpellBad",      { "fg": s:red,                              "format": "underline" })
  call s:h("SpellCap",      { "fg": s:purple,                           "format": "underline" })
  call s:h("SpellRare",     { "fg": s:aqua,                             "format": "underline" })
  call s:h("SpellLocal",    { "fg": s:pink,                             "format": "underline" })

  " misc
  call s:h("SpecialKey",    { "fg": s:pink })
  call s:h("Title",         { "fg": s:yellow })
  call s:h("Directory",     { "fg": s:aqua })

  " diff
  call s:h("DiffAdd",       { "fg": s:addfg,      "bg": s:addbg })
  call s:h("DiffDelete",    { "fg": s:black,      "bg": s:delbg })
  call s:h("DiffChange",    { "fg": s:changefg,   "bg": s:changebg })
  call s:h("DiffText",      { "fg": s:black,      "bg": s:aqua })

  " fold
  call s:h("Folded",        { "fg": s:warmgrey,   "bg": s:darkblack })
  call s:h("FoldColumn",    {                     "bg": s:darkblack })
  "        Incsearch"

  " popup menu
  call s:h("Pmenu",         { "fg": s:white2,     "bg": s:lightblack3 })
  call s:h("PmenuSel",      { "fg": s:aqua,       "bg": s:lightblack3,        "format": "reverse,bold" })
  call s:h("PmenuThumb",    { "fg": s:lightblack, "bg": s:grey })
  "        PmenuSbar"

  " Generic Syntax Highlighting
  " ---------------------------

  call s:h("Constant",      { "fg": s:purple })
  call s:h("Number",        { "fg": s:purple, "format": "bold" })
  call s:h("Float",         { "fg": s:purple, "format": "bold" })
  call s:h("Boolean",       { "fg": s:purple })
  call s:h("Character",     { "fg": s:yellow })
  call s:h("String",        { "fg": s:yellow })

  call s:h("pythonBuiltin", { "fg": s:aqua })
  call s:h("pythonInclude", { "fg": s:darkred })
  call s:h("Type",          { "fg": s:aqua })
  call s:h("Structure",     { "fg": s:pink })
  call s:h("StorageClass",  { "fg": s:aqua })
  call s:h("Typedef",       { "fg": s:aqua })

  call s:h("Identifier",    { "fg": s:green })
  call s:h("Function",      { "fg": s:green, "format": "bold" })

  call s:h("Statement",     { "fg": s:aqua })
  call s:h("Operator",      { "fg": s:aqua })
  call s:h("Label",         { "fg": s:aqua })
  call s:h("Keyword",       { "fg": s:aqua, "format": "bold" })
  call s:h("Conditional",   { "fg": s:aqua, "format": "bold" })
  "        Repeat"
  "        Exception"

  call s:h("PreProc",       { "fg": s:green })
  call s:h("Include",       { "fg": s:pink })
  call s:h("Define",        { "fg": s:pink })
  call s:h("Macro",         { "fg": s:green })
  call s:h("PreCondit",     { "fg": s:green })

  call s:h("Special",       { "fg": s:purple })
  call s:h("SpecialChar",   { "fg": s:pink })
  call s:h("Delimiter",     { "fg": s:pink })
  call s:h("SpecialComment",{ "fg": s:aqua })
  call s:h("Tag",           { "fg": s:pink })
  "        Debug"

  call s:h("Todo",          { "fg": s:orange,   "format": "bold,italic" })
  call s:h("Comment",       { "fg": s:warmgrey, "format": "italic" })

  call s:h("Underlined",    { "fg": s:green })
  call s:h("Ignore",        {})
  call s:h("Error",         { "fg": s:red, "bg": s:darkred })

  " NerdTree
  " --------

  call s:h("NERDTreeOpenable",        { "fg": s:yellow })
  call s:h("NERDTreeClosable",        { "fg": s:yellow })
  call s:h("NERDTreeHelp",            { "fg": s:yellow })
  call s:h("NERDTreeBookmarksHeader", { "fg": s:pink })
  call s:h("NERDTreeBookmarksLeader", { "fg": s:black })
  call s:h("NERDTreeBookmarkName",    { "fg": s:yellow })
  call s:h("NERDTreeCWD",             { "fg": s:pink })
  call s:h("NERDTreeUp",              { "fg": s:white })
  call s:h("NERDTreeDirSlash",        { "fg": s:grey })
  call s:h("NERDTreeDir",             { "fg": s:grey })

  " Syntastic
  " ---------

  hi! link SyntasticErrorSign Error
  call s:h("SyntasticWarningSign",    { "fg": s:lightblack, "bg": s:orange })

  " coc
  " ---

  hi! link CocErrorSign Error
  call s:h("CocErrorHighlight",       { "fg": s:red, "format": "underline" })
  call s:h("CocErrorFloat",           { "fg": s:purered, "bg": s:lightblack3 })

  call s:h("CocWarningSign",          { "fg": s:orange, "bg": s:lightblack })
  call s:h("CocWarningHighlight",     { "format": "underline" })
  call s:h("CocWarningFloat",         { "fg": s:orange, "bg": s:lightblack3 })

  call s:h("CocInfoSign",             { "fg": s:yellow, "bg": s:lightblack3 })
  call s:h("CocInfoHighlight",        { "format": "underline" })

  call s:h("CocHintSign",             { "fg": s:white, "bg": s:lightblack3 })
  call s:h("CocHintHighlight",        { "format": "underline" })

  " Language highlight
  " ------------------

  " Java properties
  call s:h("jpropertiesIdentifier",   { "fg": s:pink })

  " Vim command
  call s:h("vimCommand",              { "fg": s:pink })

  " Javascript
  call s:h("jsFuncName",          { "fg": s:green, "format": "bold" })
  call s:h("jsThis",              { "fg": s:pink })
  call s:h("jsFunctionKey",       { "fg": s:green })
  call s:h("jsPrototype",         { "fg": s:aqua })
  call s:h("jsExceptions",        { "fg": s:aqua })
  call s:h("jsFutureKeys",        { "fg": s:aqua })
  call s:h("jsBuiltins",          { "fg": s:aqua })
  call s:h("jsArgsObj",           { "fg": s:aqua })
  call s:h("jsStatic",            { "fg": s:aqua })
  call s:h("jsSuper",             { "fg": s:aqua })
  call s:h("jsFuncArgRest",       { "fg": s:purple, "format": "italic" })
  call s:h("jsFuncArgs",          { "fg": s:orange, "format": "italic" })
  call s:h("jsStorageClass",      { "fg": s:aqua })
  call s:h("jsDocTags",           { "fg": s:aqua,   "format": "italic" })

  " Typescript
  call s:h("typescriptArrowFuncArg",        { "fg": s:orange, "format": "italic" })
  call s:h("typescriptFuncType",            { "fg": s:orange, "format": "italic" })
  call s:h("typescriptCall",                { "fg": s:orange, "format": "italic" })
  call s:h("typescriptVariable",            { "fg": s:aqua })
  call s:h("typescriptModule",              { "fg": s:aqua })
  call s:h("typescriptPredefinedType",      { "fg": s:aqua })
  call s:h("typescriptFuncTypeArrow",       { "fg": s:aqua })
  call s:h("typescriptImport",              { "fg": s:pink })
  call s:h("typescriptExport",              { "fg": s:pink })
  call s:h("typescriptCastKeyword",         { "fg": s:pink })
  call s:h("typescriptOperator",            { "fg": s:pink })
  call s:h("typescriptEndColons",           { "fg": s:white })
  call s:h("typescriptObjectLabel",         { "fg": s:green })
  call s:h("typescriptAmbientDeclaration",  { "fg": s:pink })
  call s:h("typescriptTestGlobal",          { "fg": s:pink })

  " Html
  call s:h("htmlTag",             { "fg": s:white })
  call s:h("htmlEndTag",          { "fg": s:white })
  call s:h("htmlTagName",         { "fg": s:pink })
  call s:h("htmlArg",             { "fg": s:green })
  call s:h("htmlSpecialChar",     { "fg": s:purple })

  " Xml
  call s:h("xmlTag",              { "fg": s:pink })
  call s:h("xmlEndTag",           { "fg": s:pink })
  call s:h("xmlTagName",          { "fg": s:orange })
  call s:h("xmlAttrib",           { "fg": s:green })

  " CSS
  call s:h("cssProp",             { "fg": s:yellow })
  call s:h("cssUIAttr",           { "fg": s:yellow })
  call s:h("cssFunctionName",     { "fg": s:aqua })
  call s:h("cssColor",            { "fg": s:purple })
  call s:h("cssPseudoClassId",    { "fg": s:purple })
  call s:h("cssClassName",        { "fg": s:green })
  call s:h("cssValueLength",      { "fg": s:purple })
  call s:h("cssCommonAttr",       { "fg": s:pink })
  call s:h("cssBraces" ,          { "fg": s:white })
  call s:h("cssClassNameDot",     { "fg": s:pink })
  call s:h("cssURL",              { "fg": s:orange, "format": "underline,italic" })

  " LESS
  call s:h("lessVariable",        { "fg": s:green })

  " ruby
  call s:h("rubyInstanceVariable",        {})
  call s:h("rubyGlobalVariable",          {})
  call s:h("rubyClassVariable",           {})
  call s:h("rubyPseudoVariable",          {})
  call s:h("rubyFunction",                { "fg": s:green })
  call s:h("rubyStringDelimiter",         { "fg": s:yellow })
  call s:h("rubyRegexp",                  { "fg": s:yellow })
  call s:h("rubyRegexpDelimiter",         { "fg": s:yellow })
  call s:h("rubySymbol",                  { "fg": s:purple })
  call s:h("rubyEscape",                  { "fg": s:purple })
  call s:h("rubyInclude",                 { "fg": s:pink })
  call s:h("rubyOperator",                { "fg": s:pink })
  call s:h("rubyControl",                 { "fg": s:pink })
  call s:h("rubyClass",                   { "fg": s:pink })
  call s:h("rubyDefine",                  { "fg": s:pink })
  call s:h("rubyException",               { "fg": s:pink })
  call s:h("rubyRailsARAssociationMethod",{ "fg": s:orange })
  call s:h("rubyRailsARMethod",           { "fg": s:orange })
  call s:h("rubyRailsRenderMethod",       { "fg": s:orange })
  call s:h("rubyRailsMethod",             { "fg": s:orange })
  call s:h("rubyConstant",                { "fg": s:aqua })
  call s:h("rubyBlockArgument",           { "fg": s:orange })
  call s:h("rubyBlockParameter",          { "fg": s:orange })

  " eruby
  call s:h("erubyDelimiter",              {})
  call s:h("erubyRailsMethod",            { "fg": s:aqua })

  " c
  call s:h("cLabel",                      { "fg": s:pink })
  call s:h("cStructure",                  { "fg": s:pink })
  call s:h("cStorageClass",               { "fg": s:pink })
  call s:h("cInclude",                    { "fg": s:green })
  call s:h("cDefine",                     { "fg": s:green })

  " Terminal Colors
  " ---------------
  if has('nvim')
    let g:terminal_color_0  = s:black.gui
    let g:terminal_color_1  = s:red.gui
    let g:terminal_color_2  = s:green.gui
    let g:terminal_color_3  = s:yellow.gui
    let g:terminal_color_4  = s:aqua.gui
    let g:terminal_color_5  = s:purple.gui
    let g:terminal_color_6  = s:cyan.gui
    let g:terminal_color_7  = s:white.gui
    let g:terminal_color_8  = s:darkgrey.gui
    let g:terminal_color_9  = s:pink.gui
    let g:terminal_color_10 = s:br_green.gui
    let g:terminal_color_11 = s:br_yellow.gui
    let g:terminal_color_12 = s:br_blue.gui
    let g:terminal_color_13 = s:br_purple.gui
    let g:terminal_color_14 = s:br_cyan.gui
    let g:terminal_color_15 = s:br_white.gui
  else
    let g:terminal_ansi_colors = [
          \ s:black.gui,
          \ s:red.gui,
          \ s:green.gui,
          \ s:yellow.gui,
          \ s:aqua.gui,
          \ s:purple.gui,
          \ s:cyan.gui,
          \ s:white.gui,
          \ s:darkgrey.gui,
          \ s:pink.gui,
          \ s:br_green.gui,
          \ s:br_yellow.gui,
          \ s:br_blue.gui,
          \ s:br_purple.gui,
          \ s:br_cyan.gui,
          \ s:br_white.gui]
  endif
        ''; # }}}
        "work/.keep".text = "";
        ".face".source = cfg.icon;
        "Pictures/${
          cfg.icon.fileName or (builtins.baseNameOf cfg.icon)
        }".source = cfg.icon;
      }; # }}}

      # Home manager options
      extraOptions = {
        home.shellAliases = {
          lc = "${pkgs.colorls}/bin/colorls --sd";
          lcg = "lc --gs";
          lcl = "lc -1";
          lclg = "lc -1 --gs";
          lcu = "${pkgs.colorls}/bin/colorls -U";
          lclu = "${pkgs.colorls}/bin/colorls -U -1";
        };

        programs = { # {{{
          starship = {
            enable = true;
            settings = {
              character = {
                success_symbol = "[➜](bold green)";
                error_symbol = "[✗](bold red) ";
                vicmd_symbol = "[](bold blue) ";
              };
            };
          };

          exa.enable = true;

          git = { # {{{
            enable = true;
            userName = "IntrovertedCoder";
            userEmail = "natrotnic@gmail.com";
          }; # }}}

          fish = { # {{{
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

          vim = { # {{{
            enable = true;

            plugins = [pkgs.vimPlugins.undotree pkgs.vimPlugins.vim-table-mode pkgs.vimPlugins.vim-css-color];

            extraConfig = ''
              let mapleader = " "

              " Comment
              " Comment
                nnoremap <silent><leader>w ^<S-i># <Esc><Esc>h
                nnoremap <silent><leader>s ^xx

              " Tab
                " Tabbing
                  nnoremap <Tab> ^<S-i><Tab><Esc><Esc>l
                  nnoremap <S-Tab> ^2h2x
                " Moving Down
                  nnoremap <silent><leader>; ^<S-i># <Esc><Esc>hj
                  nnoremap <silent><leader>' ^xxj
                " Moving Up
                  nnoremap <silent><leader>[ ^<S-i># <Esc><Esc>hk
                  nnoremap <silent><leader>] ^xxk
                " Settings
                  set softtabstop=2 shiftwidth=2
                  set tabstop=2
                  set expandtab
                  set autoindent
                  let g:indentLine_char_list = ['|', '¦', '┆', '┊']

              " Window
                " Open file under cursor in different window
                  nnoremap <silent><F11> :vertical wincmd f<CR>
                  nnoremap <silent><F12> :wincmd f<CR>
                " Window splitting
                  nnoremap <silent><F3> :wincmd v<CR>
                  nnoremap <silent><F4> :split<CR>
                " Window selection
                  nnoremap <silent><leader>h :wincmd h<CR>
                  nnoremap <silent><leader>j :wincmd j<CR>
                  nnoremap <silent><leader>k :wincmd k<CR>
                  nnoremap <silent><leader>l :wincmd l<CR>
                " Window resizing
                  nnoremap <silent><leader><C-u> :resize -2<CR>
                  nnoremap <silent><leader><C-i> :resize +2<CR>
                  nnoremap <silent><leader><C-y> :vertical resize -2<CR>
                  nnoremap <silent><leader><C-o> :vertical resize +2<CR>

              " Spell check
                nnoremap <silent><leader>c :set spell!<CR>
              " Toggle capitolization
                nnoremap <silent><leader>U v~<esc>
              " Insert line without going into insert mode
                nnoremap <silent><Leader>o o<Esc>
                nnoremap <silent><Leader>O O<Esc>
              " Replace word under cursor over entire file
                nmap <leader>r :%s/\<<C-r><C-w>\>//gI<Left><Left><Left>
              " Word wrapping
                nnoremap <leader>z 80\|F<space>xi<CR><esc>
              " Set paste
                nnoremap <silent><leader>p :set paste!<CR>
              " Move page while centering on new line
                nnoremap <C-d> <C-d>zz
                nnoremap <C-u> <C-u>zz
              " Insert character at cursor pos
                nnoremap <leader>i i <ESC>r
                nnoremap <leader>a a <ESC>r
              " Scrolling
                set scrolloff=5
                set number
                set relativenumber
              " Folding
                nnoremap <leader>= A{{{<CR><CR>}}}<ESC>k
                inoremap <F3> <space>{{{<CR><CR>}}}<ESC>ki
                set foldmethod=marker
                nnoremap <CR> za
              " Searching
                set hlsearch
                nnoremap <leader>q :noh<CR>
              " swp/bak/undo locations
                set undofile
                set directory^=$HOME/.vim/swp//
                set backupdir^=$HOME/.vim/bak//
                set undodir^=$HOME/.vim/undo//
                silent !mkdir ~/.vim/swp/ > /dev/null 2>&1
                silent !mkdir ~/.vim/bak/ > /dev/null 2>&1
                silent !mkdir ~/.vim/undo/ > /dev/null 2>&1
              " Git
                map <silent><Leader>g :call setbufvar(winbufnr(popup_atcursor(systemlist("cd " . shellescape(fnamemodify(resolve(expand('%:p')), ":h")) . " && git log --no-merges -n 1 -L " . shellescape(line("v") . "," . line(".") . ":" . resolve(expand("%:p")))), { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })), "&filetype", "git")<CR>
                nnoremap <silent><leader>t :silent !lg<CR> :redraw!<CR>
                nnoremap <silent><leader>b :silent !git push<CR> :redraw!<CR>
              " Programming Language Support
                " Python
                  augroup pythonStuff
                  " For anything other then WSL use 3.8 or 3.7
                    au BufEnter *.py38 map <F7> <esc>:w\|!python3.8 "%"<CR>
                    au BufEnter *.py37 map <F7> <esc>:w\|!python3.7 "%"<CR>
                    au BufEnter *.py36 map <F7> <esc>:w\|!python3.6 "%"<CR>
                    au BufEnter *.py35 map <F7> <esc>:w\|!python3.5 "%"<CR>
                  " Default python editor
                    au BufEnter *.py map <F7> <esc>:w\|!python3 "%"<CR>
                  augroup END
                " Added space+F7 to open a python idle
                  nnoremap <silent><leader><F7> :silent !python3<CR>
                  augroup filetypePython
                    au BufNewFile,BufRead *.py38 set filetype=python
                    au BufNewFile,BufRead *.py37 set filetype=python
                    au BufNewFile,BufRead *.py36 set filetype=python
                    au BufNewFile,BufRead *.py35 set filetype=python
                  augroup END
                " Java
                  augroup javaStuff
                    func Eatchar(pat)
                      let c = nr2char(getchar(0))
                      return (c =~ a:pat) ? \'\' : c
                    endfunc
                    au BufEnter *.java map <F7> <esc>:w\|!java "%"<CR>
                    autocmd FileType java iabbrev <silent> print System.out.print(<c-r>=Eatchar('\m\s\<bar>/')<cr>
                    autocmd FileType java iabbrev <silent> println System.out.println(<c-r>=Eatchar('\m\s\<bar>/')<cr>
                  augroup END
                " Theming
                  set termguicolors
                  syntax on
                  colorscheme monokai-bold
                  " Statusline
                    set statusline=
                    set statusline+=%#PmenuSel#
                    set statusline+=\ %M
                    set statusline+=\ %r
                    set statusline+=\ %F
                    set statusline+=%= " Right side settings
                    set statusline+=\ %l:%L
                    set statusline+=\ %p%%
                    set laststatus=2  " Enable status line for all files
                  " Color column
                    set colorcolumn=80
                    highlight ColorColumn ctermbg=232
                    highlight ColorColumn guibg=#100F0F
                  " Invisible characters
                    set list listchars=tab:\|\ ,trail:+,eol:$
                " Plugin keybinds
                  " Undotree
                    let g:undotree_WindowLayout=3
                    nnoremap <silent><leader>u :UndotreeToggle<CR> :wincmd h<CR> :vertical resize 86<CR>

                " Random
                  set visualbell
                  set title
                  set linebreak
                " Remove trailing spaces
                  autocmd BufWritePre * :%s/\s\+$//e
                  set cm=blowfish2

                " TODO text highlight
                  highlight 1 ctermbg=1 ctermfg=black
                  highlight 1 guibg=#C7000C
                  call matchadd("1", "{1}")
                  nnoremap <leader>1 i{1} <ESC>

                  highlight 2 ctermbg=1 ctermfg=black
                  highlight 2 guibg=#B20C27
                  call matchadd("2", "{2}")
                  nnoremap <leader>2 i{2} <ESC>

                  highlight 3 ctermbg=125ctermfg=black
                  highlight 3 guibg=#9D1742
                  call matchadd("3", "{3}")
                  nnoremap <leader>3 i{3} <ESC>

                  highlight 4 ctermbg=89 ctermfg=black
                  highlight 4 guibg=#88235D
                  call matchadd("4", "{4}")
                  nnoremap <leader>4 i{4} <ESC>

                  highlight 5 ctermbg=54 ctermfg=black
                  highlight 5 guibg=#732E78
                  call matchadd("5", "{5}")
                  nnoremap <leader>5 i{5} <ESC>

                  highlight 6 ctermbg=60 ctermfg=black
                  highlight 6 guibg=#5F3A93
                  call matchadd("6", "{6}")
                  nnoremap <leader>6 i{6} <ESC>

                  highlight 7 ctermbg=61 ctermfg=black
                  highlight 7 guibg=#4A45AE
                  call matchadd("7", "{7}")
                  nnoremap <leader>7 i{7} <ESC>

                  highlight 8 ctermbg=12 ctermfg=black
                  highlight 8 guibg=#3551C9
                  call matchadd("8", "{8}")
                  nnoremap <leader>8 i{8} <ESC>

                  highlight 9 ctermbg=26 ctermfg=black
                  highlight 9 guibg=#205CE4
                  call matchadd("9", "{9}")
                  nnoremap <leader>9 i{9} <ESC>

                  highlight 0 ctermbg=27 ctermfg=220
                  highlight 0 guibg=#0B68FF
                  call matchadd("0", "{0}")
                  nnoremap <leader>0 i{0} <ESC>
            '';
          }; # }}}

          alacritty = { # {{{
            enable = true;
            settings = {
              colors = {
                # Default colors
                primary = {
                  background = Black;
                  foreground = White;
                };
                # Normal colors
                normal = {
                  black =   Black;
                  red =     Red;
                  green =   Green;
                  yellow =  Yellow;
                  blue =    Blue;
                  magenta = Magenta;
                  cyan =    Cyan;
                  white =   White;
                };
                # Bright colors
                bright = {
                  black =   brightBlack;
                  red =     brightRed;
                  green =   brightGreen;
                  yellow =  brightYellow;
                  blue =    brightBlue;
                  magenta = brightMagenta;
                  cyan =    brightCyan;
                  white =   brightWhite;
                };
                dim = {
                  black =   darkBlack;
                  red =     darkRed;
                  green =   darkGreen;
                  yellow =  darkYellow;
                  blue =    darkBlue;
                  magenta = darkMagenta;
                  cyan =    darkCyan;
                  white =   darkWhite;
                };
              };

              fonts = {
                normal = {
                  family = "${Font}";
                  style =  "Regular";
                };
              };
            };
          }; # }}}

          zoxide = { # {{{
            enable = true;
            enableFishIntegration = true;
          }; # }}}
        }; # }}}

      };
    };
    programs.fish.enable = true;
    users.users.${cfg.name} = {
      shell = pkgs.fish;
    };
  };
}
