alias vim = nvim
alias cat = bat -p
alias dev = cd $env.DEV
alias godev = cd $"($env.DEV)/go/src"

$env.config = {
    show_banner: false
    buffer_editor: 'nvim'
    highlight_resolved_externals: true
}

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
