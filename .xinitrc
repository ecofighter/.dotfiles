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
eval "$(dbus-launch --sh-syntax --exit-with-session)"
ibus-daemon -xrd
xmodmap ~/.Xmodmap
#xmodmap -e 'keycode 255 = space'; xmodmap -e 'keycode 65 = Shift_L'; xcape -e '#65=space' 
exec bspwm
