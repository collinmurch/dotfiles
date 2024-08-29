local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()
local hyperlink_rules = wezterm.default_hyperlink_rules()

-- For files, matches stuff like 'foo.bar:123' and '/Users/you/example.html'
-- Another option would to match things much more optimistically then limit 
-- what we 'link' in editable(), but generally regex is faster
table.insert(hyperlink_rules, {
  regex = "\\/?\\b([\\w.\\/\\-]*\\w+\\.\\w+)(:\\d+)?\\b",
  format = "$0"
})

config = {
	color_scheme = 'Catppuccin Mocha',
	
	font = wezterm.font(
		'JetBrains Mono',
		{weight = 'Medium'}
	),
	font_size = 15.0,
	window_background_opacity = 0.97,
	macos_window_background_blur = 5,
	
	window_padding = {
		left = 30,
		right = 30,
		top = 10,
		bottom = 10,
	},

  -- Catppuccin Colors
	window_frame = {
		font = wezterm.font { family = 'JetBrains Mono', weight = 'Bold'},
		font_size = 13.0,
		active_titlebar_bg = '#1E1E2E',
		inactive_titlebar_bg = '#1E1E2E',
	},
	colors = {
		tab_bar = {
			active_tab = {
				bg_color = '#1E1E2E',
				fg_color = '#CDD6F4',
			},
			inactive_tab = {
				bg_color = '313244',
				fg_color = '#BAC2DE',
			},
			new_tab = {
				bg_color = '313244',
				fg_color = '#BAC2DE',
			},
			new_tab_hover = {
				bg_color = '#1E1E2E',
				fg_color = '#CDD6F4',
			},
		},
	},

	keys = {
		-- Close the current pane instead of window if a pane is open
		{ key = 'w', mods = 'CMD', action = act.CloseCurrentPane { confirm = false }},

		-- Remove the shift select printing random characters
		{ key = 'LeftArrow', mods = 'SHIFT', action = act.Nop },
		{ key = 'RightArrow', mods = 'SHIFT', action = act.Nop },
		{ key = 'UpArrow', mods = 'SHIFT', action = act.Nop },
		{ key = 'DownArrow', mods = 'SHIFT', action = act.Nop },
	},

	window_decorations = 'INTEGRATED_BUTTONS | RESIZE',
	window_close_confirmation = 'NeverPrompt',
	audible_bell = 'Disabled',
	adjust_window_size_when_changing_font_size = false,
	automatically_reload_config = true,
  hyperlink_rules = hyperlink_rules,
}

function get_if_valid_file(pane, uri)
  local function strip_colon(name)
    local colon_pos = name:find(":")
    if colon_pos then
      return name:sub(1, colon_pos - 1)
    else
      return name
    end
  end

  local function file_exists(filename)
    local f = io.open(strip_colon(filename), "r")
    if f ~= nil then
      f:close()
      return true
    else
      return false
    end
  end

  -- check for the matched absolute file path
  if file_exists(uri) then
    return uri
  end

  -- also check for matched relative and local files
  local prepended_uri = pane:get_current_working_dir().file_path ..'/' .. uri
  if file_exists(prepended_uri) then
    return prepended_uri
  end
end

wezterm.on("open-uri", function(window, pane, uri)
  local filename = get_if_valid_file(pane, uri)

  if filename then
    window:perform_action(act.SpawnCommandInNewTab{args={'code', '--goto', filename}}, pane);

    -- return false to prevent opening in a browser (later handlers do this on open-uri)
    return false 
  end
end)

return config
