local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()
local hyperlink_rules = wezterm.default_hyperlink_rules()

config = {
    color_scheme = "Poimandres",
    font = wezterm.font("JetBrains Mono", { weight = "Medium" }),
    font_size = 15.0,
    default_cursor_style = 'BlinkingBar',
    window_background_opacity = 0.97,
    macos_window_background_blur = 5,
    window_padding = {
        left = 20,
        right = 20,
        top = 55,
        bottom = 10,
    },

    keys = {
        -- Moving around panes
        { key = "h",          mods = "SHIFT|ALT",      action = act.ActivatePaneDirection "Left" },
        { key = "j",          mods = "SHIFT|ALT",      action = act.ActivatePaneDirection "Down" },
        { key = "k",          mods = "SHIFT|ALT",      action = act.ActivatePaneDirection "Up" },
        { key = "l",          mods = "SHIFT|ALT",      action = act.ActivatePaneDirection "Right" },

        -- Adjusting pane sizes
        { key = "h",          mods = "CTRL|SHIFT|ALT", action = act.AdjustPaneSize { "Left", 1 } },
        { key = "j",          mods = "CTRL|SHIFT|ALT", action = act.AdjustPaneSize { "Down", 1 } },
        { key = "k",          mods = "CTRL|SHIFT|ALT", action = act.AdjustPaneSize { "Up", 1 } },
        { key = "l",          mods = "CTRL|SHIFT|ALT", action = act.AdjustPaneSize { "Right", 1 } },

        -- New Panes
        { key = "\"",         mods = 'SHIFT|ALT|CTRL', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
        { key = ":",          mods = 'SHIFT|ALT|CTRL', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },

        -- Close the current pane instead of window if a pane is open
        { key = "w",          mods = "CMD",            action = act.CloseCurrentPane({ confirm = false }) },


        -- Remove the alt / ctrl+shift select printing unix keycodes
        { key = "UpArrow",    mods = "ALT",            action = act.Nop },
        { key = "DownArrow",  mods = "ALT",            action = act.Nop },
        { key = 'LeftArrow',  mods = 'CTRL|SHIFT',     action = act.Nop },
        { key = 'RightArrow', mods = 'CTRL|SHIFT',     action = act.Nop },

        -- Word traversal with alt arrows
        { key = "LeftArrow",  mods = "ALT",            action = wezterm.action.SendKey({ key = "b", mods = "ALT" }) },
        { key = "RightArrow", mods = "ALT",            action = wezterm.action.SendKey({ key = "f", mods = "ALT" }) },

        -- Rename current tab
        {
            key = 'e',
            mods = 'CMD',
            action = act.PromptInputLine {
                description = 'Enter new name for tab',
                action = wezterm.action_callback(function(window, pane, line)
                    if line then
                        window:active_tab():set_title(line)
                    end
                end),
            },
        },

        { key = 'D', mods = 'SHIFT|ALT', action = act.ShowDebugOverlay },
    },

    window_decorations = "RESIZE | MACOS_FORCE_ENABLE_SHADOW | INTEGRATED_BUTTONS",
    tab_max_width = 24,
    window_close_confirmation = "NeverPrompt",
    audible_bell = "Disabled",
    adjust_window_size_when_changing_font_size = false,
    automatically_reload_config = true,
    hyperlink_rules = hyperlink_rules,
    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
}

return config
