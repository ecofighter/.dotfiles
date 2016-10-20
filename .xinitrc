[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xrandr --dpi 144
export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE="fcitx"
export GTK_IM_MODULE="fcitx"
urxvtd -q -o -f
exec xmonad
xmodmap ~/.Xmodmap
