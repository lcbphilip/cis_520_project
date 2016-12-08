# sh-config will set your search path and other system dependent
# variables.  It will be changed as necessary when the system is
# reconfigured.  Please do not modify or remove these two lines.

if [ -r /usr/local/etc/sh-config ]
then
  . /usr/local/etc/sh-config
fi

# limit core file size
ulimit -S -c 0

EDITOR=emacs
VISUAL=emacs
TEXEDIT=emacs

PSPRINTER=lw1

umask 027

#
# What sort of terminal am I using
#
defaultterm=vt100
if [ -r /pkg/bin/termsetup.sh ]; then
  . /pkg/bin/termsetup.sh
fi

if [ -x /usr/ucb/stty ]; then
  /usr/ucb/stty erase \^?
elif [ -x /usr/bin/stty ]; then
  stty erase \^?
fi

# if you want to add directories to your search path, add them before
# the "." on the line below.  For example,
#
#  PATH=$PATH:$HOME:$HOME/bin:$HOME/scripts:.

PATH=$PATH:.

#
# Put all this into the environment (polluters that we are!)
#
export PATH EDITOR VISUAL TEXEDIT PSPRINTER

