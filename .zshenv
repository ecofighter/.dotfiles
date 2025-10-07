if [[ "$(uname)" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$(uname)" == "Linux" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

typeset -U PATH path
typeset -U INFOPATH infopath
typeset -T INFOPATH infopath
typeset -U MANPATH manpath
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"
export EDITOR=/bin/vim
export PAGER=/bin/less
if command -v rustc >/dev/null; then
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi
if [[ -v WAYLAND_DISPLAY ]]; then
    export GDK_BACKEND=wayland
fi

if command -v opam &>/dev/null; then
    eval $(opam env)
fi
[[ ! -r "$HOME/.ghcup/env" ]] || source "$HOME/.ghcup/env" > /dev/null 2> /dev/null
[[ ! -r "$HOME/.cargo/env" ]] || source "$HOME/.cargo/env" > /dev/null 2> /dev/null
[[ ! -r "$HOME/.elan/env" ]] || source "$HOME/.elan/env" > /dev/null 2> /dev/null

export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null; then
    eval "$(pyenv init - zsh)"
fi

path=(
    # allow directories only (-/)
    # reject world-writable directories (^W)
    ${^path}(N-/^W)
)

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

if [[ "$(uname)" == "Linux" ]]; then
    if command -v gpgconf &> /dev/null; then
        export SSH_AUTH_SOCK=$(gpgconf --list-dir agent-ssh-socket)
        # dbus-update-activation-environment --systemd SSH_AUTH_SOCK
    fi
fi



