use std/util "path add"

$env.DEV = $"($env.HOME)/Developer"

load-env {
    "BAT_THEME": "Poimandres"
    "EDITOR": "zed --wait"
    "LS_COLORS": $'$([
        "di=38;2;141;221;255",    # directory
        "ln=38;2;145;180;213",    # symbolic link
        "ex=38;2;240;135;189",    # executable
        "fi=38;2;228;240;251",    # regular file
        "pi=38;2;145;180;213",    # named pipe
        "so=38;2;145;180;213",    # socket
        "bd=38;2;208;103;157",    # block device
        "cd=38;2;208;103;157",    # character device
        "or=38;2;208;103;157",    # orphan (broken) symlink
        "mi=38;2;208;103;157",    # missing file
        "su=38;2;255;250;194",    # setuid
        "sg=38;2;255;250;194",    # setgid
        "tw=38;2;255;250;194",    # sticky + other-writable directory
        "ow=38;2;255;250;194",    # other-writable directory
        "st=38;2;255;250;194",    # sticky directory
        "ca=38;2;255;250;194"     # file with capability
    ] | str join ":")'

    "GOPATH": $"($env.HOME)/go"
    "PYTHONPATH": $"($env.DEV)/python"
}

path add "/usr/local/bin"
path add "/nix/var/nix/profiles/default/bin"
path add "/opt/homebrew/bin" # eventually we'll get rid of this in favor of pure nix

path add $"($env.HOME)/.nix-profile/bin"
path add $"($env.DEV)/scripts"
path add $"($env.HOME)/.cache/lm-studio/bin"
path add $"($env.HOME)/.local/bin"

path add $"($env.GOPATH)/bin"
path add $"($nu.home-path)/.cargo/bin"

# Add prompts
source ($nu.default-config-dir | path join "prompt.nu")
$env.PROMPT_COMMAND = {|| $"(ansi blue_bold)(dir-prompt)(ansi reset)" }
$env.PROMPT_COMMAND_RIGHT = {|| vcs-prompt }
$env.PROMPT_INDICATOR = {||
    if $env.LAST_EXIT_CODE == 0 {
        $" (ansi green_bold)❯(ansi reset) "
    } else {
        $" (ansi red_bold)❯(ansi reset) "
    }
}
