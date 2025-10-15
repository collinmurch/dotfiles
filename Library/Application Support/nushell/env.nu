load-env {
    "BAT_THEME": "Poimandres"
    "GOPATH": $"($env.HOME)/Developer/go"
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

    "ENABLE_BACKGROUND_TASKS": true # for claude code
}

$env.PATH = ($env.PATH | append [
  "/usr/local/bin",
  "/nix/var/nix/profiles/default/bin",
  "/opt/homebrew/bin", # Eventually we'll get rid of this in favor of pure nix

  $"($env.HOME)/.nix-profile/bin",
  $"($env.HOME)/Developer/scripts",
  $"($env.HOME)/.cache/lm-studio/bin",

  $"($env.GOPATH)/bin",
])

# explicitely set go dirs so we can control sandbox access w/ agents
load-env {
    "GOCACHE": $"($env.HOME)/Library/Caches/go-build"
    "GOTMPDIR": $"($env.HOME)/Library/Caches/go-tmp"
    "GOMODCACHE": $"($env.GOPATH)/pkg/mod"
    "GOROOT": $"(do { ^brew --prefix go } | str trim)/libexec"
}

const local_config = if ($"($nu.default-config-dir)/local.nu" | path exists) {
  $"($nu.default-config-dir)/local.nu"
} else { null }
source $local_config


# run codex with access to web search, gloabl caches, etc.
export def codex [...args] {
  let writeable_roots = ([
      ($env.GOCACHE | path expand)
      ($env.GOMODCACHE | path expand)
      ($env.GOTMPDIR | path expand)
    ] | to json -r)

  ^codex --search --model=gpt-5-codex -c model_reasoning_effort="high" --sandbox workspace-write -c sandbox_workspace_write.network_access=true -c $'sandbox_workspace_write.writable_roots=($writeable_roots)' ...$args
}
