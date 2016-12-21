[[ -f ~/.Xresources ]]  && xrdb -merge ~/.Xresources
[ -f /etc/xprofile  ] && source /etc/profile
[ -f ~/.xprofile ] && source ~/.xprofile
feh --bg-scale ~/picture/wallpaper/10YearsCompilingPurple.jpg &
exec xmonad
