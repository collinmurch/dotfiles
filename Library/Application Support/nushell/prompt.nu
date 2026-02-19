def vcs-root [] {
    mut d = $env.PWD
    loop {
        if ($d | path join ".git" | path exists) {
            return $d
        }
        let parent = ($d | path dirname)
        if $parent == $d { return null }
        $d = $parent
    }
    null
}

def dir-prompt [] {
    let root = (vcs-root)
    if $root != null {
        let repo = ($root | path basename)
        if $root == $env.PWD { return $repo }
        return $"($repo)/($env.PWD | str replace $"($root)/" "")"
    }
    let display = ($env.PWD | str replace $env.HOME "~")
    let parts = ($display | split row "/" | where {|p| $p | is-not-empty })
    if ($parts | length) <= 3 {
        $parts | str join "/"
    } else {
        $parts | last 3 | str join "/"
    }
}

def vcs-prompt [] {
    mut d = $env.PWD
    loop {
        let git_path = ($d | path join ".git")
        if ($git_path | path exists) {
            let head_file = if (($git_path | path type) == "dir") {
                $git_path | path join "HEAD"
            } else {
                try { open $git_path | str trim | str replace "gitdir: " "" } catch { return "" } | path join "HEAD"
            }
            let head = (try { open $head_file | str trim } catch { return "" })
            let ref = if ($head | str starts-with "ref: refs/heads/") {
                $head | str replace "ref: refs/heads/" ""
            } else {
                $head | str substring 0..7
            }
            return $"(ansi purple_bold) ($ref)(ansi reset)"
        }
        let parent = ($d | path dirname)
        if $parent == $d { break }
        $d = $parent
    }
    ""
}
