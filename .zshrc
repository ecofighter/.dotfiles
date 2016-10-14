autoload -U compinit
compinit
setopt auto_cd
setopt auto_pushd
setopt correct
setopt list_packed
setopt nolistbeep
PROMPT="%n@%m %% "
RPROMPT="[%d]"

export XDG_CONFIG_HOME=~/.config
export TERM=rxvt-unicode-256color
bindkey -v
PATH="$PATH":$HOME/.cargo/bin
export RUST_SRC_PATH="/usr/src/rustc-1.12.0/src"
