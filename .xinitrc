[[ -f ~/.Xresources ]]  && xrdb -merge ~/.Xresources
[ -f /etc/xprofile  ] && source /etc/profile
[ -f ~/.xprofile ] && source ~/.xprofile
feh --bg-scale ~/picture/wallpaper/wallpaper_yama.jpg &
albert &
exec xmonad
