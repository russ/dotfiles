#!/bin/bash

# Take a screenshot of an area of the screen, upload it to dropbox and put the url into the clipboard

# Put file in any directory under your dropbox
# If it is subfolder, than you need to make them manually
FILENAME=~/Dropbox/Screenshots/Screenshot_`date +%Y-%m-%d-%H:%M`.png

# Select an area and save the screenshot
# you need to instal gnome-screenshot
# on ubuntu: sudo apt install gnome-screenshot
maim -o -u -m 3 -s $FILENAME

# You need to install dropbox on your linux system and log in
URL=`dropbox-cli sharelink $FILENAME`

# you need to install xclip on your system to get link to clipboard
# on ubunut: sudo apt install xclip
echo $URL | xclip -selection clipboard

# Pop up a small notification
# You need to install notify-osd (at least on gnome-shell)
# on ubuntu-gnome: sudo apt install notify-osd
notify-send "Copied $URL to clipboard"
