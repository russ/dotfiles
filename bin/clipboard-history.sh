#!/usr/bin/env bash

rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}' -theme ~/.config/rofi/themes/appsmenu.rasi
sleep 0.5
# xdotool type "$(xclip -o -selection clipboard)"
