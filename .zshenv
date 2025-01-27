# typeset -U path PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.roswell/bin:$PATH"
export PATH="$HOME/.zplug/bin:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"
export PATH="$HOME/.elan/bin:$PATH"
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
export PATH="/opt/emacs/bin:$PATH"
export EDITOR=/bin/vim
export PAGER=/bin/less
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
# export DOTNET_ROOT="/opt/dotnet"
if [[ -v WAYLAND_DISPLAY ]]; then
    export GDK_BACKEND=wayland
fi
# export LD_LIBRARY_PATH="/opt/cuda/lib64"

# opam configuration

[[ ! -r /home/haneta/.opam/opam-init/init.zsh ]] || source /home/haneta/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
. /home/haneta/.ghcup/env > /dev/null 2> /dev/null || true
. "$HOME/.cargo/env" > /dev/null 2> /dev/null || true

# path=(
#     # allow directories only (-/)
#     # reject world-writable directories (^W)
#     ${^path}(N-/^W)
# )

# if grep -qi WSL2 /proc/version; then
#     export SSH_AUTH_SOCK=$HOME/.ssh-agent.sock
#     ss -a | grep -q $SSH_AUTH_SOCK
#     if [ $? -ne 0 ]; then
#         rm -f $SSH_AUTH_SOCK
#         (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
#     fi
# else
#     if command -v gpgconf &> /dev/null; then
#         export SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)
#         dbus-update-activation-environment --systemd SSH_AUTH_SOCK
#     fi
# fi

if command -v gpgconf &> /dev/null; then
    export SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)
    # dbus-update-activation-environment --systemd SSH_AUTH_SOCK
fi
