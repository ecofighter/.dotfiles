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

bindkey "^I" menu-complete   # 展開する前に補完候補を出させる(Ctrl-iで補完するようにする)

setopt correct
unsetopt promptcr
setopt pushd_ignore_dups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
zstyle ':completion:*:default' menu select=1
alias vi="nvim"
alias luajitlatex="luajittex --fmt=luajitlatex.fmt"
alias ls="exa"
alias la='exa -la --git'
alias ll="exa -l --git"
ORGHOME="$HOME/org/home.org"
function emg() {
    case $1 in
        '') {pgrep emacsclient > /dev/null} && echo "already running emacsclient" \
                    || {nohup emacsclient -a "" -c $ORGHOME 2>&1 > /dev/null &};;
        *) {pgrep emacsclient > /dev/null} && echo "already running emacscilent" \
                   || {nohup emacsclient -a "" -c $* 2>&1 > /dev/null &};;
    esac
}
function emc() {
    case $1 in
        '') {pgrep emacsclient > /dev/null} && echo "already running emacsclient" \
                    || emacsclient -a "" $ORGHOME ;;
        *) {pgrep emacsclient > /dev/null} && echo "already running emacscilent" \
                   || emacsclient -a "" $* ;;
    esac
}
function ediff() {
    emacs --eval "(ediff-files \""$1"\" \""$2"\")"
}
alias ekill="emacsclient -e '(kill-emacs)'"
alias em="emg"
alias nem="emacs -nw"
alias nemg="emacs"
function play() {
    mpv $* > /dev/null 2>&1 &; disown;
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

export TMOUT=30
function TRAPALRM() {
    zle .reset-prompt
}

export PREV_COMMAND_END_TIME
export NEXT_COMMAND_BGN_TIME

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
add-zsh-hook precmd vcs_info

function check_last_exit_code() {
    local LAST_EXIT_CODE=$?
    if [[ $LAST_EXIT_CODE -ne 0 ]]; then
        local EXIT_CODE_PROMPT=''
        EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
        EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
        EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
        EXIT_CODE_PROMPT+=" "
        echo "$EXIT_CODE_PROMPT"
    fi
}

function command_time_pre() {
    timer=${timer:-$SECONDS}
}

function command_time_post() {
    if [ $timer ]; then
        timer_show=$(($SECONDS - $timer))
        export RPROMPT="%F{cyan}${timer_show}s %{$reset_color%}"
        unset timer
    fi
}
add-zsh-hook preexec command_time_pre
add-zsh-hook precmd command_time_post

PROMPT="
%F{yellow}[%~]%f"'${vcs_info_msg_0_}'"%F{magenta}[%*]%f
"'$(check_last_exit_code)'"%F{blue}$%f "

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
zplug "jhawthorn/fzy", \
      as:command, \
      rename-to:fzy, \
      hook-build:"make"
zplug "b4b4r07/enhancd", use:init.sh
zplug "Vifon/deer", use:deer

if zplug check b4b4r07/enhancd; then
    export ENHANCD_FILTER=fzy:fzf
fi

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

if zplug check Vifon/deer; then
    autoload -U deer
    function deer-redraw() {
        deer
        zle redisplay
    }
    zle -N deer-redraw
fi

function __fzycmd() {
    echo "fzy"
}

# CTRL-R - Paste the selected command from history into the command line
function fzy-history-widget() {
    local selected num
    selected=( $(fc -r -l 1 | $(__fzycmd) -l 20 -q "${LBUFFER//$/\\$}") )
    if [ -n "$selected" ]; then
        num=$selected[1]
        if [ -n "$num" ]; then
            zle vi-fetch-history -n $num
        fi
    fi
    zle redisplay
}
zle -N fzy-history-widget

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
bindkey -M viins '^R' fzy-history-widget
bindkey -M viins -s '^[r' 'ranger\n'

# eval "$(fasd --init auto)"
eval "$(stack --bash-completion-script stack)"
