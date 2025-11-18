# explicitely set cache dirs so we can control sandbox access with agents
load-env {
    "GOCACHE": $"($env.HOME)/Library/Caches/go-build"
    "GOTMPDIR": $"($env.HOME)/Library/Caches/go-tmp"
    "GOMODCACHE": $"($env.GOPATH)/pkg/mod"
    "GOROOT": $"(do { ^brew --prefix go } | str trim)/libexec"
    "NPMCACHE": $"($env.HOME)/.npm"
    "UV_CACHE_DIR": $"($env.HOME)/.cache/uv"
}

# run codex with access to web search, global caches, etc.
export def codex [...args] {
  let writeable_roots = ([
      ($env.GOCACHE | path expand)
      ($env.GOMODCACHE | path expand)
      ($env.GOTMPDIR | path expand)
      ($env.NPMCACHE | path expand)
      ($env.UV_CACHE_DIR | path expand)
    ] | to json -r)

  ^codex -c model_reasoning_effort="high" --enable web_search_request --sandbox workspace-write -c sandbox_workspace_write.network_access=true -c $'sandbox_workspace_write.writable_roots=($writeable_roots)' ...$args
}
