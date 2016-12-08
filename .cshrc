# csh-config will set your search path and other system dependent
# variables.  It will be changed as necessary when the system is
# reconfigured.  Please do not modify or remove these two lines.

if ( -r /usr/local/etc/csh-config ) source /usr/local/etc/csh-config

# the remainder of this file may be modified to customize your account

set filec
set history = 50

umask 027

# limit core file size
limit coredumpsize 0

setenv	EDITOR  emacs
setenv	VISUAL	emacs
setenv	TEXEDIT	emacs

# Allow jobs that finish to send a message (Done) asynchronously
set notify

# Aliases allow you to type shortcut versions of commands
alias   e       emacs

# if you want to add directories to your search path, add them before
# the "." in the line below.  For example,
#
# set path = ( $path ~ ~/bin ~/scripts . )

set path = ( $path . )

# to be automatically logged out after 30min of inactivity:
# set autologout=(30)
unset autologout

if ($?prompt) set prompt="% "
