# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Put your fun stuff here.
export GOPATH="$HOME/.go"
export PATH="$HOME/.roswell/bin:$HOME/.cargo/bin:$HOME/.local/bin:$GOPATH/bin:$PATH"
export RUST_SRC_PATH="$HOME/.rust_src/src"
export TERM=xterm-256color
export COLORTERM=24bit
export XDG_CONFIG_HOME=$HOME/.config
export PGDATA=/var/lib/postgresql/9.5/data

if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

if [[ $- = *i*  ]]; then
   exec fish
fi
