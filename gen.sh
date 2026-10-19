#!/usr/bin/env bash
# ASHEN — generate waybar/kitty/hyprlock colour files from theme/ashen.lua.
# To change the palette, edit theme/ashen.lua, then run this.
# Output is written into colors/; include the file you need from your own config.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$DIR/colors"
lua5.4 -e "
package.path = '$DIR/?.lua;' .. package.path
local g = require('theme.generate')
for name, path in pairs({
  waybar   = '$DIR/colors/waybar-colors.css',
  kitty    = '$DIR/colors/kitty-colors.conf',
  hyprlock = '$DIR/colors/hyprlock-colors.conf',
}) do
  local r = { g[name](path) }
  print((r[1] and '  ok   ' or '  FAIL ') .. name)
end
"
echo 'colors/ updated.'
