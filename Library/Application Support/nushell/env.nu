$env.DEV = "($env.HOME)/Developer"

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

$env.PATH = ($env.PATH | append [
  "/usr/local/bin",
  "/nix/var/nix/profiles/default/bin",
  "/opt/homebrew/bin", # eventually we'll get rid of this in favor of pure nix

  $"($env.HOME)/.nix-profile/bin",
  $"($env.DEV)/scripts",
  $"($env.HOME)/.cache/lm-studio/bin",
  $"($env.HOME)/.local/bin",

  $"($env.GOPATH)/bin",
])
