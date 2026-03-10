use utils.nu [deep-merge]

alias cat = bat -p
alias grep = ^grep --color=always
alias finder = ^open .

alias dev = cd $"($env.HOME)/Developer"
alias godev = cd $"($env.HOME)/Developer/go"
alias jsdev = cd $"($env.HOME)/Developer/javascript"
alias nuconfig = cd $"($nu.default-config-dir)"

# Merge settings.base.json with optional local.json into settings.json before we start claude
def claude [...args: string] {
    let base_path = ($env.HOME | path join .claude settings.base.json)
    let local_path = ($env.HOME | path join .claude local.json)
    let settings_path = ($env.HOME | path join .claude settings.json)
    let settings = if ($local_path | path exists) {
        open $base_path | deep-merge (open $local_path)
    } else {
        open $base_path
    }

    $settings | save -f $settings_path
    ^claude ...$args
}

let poimandres = {
    background: "#1b1e28"
    foreground: "#e4f0fb"
    muted: "#767c9d"
    primary: "#5de4c7"
    secondary: "#add7ff"
    tertiary: "#f087bd"
    warning: "#fffac2"
    error: "#d0679d"
    border: "#303340"
    hint: "#506477"
    operator: "#89ddff"
    attribute: "#5fb3a1"
    type: "#91b4d5"
    comment: "#a6accd"
    surface: "#252b37"
}

$env.config = {
    show_banner: false
    buffer_editor: "hx"
    highlight_resolved_externals: true
    color_config: {
        separator: $poimandres.border
        row_index: $poimandres.hint
    }
    cursor_shape: {
      emacs: "blink_line"
    }
    history: {
        max_size: 10000
    },
    completions: {
        algorithm: "fuzzy"
    }
    render_right_prompt_on_last_line: true
}

# Load per-machine overrides
const local = if ($"($nu.default-config-dir)/local.nu" | path exists) {
  $"($nu.default-config-dir)/local.nu"
} else {
  null
}
overlay use $local --reload
