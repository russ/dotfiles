local theme_collection = {
    "skyfall",      -- 3 --
}

-- Change this number to use a different theme
local theme_name = theme_collection[1]

----------------------------------------------

local bar_theme_collection = {
    "skyfall",      -- 3 -- Weather, taglist, window buttons, pop-up tray
}

-- Change this number to use a different bar theme
local bar_theme_name = bar_theme_collection[1]

--------------------------------------------------------------------------------

local beautiful = require("beautiful")
local theme_dir = os.getenv("HOME") .. "/.config/awesome/themes/"
beautiful.init(theme_dir .. theme_name .. "/theme.lua")
local xresources = require("beautiful.xresources")

local lain = require("lain")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Default notification library
local naughty = require("naughty")
local menubar = require("menubar")

local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")








-- Basic (required)
local helpers = require("helpers")
local keys = require("keys")
local titlebars = require("titlebars")

-- Extra features
local bars = require("bar_themes."..bar_theme_name)
local exit_screen = require("noodle.text_exit_screen")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
        title = "Oops, an error happened!",
        text = tostring(err) })
        in_error = false
    end)
end
-- }}}




-- {{{ Variable definitions
terminal = "kitty"
-- Some terminals do not respect spawn callbacks
floating_terminal = "kitty --class fst" -- clients with class "fst" are set to be floating (check awful.rules below)
browser = "google-chrome"
tmux = terminal .. " -e tmux new "
editor = "vim"
editor_cmd = terminal.." -e "..editor.." "

-- Get screen geometry
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    -- I only ever use these 3
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.max,
    lain.layout.centerwork,
    lain.layout.cascade,
    lain.layout.termfair,
}

awful.screen.connect_for_each_screen(function(s)
    awful.spawn.with_shell(os.getenv("HOME") .. "/.fehbg")
end)

-- Load notification daemons and notification theme
local notifications = require("notifications")

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    -- Tag layouts
    local l = awful.layout.suit -- Alias to save time :)
    -- local layouts = { l.max, l.floating, l.max, l.max , l.tile,
    --     l.max, l.max, l.max, l.floating, l.tile}
    local layouts = { l.tile, l.tile, l.tile, l.tile , l.tile, l.tile, l.tile, l.tile, l.tile, l.tile}

    -- Tag names
    local tagnames = beautiful.tagnames or { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }

    -- Create tags
    awful.tag.add(tagnames[1], {
        layout = layouts[1],
        screen = s,
        selected = true,
        mwfact = 0.75,
    })
    awful.tag.add(tagnames[2], {
        layout = layouts[2],
        screen = s,
    })
    awful.tag.add(tagnames[3], {
        layout = layouts[3],
        screen = s,
    })
    awful.tag.add(tagnames[4], {
        layout = layouts[4],
        screen = s,
    })
    awful.tag.add(tagnames[5], {
        layout = layouts[5],
        screen = s,
    })
    awful.tag.add(tagnames[6], {
        layout = layouts[6],
        screen = s,
    })
    awful.tag.add(tagnames[7], {
        layout = layouts[7],
        screen = s,
    })
    awful.tag.add(tagnames[8], {
        layout = layouts[8],
        screen = s,
    })
    awful.tag.add(tagnames[9], {
        layout = layouts[9],
        screen = s,
    })
    awful.tag.add(tagnames[10], {
        layout = layouts[10],
        screen = s,
    })
end)

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
        properties = { border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys.clientkeys,
            buttons = keys.clientbuttons,
            screen = awful.screen.preferred,
            size_hints_honor = false,
            honor_workarea = true,
            honor_padding = true,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen }
        },

    -- Add titlebars to normal clients and dialogs
    { rule_any = { type = { "normal", "dialog" }
        }, properties = { titlebars_enabled = true },
    },

    -- Floating clients
    { rule_any = {
        role = {
            "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        },
        type = {
            "dialog",
        },
	name = {
            "Picture in picture"
	}
    }, properties = { floating = true, ontop = false }},

    -- media dock
    { rule_any = {
        class = {
            "electronplayer",
            "projectM",
            "mpv",
            "firefox",
        },
    }, properties = {
      floating = true,
      above = false,
      ontop = false,
      focusable = false,
      sticky = true,
    }, callback = function( c )
      local w_area = screen[ c.screen ].workarea
      local winwidth = 550
      c:struts( { left = winwidth } )
      c:geometry( { x = 0, y = 0, width = winwidth, height = (screen_height / 2) - 200 } )
    end
    },

    -- orgmode dock
    { rule = {
        name = "org",
        instance = "emacs",
    }, properties = {
      floating = true,
      above = false,
      ontop = false,
      focusable = false,
      sticky = true,
    }, callback = function( c )
      local w_area = screen[ c.screen ].workarea
      local winwidth = 550
      c:struts( { left = winwidth } )
      c:geometry( { x = 0, y = 340, width = winwidth, height = 705 } )
      -- c:geometry( { x = 0, y = 0, width = winwidth, height = 1045 } )
    end
    },

    -- Titlebars ON (explicitly)
    -- Titlebars of these clients will be shown regardless of the theme setting
    { rule_any = {
        class = {
            --"???",
        },
        type = {
            "dialog",
        },
        role = {
            "conversation",
        }
    }, properties = {},
    callback = function (c)
        awful.titlebar.show(c)
    end
    },

    {
      rule_any = {
        instance = {
          "slack",
          "telegram-desktop",
        }
      },
      properties = { screen = 1, tag = awful.screen.focused().tags[2] }
    },

    {
      rule_any = {
        instance = {
          "blueman-manager",
          "synergy",
        }
      },
      properties = { screen = 1, tag = awful.screen.focused().tags[9] }
    },

    {
      rule_any = {
        instance = {
          "spotify",
        }
      },
      properties = { screen = 1, tag = awful.screen.focused().tags[10] }
    },
}

-- Startup applications
awful.spawn.with_shell( os.getenv("HOME") .. "/.config/awesome/autostart.sh")



