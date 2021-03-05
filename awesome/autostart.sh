#!/usr/bin/env bash
# ---
# Use "run program" to run it only if it is not already running
# Use "program &" to run it regardless
# ---
# NOTE: This script runs with every restart of AwesomeWM

function run {
    if ! pgrep $1 > /dev/null ;
    then
        $@&
    fi
}

run nm-applet
run synergy
run start-pulseaudio-x11
run blueman-applet
run blueman-manager
run dropbox
run greenclip daemon
run spotify
run slack
run telegram-desktop
