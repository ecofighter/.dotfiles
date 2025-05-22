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
# if [[ "$(uname)" == "Darwin" ]]; then
#     export PATH="/Applications/Emacs.app/Contents/MacOS/bin:$PATH"
#     export INFOPATH="/Applications/Emacs.app/Contents/Resources/info:$INFOPATH"
#     export MANPATH="/Applications/Emacs.app/Contents/Resources/man:$MANPATH"
# elif [[ "$(uname)" == "Linux" ]]; then
#     export PATH="/opt/emacs/bin:$PATH"
# fi
export EDITOR=/bin/vim
export PAGER=/bin/less
if command -v rustc >/dev/null; then
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi
if [[ -v WAYLAND_DISPLAY ]]; then
    export GDK_BACKEND=wayland
fi

[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh"  > /dev/null 2> /dev/null
. "$HOME/.ghcup/env" > /dev/null 2> /dev/null || true
. "$HOME/.cargo/env" > /dev/null 2> /dev/null || true

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



