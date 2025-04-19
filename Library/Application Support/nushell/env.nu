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
$env.LS_COLORS = "di=38;2;141;221;255:ln=38;2;145;180;213:ex=38;2;240;135;189:fi=38;2;228;240;251:pi=38;2;145;180;213:so=38;2;145;180;213:bd=38;2;208;103;157:cd=38;2;208;103;157:or=38;2;208;103;157:mi=38;2;208;103;157:su=38;2;255;250;194:sg=38;2;255;250;194:tw=38;2;255;250;194:ow=38;2;255;250;194:st=38;2;255;250;194:ca=38;2;255;250;194"
