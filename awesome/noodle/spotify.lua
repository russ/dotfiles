-------------------------------------------------
-- Spotify Widget for Awesome Window Manager
-- Shows currently playing song on Spotify for Linux client
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/spotify-widget

-- @author Pavel Makhov
-- @copyright 2018 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")

local GET_SPOTIFY_STATUS_CMD = 'sp status'
local GET_CURRENT_SONG_CMD = 'sp current-oneline'
local PATH_TO_ICONS = "/usr/share/icons/Arc"

local spotify_widget = wibox.widget {
    {
        id = 'current_song',
        widget = wibox.widget.textbox,
        font = 'Play 9',
        align = 'center',
        valign = 'center'
    },
    layout = wibox.layout.align.horizontal,
    set_text = function(self, path)
        self.current_song.markup = path
    end,
}

local update_widget_text = function(widget, stdout, _, _, _)
    if string.find(stdout, 'Error: Spotify is not running.') ~= nil then
        widget:set_text('')
        widget:set_visible(false)
    else
        widget:set_text(stdout:gsub("^%s*(.-)%s*$", "%1"))
        widget:set_visible(true)
    end
end

watch(GET_CURRENT_SONG_CMD, 1, update_widget_text, spotify_widget)

return spotify_widget
