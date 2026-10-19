-- ASHEN — the single source of truth.
-- To change a colour or a measurement, edit ONLY this file, then run
-- `./gen.sh` (propagates to waybar + kitty + hyprlock).

local M = {}

-- Ash & ember. A warm black base, one ember accent.
M.hex = {
  base    = "0E0D0C", -- background (warm, not bluish)
  surface = "171614",
  overlay = "211F1C",
  line    = "2E2B27", -- separator / inactive border
  muted   = "6B645C",
  subtle  = "8E867C",
  text    = "C9C2B8", -- ash
  bright  = "E8E2D8",
  accent  = "E08A4B", -- EMBER — used sparingly
  accent2 = "B8683A", -- dim ember (gradient end)
  ok      = "8A9A6B",
  warn    = "D9A441",
  urgent  = "C2554A",
}

-- Hyprland rgba() form. a = 0..1
function M.rgba(name, a)
  local h = M.hex[name] or name
  local alpha = math.floor((a or 1) * 255 + 0.5)
  if alpha < 0 then alpha = 0 elseif alpha > 255 then alpha = 255 end
  return string.format("rgba(%s%02x)", h, alpha)
end

function M.rgb(name)
  return "rgb(" .. (M.hex[name] or name) .. ")"
end

-- #RRGGBB for CSS / kitty
function M.css(name)
  return "#" .. (M.hex[name] or name)
end

M.font = {
  ui   = "JetBrainsMono Nerd Font",
  mono = "JetBrainsMono Nerd Font Mono",
  size = 11,
}

M.shape = {
  rounding = 12,
  power    = 2.4,  -- >2 = near-square "squircle", looks pricier
  border   = 2,
  gap_in   = 6,
  -- Equal gap on all four sides.
  -- Don't add extra padding on top: waybar (layer-shell) already reserves its
  -- own space (margin 8 + height 31 = 39px). Adding 46 here stacks with that
  -- and made the bar-to-window gap 48px — four times the 12px sides, visibly
  -- out of proportion.
  gap_out  = { top = 12, right = 12, bottom = 12, left = 12 },
}

-- Tuned for a weak iGPU (AMD Vega 8). Raising these costs frames.
M.fx = {
  blur_size    = 5,
  blur_passes  = 2,
  blur_noise   = 0.015,
  shadow_range = 16,
  inactive_opacity = 0.93,
  dim_strength = 0.06,
}

return M
