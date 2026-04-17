use utils.nu [deep-merge]

# Launch codex with merged base + local config
export def --wrapped codex [...args: string] {
    let base_path = ($env.HOME | path join .codex config.base.toml)
    let config_path = ($env.HOME | path join .codex config.toml)
    let current = if ($config_path | path exists) {
        open $config_path
    } else {
        {}
    }
    open $base_path | deep-merge $current | save -f $config_path

    ^codex ...$args
}

# Launch claude with merged base + local settings
export def --wrapped claude [...args: string] {
    let base_path = ($env.HOME | path join .claude settings.base.json)
    let settings_path = ($env.HOME | path join .claude settings.json)
    let current = if ($settings_path | path exists) {
        open $settings_path
    } else {
        {}
    }
    open $base_path | deep-merge $current | save -f $settings_path

    ^claude ...$args
}
