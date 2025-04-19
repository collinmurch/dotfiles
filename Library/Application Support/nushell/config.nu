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

let poimandres_theme = {
    separator: $poimandres.border
#     leading_trailing_space_bg: $poimandres.muted
#     header: $poimandres.foreground
#     date: $poimandres.tertiary_accent
#     filesize: $poimandres.secondary_accent
    row_index: $poimandres.hint
#     bool: $poimandres.error
#     int: $poimandres.accent
#     duration: $poimandres.warning
#     range: $poimandres.warning
#     float: $poimandres.accent
#     string: $poimandres.accent
#     nothing: $poimandres.muted
#     binary: $poimandres.muted
#     cellpath: $poimandres.hint
#     hints: $poimandres.hint
#     shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b }
#     shape_bool: $poimandres.error
#     shape_int: { fg: $poimandres.accent attr: b }
#     shape_float: { fg: $poimandres.accent attr: b }
#     shape_range: { fg: $poimandres.warning attr: b }
#     shape_internalcall: { fg: $poimandres.secondary_accent attr: b }
#     shape_external: $poimandres.secondary_accent
#     shape_externalarg: { fg: $poimandres.accent attr: b }
#     shape_literal: $poimandres.accent
#     shape_operator: $poimandres.secondary_accent
#     shape_signature: { fg: $poimandres.accent attr: b }
#     shape_string: { fg: $poimandres.accent attr: b }
#     shape_filepath: $poimandres.secondary_accent
#     shape_globpattern: { fg: $poimandres.secondary_accent attr: b }
#     shape_variable: $poimandres.foreground
#     shape_flag: { fg: $poimandres.secondary_accent attr: b }
#     shape_custom: { fg: $poimandres.accent attr: b }
}

alias vim = nvim
alias cat = bat -p
alias dev = cd $env.DEV
alias godev = cd $"($env.DEV)/go/src"

$env.config = {
    show_banner: false
    buffer_editor: "nvim"
    highlight_resolved_externals: true
    color_config: $poimandres_theme
    history: {
        max_size: 10000
    }
}
