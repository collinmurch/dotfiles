local wezterm = require 'wezterm'
local act = wezterm.action
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
	
	window_padding = {
		left = 30,
		right = 30,
		top = 10,
		bottom = 10,
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

	keys = {
		-- Close the current pane instead of window if a pane is open
		{ key = 'w', mods = 'CMD', action = act.CloseCurrentPane { confirm = false }},

		-- Remove the shift select printing random characters
		{ key = 'LeftArrow', mods = 'SHIFT', action = act.Nop },
		{ key = 'RightArrow', mods = 'SHIFT', action = act.Nop },
		{ key = 'UpArrow', mods = 'SHIFT', action = act.Nop },
		{ key = 'DownArrow', mods = 'SHIFT', action = act.Nop },
	},

	hyperlink_rules = {
    -- URL with a protocol
    {
      regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
      format = "$0",
    },

    -- implicit mailto link
    {
        regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
        format = "mailto:$0",
    },

    -- new in nightly builds; automatically highly file:// URIs.
    {
        regex = "\\bfile://\\S*\\b",
        format = "$0"
    },

    -- [likely] filename regex
    {
      regex = "/\\b\\S*\\b",
      format = "$EDITOR:$0"
    }
  },

	window_decorations = 'INTEGRATED_BUTTONS | RESIZE',
	window_close_confirmation = 'NeverPrompt',
	audible_bell = 'Disabled',
	adjust_window_size_when_changing_font_size = false,
	automatically_reload_config = true,
}

function editable(filename)
  -- "foo.bar" -> ".bar"
  local extension = filename:match("^.+(%..+)$")
  if extension then
    -- ".bar" -> "bar"
    extension = extension:sub(2)
    wezterm.log_info(string.format("extension is [%s]", extension))
    local binary_extensions = {
      jpg = true,
      jpeg = true,
      -- and so on
    }
    if binary_extensions[extension] then
      -- can't edit binary files
      return false
    end
  end

  -- if there is no, or an unknown, extension, then assume
  -- that our trusty editor will do something reasonable
  return true
end

function extract_filename(uri)
  local start, match_end = uri:find("$EDITOR:");
  if start == 1 then
    -- skip past the colon
    return uri:sub(match_end+1)
  end

  -- `file://hostname/path/to/file`
  local start, match_end = uri:find("file:");
  if start == 1 then
    -- skip "file://", -> `hostname/path/to/file`
    local host_and_path = uri:sub(match_end+3)
    local start, match_end = host_and_path:find("/")
    if start then
      -- -> `/path/to/file`
      return host_and_path:sub(match_end)
    end
  end

  return nil
end

wezterm.on("open-uri", function(window, pane, uri)
  local name = extract_filename(uri)
  if name and editable(name) then
    local action = act{
		SpawnCommandInNewTab={args={'code', '--goto', name}}
	};

    window:perform_action(action, pane);

    -- prevents the default action from opening in a browser
    return false
  end
end)

return config
