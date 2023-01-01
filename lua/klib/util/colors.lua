local hsluv = require('klib.util.hsluv')

local colors = {}

---Get normalised colour
---@param name string like 'pink' or '#fa8072'
---@return string[]
local get_color = function(name)
	local color = vim.api.nvim_get_color_by_name(name)
	if color == -1 then
		color = vim.opt.background:get() == 'dark' and 000 or 255255255
	end

	---Convert colour to hex
	---@param value integer
	---@param offset integer
	---@return integer
	local byte = function(value, offset)
		return bit.band(bit.rshift(value, offset), 0xFF)
	end

	return { byte(color, 16), byte(color, 8), byte(color, 0) }
end

---Get visually transparent colour
---@param fg string like 'pink' or '#fa8072'
---@param bg string like 'pink' or '#fa8072'
---@param alpha float number between 0 and 1
---@return string
colors.blend = function(fg, bg, alpha)
	local bg_color = get_color(bg)
	local fg_color = get_color(fg)

	---@param i integer
	---@return integer
	local channel = function(i)
		local ret = (alpha * fg_color[i] + ((1 - alpha) * bg_color[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format('#%02X%02X%02X', channel(1), channel(2), channel(3))
end

colors.darken = function(color, amount, bg)
  return colors.blend(color, bg or '#000000', math.abs(amount))
end

colors.lighten = function(color, amount, bg)
  return colors.blend(color, bg or '#FFFFFF', math.abs(amount))
end

colors.brighten = function(color, amount)
  local rgb = get_color(color)
  local hsl = hsluv.rgb_to_hsluv(rgb)

  local larp_space = 100 - hsl[3]
  if amount < 0 then
    larp_space = hsl[3]
  end

  hsl[3] = hsl[3] + larp_space * amount

  return hsluv.hsluv_to_hex(hsl)
end

---@class Color
---@field bg string
---@field fg string
---@field link string

colors.get_fg = function(name, fallback)
	local id = vim.api.nvim_get_hl_id_by_name(name)
	if not id then
		return fallback
	end

	local foreground = vim.fn.synIDattr(id, 'fg')
	if not foreground or foreground == '' then
		return fallback
	end

	return foreground
end

colors.get_bg = function(name, fallback)
	local id = vim.api.nvim_get_hl_id_by_name(name)
	if not id then
		return fallback
	end

	local background = vim.fn.synIDattr(id, 'bg')
	if not background or background == '' then
		return fallback
	end

	return background
end

---Replace terminal keycodes
---@param key string like '<esc>'
---@return string
colors.replace_termcodes = function(key)
	return vim.api.nvim_replace_termcodes(key, true, true, true)
end

return colors
