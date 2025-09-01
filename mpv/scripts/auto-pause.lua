-- pause-on-blur.lua
local mp = require 'mp'
local options = require 'mp.options'

-- user options (set with --script-opts=pause-on-blur/<opt>=<val>)
local o = {
    resume_on_focus = true,   -- auto-resume when mpv regains focus
    osd_enable      = true,   -- show OSD messages
    osd_duration    = 1.5,    -- seconds for OSD messages
    osd_prefix      = "Auto ",-- prefix for messages (e.g. "Auto paused")
}
options.read_options(o, "pause-on-blur")

local auto_paused = false

local function osd(msg)
    if o.osd_enable and msg and msg ~= "" then
        mp.osd_message(msg, tonumber(o.osd_duration) or 1.5)
    end
end

mp.observe_property("focused", "bool", function(_, focused)
    if focused == false then
        -- on blur: pause only if currently playing
        local is_paused = mp.get_property_native("pause")
        if not is_paused then
            mp.set_property_bool("pause", true)
            auto_paused = true
            osd(o.osd_prefix .. "paused")
        else
            auto_paused = false
        end
    else
        -- on focus: resume only if we previously auto-paused and option enabled
        if auto_paused and o.resume_on_focus then
            mp.set_property_bool("pause", false)
            osd(o.osd_prefix .. "resumed")
        end
        auto_paused = false
    end
end)
