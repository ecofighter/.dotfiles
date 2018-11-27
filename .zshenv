typeset -U path PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.roswell/bin:$PATH"
export PATH="$HOME/.zplug/bin:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"
export EDITOR=/bin/nvim
export PAGER=/bin/less
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export DOTNET_ROOT="/opt/dotnet"
export LD_LIBRARY_PATH="/opt/cuda/lib64"
# pacaur, yaourt, makepkg: use powerpill instead of pacman
# pacman -Q powerpill >& /dev/null && export PACMAN=/usr/bin/powerpill

# pacmatic: use pacaur instead of pacman
# s/pacaur/yaourt/g if desired
# pacman -Q pacaur >& /dev/null && export pacman_program=/usr/bin/pacaur

# pacaur must not be run as root, but pacdiff must be
# alias pacmatic='pacdiff_program="sudo pacdiff" pacmatic'

# OPAM configuration
. /home/haneta/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

path=(
    # allow directories only (-/)
    # reject world-writable directories (^W)
    ${^path}(N-/^W)
)
