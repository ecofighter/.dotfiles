[[ -f ~/.Xresources ]]  && xrdb -merge ~/.Xresources
[ -f /etc/xprofile  ] && source /etc/profile
[ -f ~/.xprofile ] && source ~/.xprofile
eval "$(dbus-launch --sh-syntax --exit-with-session)"
# exec i3
