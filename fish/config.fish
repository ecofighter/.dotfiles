set -g theme_color_scheme zenburn
set -g theme_display_vi yes
set -g theme_avoid_ambiguousglyphs yes
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts no
set -g theme_project_dir_length 2
set -U FZF_LEGACY_KEYBINDINGS 0
fish_vi_key_bindings

set -g dark0_hard "#1D2021"
set -g dark0 "#282828"
set -g dark0_soft "#32302F"
set -g dark1 "#3c3836"
set -g dark2 "#504945"
set -g dark3 "#665c54"
set -g dark4 "#7C6F64"

set -g gray_245 "#928374"
set -g gray_244 "#928374"

set -g light0_hard "#FB4934"
set -g light0 "#FBF1C7"
set -g light0_soft "#F2E5BC"
set -g light1 "#EBDBB2"
set -g light2 "#D5C4A1"
set -g light3 "#BDAE93"
set -g light4 "#A89984"

set -g bright_red "#FB4934"
set -g bright_green "#B8BB26"
set -g bright_yellow "#FABD2F"
set -g bright_blue "#83A598"
set -g bright_purple "#D3869B"
set -g bright_aqua "#8EC07C"
set -g bright_orange "#FE8019"

set -g neutral_red "#CC241D"
set -g neutral_green "#98971A"
set -g neutral_yellow "#D79921"
set -g neutral_blue "#458588"
set -g neutral_purple "#B16286"
set -g neutral_aqua "#689D6A"
set -g neutral_orange "#D65D0E"

set -g faded_red "#9D0006"
set -g faded_green "#79740E"
set -g faded_yellow "#B57614"
set -g faded_blue "#076678"
set -g faded_purple "#8F3F71"
set -g faded_aqua "#427B58"
set -g faded_orange "#AF3A03"

# OPAM configuration
source /home/haneta/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true
