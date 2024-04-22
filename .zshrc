fpath+=~/.zfunc
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

setopt print_eight_bit  #日本語ファイル名等8ビットを通す
setopt extended_glob  # 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
setopt globdots # 明確なドットの指定なしで.から始まるファイルをマッチ

setopt correct
unsetopt promptcr
setopt pushd_ignore_dups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
zstyle ':completion:*:default' menu select interactive
setopt menu_complete
alias vi="nvim"
#alias luajitlatex="luajittex --fmt=luajitlatex.fmt"
#alias ls="exa"
#alias la='exa -la --git'
#alias ll="exa -l --git"
#alias ffmpeg="ffmpeg -hide_banner"
#alias ffprobe="ffprobe -hide_banner"
#alias zathura='GDK_BACKEND=wayland zathura'
export ORGHOME="$HOME/org/home.org"
if command -v emacsclient &> /dev/null; then
    export EDITOR="emacsclient"
else
    export EDITOR="vi"
fi
export PAGER=less
function mpvv() {

    nohup mpv $* < /dev/null &> /dev/null & disown
}
function cmpv() {
    nohup mpv $(xsel -ob) < /dev/null &> /dev/null & disown
}
function emg() {
    nohup emacsclient -a "" -c $* > /dev/null > /dev/null 2>&1 & disown
}
function emc() {
    emacsclient -a "" $*
}
function ediff() {
    emacs --eval "(ediff-files \""$1"\" \""$2"\")"
}
function ekill() {
    emacsclient -e '(client-save-kill-emacs)' || killall emacsclient
}
alias em="emg"
alias nem="emacs -nw"
alias nemg="emacs"
function play() {
    mpv $* < /dev/null > /dev/null 2>&1 &; disown;
}

#colors
dark0_hard="#1D2021"
dark0="#282828"
dark0_soft="#32302F"
dark1="#3c3836"
dark2="#504945"
dark3="#665c54"
dark4="#7C6F64"

gray_245="#928374"
gray_244="#928374"

light0_hard="#FB4934"
light0="#FBF1C7"
light0_soft="#F2E5BC"
light1="#EBDBB2"
light2="#D5C4A1"
light3="#BDAE93"
light4="#A89984"

bright_red="#FB4934"
bright_green="#B8BB26"
bright_yellow="#FABD2F"
bright_blue="#83A598"
bright_purple="#D3869B"
bright_aqua="#8EC07C"
bright_orange="#FE8019"

neutral_red="#CC241D"
neutral_green="#98971A"
neutral_yellow="#D79921"
neutral_blue="#458588"
neutral_purple="#B16286"
neutral_aqua="#689D6A"
neutral_orange="#D65D0E"

faded_red="#9D0006"
faded_green="#79740E"
faded_yellow="#B57614"
faded_blue="#076678"
faded_purple="#8F3F71"
faded_aqua="#427B58"
faded_orange="#AF3A03"

# Plugin Configuration
if [[ ! -d ~/.zplug ]];then
    git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "tarruda/zsh-autosuggestions", use:"zsh-autosuggestions.zsh"
# zplug "clvv/fasd", as:command, use:fasd
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

bindkey -v
bindkey -M viins '\er' history-incremental-pattern-search-forward
bindkey -M viins '^?'  backward-delete-char
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^B'  backward-char
bindkey -M viins '^D'  delete-char-or-list
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^F'  forward-char
bindkey -M viins '^G'  send-break
bindkey -M viins '^H'  backward-delete-char
bindkey -M viins '^K'  kill-line
bindkey -M viins '^N'  down-line-or-history
bindkey -M viins '^P'  up-line-or-history
# bindkey -M viins '^R'  history-incremental-pattern-search-backward
bindkey -M viins '^U'  backward-kill-line
bindkey -M viins '^W'  backward-kill-word
bindkey -M viins '^Y'  yank

bindkey -M viins '^[d' deer-redraw
bindkey -M viins -s '^[r' 'source ranger\n'

if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)"
fi
if command -v yazi &> /dev/null; then
    function yy() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    }
fi
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi
