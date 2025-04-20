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

alias vim = nvim
alias cat = bat -p
alias dev = cd $env.DEV
alias godev = cd $"($env.DEV)/go/src"

$env.config = {
    show_banner: false
    buffer_editor: "nvim"
    highlight_resolved_externals: true
    color_config: {
        separator: $poimandres.border
        row_index: $poimandres.hint
    }
    history: {
        max_size: 10000
    }
}
