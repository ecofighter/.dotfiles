[[ -f ~/.Xresources ]]  && xrdb -merge ~/.Xresources
[ -f /etc/xprofile  ] && source /etc/profile
[ -f ~/.xprofile ] && source ~/.xprofile
exec xmonad
