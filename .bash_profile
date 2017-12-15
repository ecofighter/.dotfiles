# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
export GOPATH="$HOME/.go"
export PATH="$HOME/.gem/ruby/2.2.0/bin:$HOME/.roswell/bin:$HOME/.cargo/bin:$HOME/.local/bin:$GOPATH/bin:$PATH"
# export RUST_SRC_PATH="$HOME/.rust_src/src"
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export JULIA_HOME="/home/haneta/Projects/repos/julia/usr/bin"
export TERM=xterm-256color
export COLORTERM=24bit
export XDG_CONFIG_HOME=$HOME/.config
export PGDATA=/var/lib/postgresql/9.5/data
if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi


# OPAM configuration
. /home/haneta/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
