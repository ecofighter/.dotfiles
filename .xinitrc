[[ -f ~/.Xresources ]]  && xrdb -merge ~/.Xresources
[ -f /etc/xprofile  ] && source /etc/profile
[ -f ~/.xprofile ] && source ~/.xprofile
eval "$(dbus-launch --sh-syntax --exit-with-session)"
export DefaultIMModule=fcitx
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XKB_DEFAULT_LAYOUT=jp
export XDG_RUNTIME_DIR=/home/haneta/.xdg
fcitx-autostart
xmodmap ~/.Xmodmap
compton -b --config ~/.config/compton/compton.conf
exec awesome
