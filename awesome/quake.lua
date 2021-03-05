--[[

  Copyright 2018 Stefano Mazzucco <stefano AT curso DOT re>

  This program is free software: you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free Software
  Foundation, either version 3 of the License, or (at your option) any later
  version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

  You should have received a copy of the GNU General Public License along with
  this program.  If not, see <https://www.gnu.org/licenses/gpl-3.0.html>.

]]

-- Supported Awesome Version: 4.x

local awful = require("awful")

local client = client -- luacheck: ignore

local DEFAULT_CLIENT_PROPS = {
  size_hints_honor = false,
  hidden = true,
  maximized = true,
  skip_taskbar = true,
  ontop = true,
  sticky = true,
  focusable = true,
  floating = true,
}

local function _update_props(quake, exclude)
  exclude = exclude or {}
  for k, v in pairs(quake.client_props) do
    if exclude[k] == nil then
      quake.client[k] = v
    end
  end
end

local function init(quake)

  if quake.client and quake.client.valid then

    _update_props(quake)

    if quake.geometry then
      quake.client:geometry(quake.geometry)
    end

    awful.ewmh.add_activate_filter(
      -- Prevent focus stealing when the
      -- client is visible.
      function()
        if quake.client.valid and quake.client:isvisible() then
          return false
        end
        return true
      end
    )

    quake.client:connect_signal(
    "focus",
    function ()
      _update_props(quake, {hidden=true})
    end)

  end
end

local Quake = {}

function Quake:new(o)

  o.client_props = o.client_props or {}

  for k, v in pairs(DEFAULT_CLIENT_PROPS) do
    if o.client_props[k] == nil then
      o.client_props[k] = v
    end
  end

  setmetatable(o, self)
  self.__index = self

  client.connect_signal(
    "manage",
    function (c)
      if c and c.instance == o.name then
        o.client = c
        init(o)
      end
  end)

  return o
end

function Quake:toggle()
  if self.client and self.client.valid then
    client.focus = self.client
    self.client.hidden = not self.client.hidden
  end
end

function Quake:spawn()
  awful.client.run_or_raise(
    self.cmd,
    function(c)
      return c.instance == self.name
    end,
    function (c)
      c.first_tag = awful.screen.focused().selected_tag
    end
  )
  self:toggle()
end

return Quake
