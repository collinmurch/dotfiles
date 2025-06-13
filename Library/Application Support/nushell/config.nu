alias vim = nvim
alias cat = bat -p
alias finder = ^open .

alias dev = cd $"($env.HOME)/Developer"
alias godev = cd $"($env.HOME)/Developer/go/src"
alias nuconfig = cd $"($nu.default-config-dir)"

let poimandres = {
    background: "#1b1e28"
    foreground: "#e4f0fb"
    muted: "#767c9d"
    primary: "#5DE4c7"
    secondary: "#ADD7FF"
    tertiary: "#f087bd"
    warning: "#fffac2"
    error: "#d0679d"
    border: "#303340"
    hint: "#506477"
    operator: "#89ddff"
    attribute: "#5fb3a1"
    type: "#91B4D5"
    comment: "#a6accd"
    surface: "#252b37"
}

$env.config = {
    show_banner: false
    buffer_editor: "nvim"
    highlight_resolved_externals: true
    color_config: {
        separator: $poimandres.border
        row_index: $poimandres.hint
    }
    cursor_shape: {
      emacs: "blink_line"
      vi_insert: "blink_line"
      vi_normal: "blink_block"
    }
    history: {
        max_size: 10000
    },
    completions: {
        algorithm: "fuzzy"
    }
}

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
