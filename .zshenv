typeset -U path PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.roswell/bin:$PATH"
export PATH="$HOME/.zplug/bin:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"
export EDITOR=/bin/vim
export PAGER=/bin/less
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export DOTNET_ROOT="/opt/dotnet"
# export LD_LIBRARY_PATH="/opt/cuda/lib64"

# OPAM configuration
. /home/haneta/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

. /home/haneta/.ghcup/env
path=(
    # allow directories only (-/)
    # reject world-writable directories (^W)
    ${^path}(N-/^W)
)
