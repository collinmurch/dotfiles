local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config = {
	color_scheme = 'Catppuccin Mocha',
	
	font = wezterm.font(
		'JetBrains Mono',
		{weight = 'Medium'}
	),
	font_size = 15.0,
	window_background_opacity = 0.97,
	macos_window_background_blur = 5,
	
	hyperlink_rules = wezterm.default_hyperlink_rules(),

	window_padding = {
		left = 25,
		right = 10,
		top = 60,
		bottom = 15,
	},
	-- https://github.com/catppuccin/zed/blob/main/themes/catppuccin-mauve.json
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
	-- Close the current pane instead of window if a pane is open
	keys = {
		{
    		key = 'w',
    		mods = 'CMD',
    		action = wezterm.action.CloseCurrentPane { confirm = false },
  		},
	},
	window_decorations = 'INTEGRATED_BUTTONS | RESIZE',
	window_close_confirmation = 'NeverPrompt',
	adjust_window_size_when_changing_font_size = false,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	hide_tab_bar_if_only_one_tab = true,
	automatically_reload_config = true,
}
return config
