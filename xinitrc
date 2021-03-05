export TERM=screen-256color
export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11 

dbus-update-activation-environment --all
picom -b
emacs --daemon &

exec awesome
