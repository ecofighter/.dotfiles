[[ -f ~/.Xresources ]]  && xrdb -merge ~/.Xresources
[ -f /etc/xprofile  ] && source /etc/profile
[ -f ~/.xprofile ] && source ~/.xprofile
eval "$(dbus-launch --sh-syntax --exit-with-session)"
export DefaultIMModule=ibus
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XKB_DEFAULT_LAYOUT=jp
export XDG_RUNTIME_DIR=/run/user/1000
export XDG_CONFIG_DIR=~/.config
xmodmap ~/.Xmodmap
ibus-daemon -d -r --xim
exec awesome
