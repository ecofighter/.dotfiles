typeset -U path PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.roswell/bin:$PATH"
export PATH="$HOME/.zplug/bin:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
export EDITOR=/bin/vim
export PAGER=/bin/less
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export DOTNET_ROOT="/opt/dotnet"
if [[ -v WAYLAND_DISPLAY ]]; then
    export GDK_BACKEND=wayland
fi
# export LD_LIBRARY_PATH="/opt/cuda/lib64"

. /home/haneta/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
. /home/haneta/.ghcup/env > /dev/null 2> /dev/null || true
. "$HOME/.cargo/env" > /dev/null 2> /dev/null || true

path=(
    # allow directories only (-/)
    # reject world-writable directories (^W)
    ${^path}(N-/^W)
)

if command -v gpgconf &> /dev/null; then
    export SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)
    dbus-update-activation-environment --systemd SSH_AUTH_SOCK
fi
