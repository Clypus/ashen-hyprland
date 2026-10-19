-- Propagates the theme to other apps. Writes ONLY colour-variable files;
-- your real style files are hand-written and never touched here.
-- Run by hand (gen.sh), not at startup — writing files inside the reload
-- budget is needless risk.
local T = require("theme.ashen")

local M = {}

local function write(path, body)
  local f, err = io.open(path, "w")
  if not f then return false, err end
  f:write(body)
  f:close()
  return true
end

local BASLIK = "/* ASHEN — auto-generated, do not edit by hand.\n"
  .. "   Source: theme/ashen.lua -> gen.sh */\n\n"

function M.waybar(path)
  local order = { "base","surface","overlay","line","muted","subtle",
                  "text","bright","accent","accent2","ok","warn","urgent" }
  local out = { BASLIK }
  for _, k in ipairs(order) do
    out[#out + 1] = string.format("@define-color %s %s;\n", k, T.css(k))
  end
  return write(path, table.concat(out))
end

function M.kitty(path)
  local h = T.hex
  local body = "# ASHEN — auto-generated, do not edit by hand.\n"
    .. "# Source: theme/ashen.lua -> gen.sh\n\n"
    .. string.format("background            #%s\n", h.base)
    .. string.format("foreground            #%s\n", h.text)
    .. string.format("cursor                #%s\n", h.accent)
    .. string.format("cursor_text_color     #%s\n", h.base)
    .. string.format("selection_background  #%s\n", h.overlay)
    .. string.format("selection_foreground  #%s\n", h.bright)
    .. string.format("url_color             #%s\n", h.accent)
    .. string.format("active_border_color   #%s\n", h.accent)
    .. string.format("inactive_border_color #%s\n", h.line)
    .. string.format("active_tab_background   #%s\n", h.overlay)
    .. string.format("active_tab_foreground   #%s\n", h.bright)
    .. string.format("inactive_tab_background #%s\n", h.surface)
    .. string.format("inactive_tab_foreground #%s\n", h.muted)
    .. "\n# 16 colors — ash base, ember accent\n"
    .. string.format("color0  #%s\ncolor8  #%s\n", h.overlay, h.muted)
    .. string.format("color1  #%s\ncolor9  #%s\n", h.urgent,  "D97A6E")
    .. string.format("color2  #%s\ncolor10 #%s\n", h.ok,      "A4B584")
    .. string.format("color3  #%s\ncolor11 #%s\n", h.warn,    "E8BC63")
    .. string.format("color4  #%s\ncolor12 #%s\n", "7E8CA0",  "9AA7BA")
    .. string.format("color5  #%s\ncolor13 #%s\n", "A08099",  "BA9AB2")
    .. string.format("color6  #%s\ncolor14 #%s\n", "7FA8A0",  "9CC0B8")
    .. string.format("color7  #%s\ncolor15 #%s\n", h.text,    h.bright)
  return write(path, body)
end

function M.hyprlock(path)
  local body = "# ASHEN — auto-generated, do not edit by hand.\n"
    .. "# Source: theme/ashen.lua -> gen.sh\n\n"
    .. string.format("$base   = rgb(%s)\n", T.hex.base)
    .. string.format("$text   = rgb(%s)\n", T.hex.text)
    .. string.format("$muted  = rgb(%s)\n", T.hex.muted)
    .. string.format("$accent = rgb(%s)\n", T.hex.accent)
    .. string.format("$urgent = rgb(%s)\n", T.hex.urgent)
  return write(path, body)
end

-- Convenience: write straight into a typical ~/.config layout.
-- (gen.sh in this repo writes into ./colors/ instead, leaving your config alone.)
function M.all(home)
  local r = {}
  r.waybar   = { M.waybar(home   .. "/.config/waybar/colors.css") }
  r.kitty    = { M.kitty(home    .. "/.config/kitty/colors.conf") }
  r.hyprlock = { M.hyprlock(home .. "/.config/hypr/hyprlock/colors.conf") }
  return r
end

return M
