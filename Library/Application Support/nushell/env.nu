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
