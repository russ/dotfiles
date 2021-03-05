#!/usr/bin/env python3

from dbus.mainloop.glib import DBusGMainLoop
DBusGMainLoop(set_as_default=True)

import gi
gi.require_version('Playerctl', '2.0')
from gi.repository import Playerctl, GLib

import os
import sys
import time
import argparse
import lyricsgenius
import ueberzug.lib.v0 as ueberzug
import curses
import urllib.request
from subprocess import Popen
from mpris2 import Player
from mpris2 import get_players_uri


# Get for free on https://genius.com/
LYRICS_GENIUS_TOKEN = "HUsQPJlWfpxLRqxEfHzMQ6R3diXJ5NTO1KwM_OOUOELTcbDC58-GccQ9mPHJVLbS"


def on_track_change_art(_, data, *args):
    url = str(data["Metadata"]["mpris:artUrl"])
    path =  "/tmp/foo.png"
    download(url, path)


def on_track_change_lyrics(_, data, *args):
    clear()
    print(get_lyrics(str(data["Metadata"]["xesam:artist"][0]),
                     str(data["Metadata"]["xesam:title"])))


def download(url, path):
    urllib.request.urlretrieve(url, path)


def render_art_layer():
    clear()
    path =  "/tmp/foo.png"  # @TODO nothing is playing image
    with ueberzug.Canvas() as c:
        # @FIXME We can't crop
        demo = c.create_placement('demo', x=8, y=1.5, width=40, height=20, scaler=ueberzug.ScalerOption.CROP.value)
        demo.path = path
        demo.visibility = ueberzug.Visibility.VISIBLE
        while True:
            demo.path = path
            time.sleep(1)


def get_lyrics(artist, song):
    genius = lyricsgenius.Genius(LYRICS_GENIUS_TOKEN)
    genius.verbose = False
    song = genius.search_song(song, artist)
    return song.lyrics



def get_parser():
    parser = argparse.ArgumentParser(description="Spotify dbus listener")
    parser.add_argument("--lyrics", action="store_true", help="Print lyrics")
    parser.add_argument("--art", action="store_true", help="Display album art")
    return parser


def clear():
    os.system("clear")


def main():
    args = get_parser().parse_args()

    uri = list(get_players_uri())[1]
    player = Player(dbus_interface_info={'dbus_uri': uri})

    if args.lyrics:
        player.PropertiesChanged = on_track_change_lyrics
    elif args.art:
        from multiprocessing import Process, Manager
        p = Process(target=render_art_layer, args=())
        p.start()
        player.PropertiesChanged = on_track_change_art
    else:
        sys.stderr.write("Specify what you want to display. See --help\n")
        sys.exit(1)

    mloop = GLib.MainLoop()
    mloop.run()


if __name__ == "__main__":
    main()
