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
bindkey -M viins '^R'  history-incremental-pattern-search-backward
bindkey -M viins '^U'  backward-kill-line
bindkey -M viins '^W'  backward-kill-word
bindkey -M viins '^Y'  yank

autoload -U compinit; compinit
autoload -U colors
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
function em() {
  emacs $* &; disown;
}
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

export TMOUT=30
function TRAPALRM() {
  zle .reset-prompt
}

export PREV_COMMAND_END_TIME
export NEXT_COMMAND_BGN_TIME

function show_command_end_time() {
  PREV_COMMAND_END_TIME=`date "+%H:%M:%S"`
  RPROMPT="${PREV_COMMAND_END_TIME} -         "
}
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
add-zsh-hook precmd show_command_end_time
add-zsh-hook precmd vcs_info

show_command_begin_time() {
  NEXT_COMMAND_BGN_TIME=`date "+%H:%M:%S"`
  RPROMPT="${PREV_COMMAND_END_TIME} - ${NEXT_COMMAND_BGN_TIME}"
  zle .accept-line
  zle .reset-prompt
}
zle -N accept-line show_command_begin_time

PROMPT="
%F{yellow}[%~]%f"'${vcs_info_msg_0_}'"%F{magenta}[%*]%f
%F{blue}$%f "

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
zplug "jhawthorn/fzy", \
    as:command, \
    rename-to:fzy, \
    hook-build:"make"
zplug "b4b4r07/enhancd", use:init.sh

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
