local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()
local hyperlink_rules = wezterm.default_hyperlink_rules()

-- For files, matches only absolute paths with/without line numbers (file.txt:123)
--    Does not match binaries (/Users/foo/test:123)
--    To expand this to fit relative paths, use: \\/?\\b([\\w.\\/\\-]*\\w+\\.\\w+)(:\\d+)?\\b
--    Note: absolute paths were chosen for speed (forcing a prepended '/' requires few regex steps)
-- You could also re-write this to match optimistically, then limit with lua, but the
--    downside of that approach is a lot gets underlined but isn't clickable
table.insert(hyperlink_rules, {
    regex = "\\/([\\w.\\/\\-]*\\w+\\.\\w+)(:\\d+)?\\b",
    format = "$0",
})

config = {
    color_scheme = "Catppuccin Mocha",
    font = wezterm.font("JetBrains Mono", { weight = "Medium" }),
    font_size = 15.0,
    window_background_opacity = 0.97,
    macos_window_background_blur = 5,
    window_padding = {
        left = 20,
        right = 20,
        top = 55,
        bottom = 10,
    },

    -- Catppuccin Colors
    window_frame = {
        font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" }),
        font_size = 13.0,
        active_titlebar_bg = "#1E1E2E",
        inactive_titlebar_bg = "#1E1E2E",
    },
    colors = {
        tab_bar = {
            active_tab = {
                bg_color = "#1E1E2E",
                fg_color = "#CDD6F4",
            },
            inactive_tab = {
                bg_color = "313244",
                fg_color = "#BAC2DE",
            },
            new_tab = {
                bg_color = "313244",
                fg_color = "#BAC2DE",
            },
            new_tab_hover = {
                bg_color = "#1E1E2E",
                fg_color = "#CDD6F4",
            },
        },
    },

    keys = {
        -- Close the current pane instead of window if a pane is open
        { key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = false }) },

        -- Remove the alt / ctrl+shift select printing random characters
        { key = "UpArrow", mods = "ALT", action = act.Nop },
        { key = "DownArrow", mods = "ALT", action = act.Nop },
        { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = act.Nop },
    	  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.Nop },

		    -- Word traversal with alt arrows
        { key = "LeftArrow", mods = "ALT", action = wezterm.action.SendKey({ key = "b", mods = "ALT" }) },
        { key = "RightArrow", mods = "ALT", action = wezterm.action.SendKey({ key = "f", mods = "ALT" }) },
    },

    window_decorations = "INTEGRATED_BUTTONS | RESIZE",
    window_close_confirmation = "NeverPrompt",
    audible_bell = "Disabled",
    adjust_window_size_when_changing_font_size = false,
    automatically_reload_config = true,
    hyperlink_rules = hyperlink_rules,
    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
}

function get_if_valid_file(input_uri)
    local function strip_colon(filename)
        local colon_pos = filename:find(":")
        if colon_pos then
            return filename:sub(1, colon_pos - 1)
        else
            return filename
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
    -- Check for the matched absolute file path
    if file_exists(input_uri) then
        return input_uri
    end
end

-- Check for filenames too
wezterm.on("open-uri", function(window, pane, uri)
    local filename = get_if_valid_file(uri)
    if filename then
        os.execute("code --goto " .. filename)
        -- Return false to prevent opening in a browser (later handlers do this on open-uri)
        return false
    end
end)

return config
