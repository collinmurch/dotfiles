$env.HOMEBREW_PREFIX = "/opt/homebrew"
$env.DEV = $"($env.HOME)/Developer"

$env.PATH = ($env.PATH | prepend $"($env.HOMEBREW_PREFIX)/bin")

$env.GOPATH = $"($env.DEV)/go"
$env.GOROOT = $"(do { ^brew --prefix go } | str trim)/libexec"

$env.PATH = ($env.PATH | append [
    $"($env.DEV)/scripts",
    $"($env.GOPATH)/bin"
])

$env.BAT_THEME = "Poimandres"
$env.LS_COLORS = [
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
] | str join ":"

source $"($nu.default-config-dir)/local.nu"
