{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.icat;
in
{
  options.plusultra.apps.home.icat = with types; {
    enable = mkBoolOpt false "Whether or not to enable icat.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ icat ];
    plusultra.home.extraOptions.home.packages = with pkgs; [ imagemagick ];
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "icat" ''
#!/run/current-system/sw/bin/bash

# sixcat: Use sixel graphics to show an image inside a terminal.
# sixgif: Use sixel graphics to play an animation inside a terminal.

# Version 1.0
# hackerb9, June 2017

# Sixel graphics are supported by terminals such as the DEC VT340 and
# emulators, such as 'xterm -ti vt340'.

# ImageMagick is required. (apt-get install imagemagick)

# The heart of this program is really just one line:
#
#   convert foo.jpg sixel:-
#
# All the other lines are bells and whistles, mostly to make the image
# look better by increasing the number of colors available.


######################################################################
# Configuration
######################################################################

# Number of colors in the terminal's sixel palette.
# (But also see the -x and -n options).
default_numcolors=16	    # Genuine vt340's had a 16-color palette.

# Maximum image size is terminal dependent, so we have to guess.
geometry="-geometry 800x480>"		# this was the actual vt340 resolution
#geometry="-geometry 800x800>"		# allows for portrait orientation
#geometry="-geometry 1000x1000>"	# maximum allowed in xterm322

# Should ImageMagick dither the image to make it look better?
# (Use dither="" to disable.)
dither="-dither floyd-steinberg"

# Maximum number of seconds to wait for a response from the terminal
# after a color escape sequence request. Usually, terminals respond
# much faster than 0.1 seconds, but I could imagine it needing to be
# increased for slow links (e.g., RS232C).
timeout=0.1


######################################################################
# Helper functions
######################################################################

usage() {
    cat <<EOF
Usage: $(basename $0) [-x|-X|-n INTEGER] <imagefiles...>

        -x: Force the use of xterm escape sequences to detect and
            change the palette size instead of defaulting to $default_numcolors.
	   If the palette is smaller than 1024, it is set to 1024.

	   Note that -x is the default if \$TERM is "xterm".

        -X: Just assume palette size is $default_numcolors.
	   Does not use xterm escape sequences regardless of \$TERM.

	-n INTEGER:
	   Assume pallete size is INTEGER.
	   Does not use xterm escape sequences regardless of \$TERM.

Note: if this program is called sixgif, it will play GIF animations
in the top left instead of scrolling all the frames as multiple images.

EOF
}


# Some functions to deal with checking and changing the number of
# colors the terminal can show. Likely xterm specific, but YMMV.

getnumcolors() {
    # Query xterm for the palette size and print it.
    # (Negative numbers indicate errors.)
    colors 1 0
}

resetnumcolors() {
    # Reset xterm back to its default number of colors.
    # Print the new number of colors (negative if an error occurred.)
    colors 2 0
}

setnumcolors() {
    # Request xterm to change the number of colors in its palette.
    # Print the new number of colors (negative if an error occurred.)
    colors 3 $1
}

colors() {
    # Send an xterm escape code request in the form: ^[[?1;3;1024S
    # Print the response value (or a negative number if an error occurs)
    csi=$'\e['
    action=$1                 # Action. 1 to get, 2 to reset, 3 to set
    value=$2                  # Number of colors to set
    returnvalue=-1

    # Raw response is in the same form as request: ^[[?1;0;1024S
    # Let's parse it to be more manageable.
    IFS=";" \
       read -a REPLY -s -t $timeout -d "S" \
       	   -p "$\{csi}?1;$\{action};$\{value}S"

    if [[ $? != 0 || $\{REPLY} == 0 ]]; then
	# No response to VT escape sequence. Maybe you are not an xterm?
	# Or, perhaps timeout is too short?
	returnvalue=-2
    elif [[ "$\{REPLY[1]}" == "3" ]]; then
	# Response code 3 means error. Likely too many colors requested.
	returnvalue=-3
    elif [[ "$\{REPLY[1]}" == "0" ]] ; then
	# 0 means okay. Yay!
	returnvalue=$\{REPLY[2]}
    else
     	# If we get here, response was not in the format we expected.
	# Perhaps user typed during xterm response? Or cosmic rays?
	returnvalue=-4
    fi

    echo $returnvalue
}

waitforterminal() {
    # Send an escape sequence and wait for a response from the terminal.
    # This routine will let us know when an image transfer has finished
    # and it's okay to send escape sequences that request results.
    # (E.g., if we want to run resetnumcolors at the end of the program.)
    # WARNING. While this should work with any terminal, if it fails,
    # it'll end up waiting for approximately *forever* (i.e., 60 seconds).
    read -s -t 60 -d "c" -p $'\e[c'
}


debugeta() {
    # Given a number of bytes, estimate the amount of time its going
    # to take to send at the current TTY baud rate.
    # Mostly for larks as this will be completely bogus on terminal emulators.

    len=$1

    # Static variables to store TTY type and STTY speed.
    [[ "$TTY" ]] || TTY=$(tty)
    [[ "$SPEED" ]] || SPEED=$(stty speed) || SPEED=0

    echo "sixel command length is $len bytes"

    if [[ "$SPEED" -gt 0 ]]; then
	if [[ "$TTY" =~ /pt || "$TTY" =~ ttyp ]]; then
	   echo "pseudoterminal detected (speed estimates only valid for real hardware)"
	fi
	echo "terminal speed is $SPEED bps"
	echo "estimated time to send: $((len*8/SPEED)) seconds"
    fi
}


# If the user hits ^C, we don't want them stuck in SIXEL mode
cleanup() {
    echo -n $'\e[?80h'		# Reenable sixel scrolling
    echo -n $'\e\\'		# Escape sequence to stop SIXEL
    exit 0
}
trap cleanup SIGINT SIGHUP SIGABRT


######################################################################
# MAIN BEGINS HERE
######################################################################

if [ $# -eq 0 ]; then
    usage
    exit 1
else
    case "$1" in
	-n|--num-colors) shift
	   nflag="$1"
	   shift
	   # Just assume the palette is n colors. Do not bother checking or changing.
	   # (Might be needed for some terminal emulators. I do not know.)
	   if [[ "$nflag" -gt 0 ]]; then
		default_numcolors=$nflag
	   else
		usage
		exit 1
	   fi
	   ;;
	-x|--force-xterm-colors) shift
	   # Force xterm palette manipulation, regardless of $TERM
	   # (Might be needed for some terminal emulators. I do not know.)
	   xflag=yup
	   ;;
	-X|--disable-xterm-colors) shift
	   # Disable xterm palette manipulation, regardless of $TERM
	   # (Might be needed for some terminal emulators. I do not know.)
	   Xflag=yup
	   ;;
	-*)
	   usage
	   exit 1
	   ;;
    esac
