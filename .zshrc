if command -v sheldon &>/dev/null; then
    eval "$(sheldon source)"
fi
# fpath+=~/.zfunc
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
autoload -U colors
autoload -Uz zmv
alias zmv='noglob zmv'
setopt nobeep
setopt auto_cd
setopt auto_pushd
setopt auto_param_slash
setopt mark_dirs
setopt list_types
setopt auto_menu
setopt auto_param_keys
setopt magic_equal_subst

setopt print_eight_bit #日本語ファイル名等8ビットを通す
setopt extended_glob   # 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
setopt globdots        # 明確なドットの指定なしで.から始まるファイルをマッチ

setopt correct
unsetopt promptcr
setopt pushd_ignore_dups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
export SAVEHIST=10000
zstyle ':completion:*:default' menu select interactive
setopt menu_complete
if command -v vim >/dev/null; then
    export EDITOR="vim"
elif command -v nvim > /dev/null; then
    export EDITOR="nvim"
fi
export PAGER=less

export ORGHOME="$HOME/org/home.org"
function emg {
    nohup emacs "$@" >/dev/null >/dev/null 2>&1 &
    disown
}
function emc {
    emacs -nw "$@"
}
function ediff {
    emacs --eval "(ediff-files \"$1\" \"$2\")"
}
function ekill {
    emacsclient -e '(client-save-kill-emacs)' || killall emacsclient
}
alias em="emg"
alias nem="emacs -nw"
alias nemg="emacs"

bindkey -v
# bindkey -M viins '\er' history-incremental-pattern-search-forward
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^B' backward-char
bindkey -M viins '^D' delete-char-or-list
bindkey -M viins '^E' end-of-line
bindkey -M viins '^F' forward-char
bindkey -M viins '^G' send-break
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^K' kill-line
bindkey -M viins '^N' down-line-or-history
bindkey -M viins '^P' up-line-or-history
# bindkey -M viins '^R'  history-incremental-pattern-search-backward
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^Y' yank

if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi
if command -v yazi &>/dev/null; then
    function yy {
        local tmp
        tmp="$(mktemp -t "yazi-cwd.XXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            cd -- "$cwd" || return
        fi
        rm -f -- "$tmp"
    }
fi
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
    alias zz=__zoxide_zi
fi
if command -v eza &>/dev/null; then
    alias ls="eza"
    alias tree="eza -T"
fi
if command -v batcat &>/dev/null; then
    alias bat=batcat
fi
if [[ -x "$HOME/.claude/local/claude" ]]; then
    alias claude="~/.claude/local/claude"
fi