fi



numcolors=$default_numcolors

# Optionally detect and set the number of palette colors
if [[ "$xflag"  ||  -z "$Xflag" && -z "$nflag" && "$TERM" =~ ^xterm ]]; then
    # Since the VT340 only had a palette of 16 colors, we can vastly
    # improve the image if we tell xterm to increase it to 1024.
    # This would fail on a real VT340.
    palettechanged=yup
    oldnumcolors=$(getnumcolors)
    if [[ $oldnumcolors -lt 1024 ]]; then
	numcolors=$(setnumcolors 1024)
	if [[ $numcolors -le 0 ]]; then
	   echo -e "\rTerminal did not accept escape sequence to increase color palette. Are you really an xterm?" >&2
	   numcolors=$default_numcolors
	fi
    else
	# At least 1024 colors, so do not change anything
	numcolors=$oldnumcolors
	palettechanged=
    fi
fi


# Small optimization (saves half a second)
if [[ $numcolors == 1024 ]]; then
    # Imagemagick already defaults to 1024 colors for sixel
    colors=""
else
    colors="-colors $numcolors"
fi


# Print image filename after showing it? Yes, if multiple files.
if [[ $# -gt 1 ]]; then
    showname=yup
else
    showname=""
fi


# PAST IS PROLOGUE... NOW TO THE MEAT.
for f; do
    x=$(convert "$f" $geometry $colors sixel:- 2>/dev/null)
    [[ $\{x} != 0 ]] || continue # The sixel command length better be >0

    : debugeta $\{x}

    case $0 in
	*sixgif)
	   # If this program is named "sixgif" play files as animations,
	   # instead of displaying each frame and scrolling down.
	   echo -n $'\e[?80l'	# Disable sixel scrolling
	   for t in {1..3}; do
		echo -n "$x"	# sixgif plays repeatedly
	   done
	   echo -n $'\e[?80h'	# Reenable sixel scrolling
	   ;;

	*)
	   echo -n "$x"	# sixcat just shows once
	   [[ "$showname" ]] && echo "$f"
	   ;;
    esac
done


# TIDY UP
waitforterminal
if [[ "$palettechanged" ]]; then
    # Reset color palette
    numcolors=$(resetnumcolors)
    : echo Number of colors reset to $numcolors >&2
fi
      '')
    ];
  };
}
