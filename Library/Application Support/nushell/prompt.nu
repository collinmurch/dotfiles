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
                let gitdir = (try { open $git_path | str trim | str replace "gitdir: " "" } catch { return "" })
                let gitdir_path = if ($gitdir | str starts-with "/") {
                    $gitdir
                } else {
                    $d | path join $gitdir
                }
                $gitdir_path | path join "HEAD"
            }
            let head = (try { open $head_file | str trim } catch { return "" })
            let ref = if ($head | str starts-with "ref: ") {
                let ref_path = ($head | str replace "ref: " "")
                if ($ref_path | str starts-with "refs/heads/") {
                    $ref_path | str replace "refs/heads/" ""
                } else {
                    $"detached@($ref_path | path basename)"
                }
            } else {
                $"detached@($head | str substring 0..7)"
            }
            return $"(ansi purple_bold) ($ref)(ansi reset)"
        }
        let parent = ($d | path dirname)
        if $parent == $d { break }
        $d = $parent
    }
    ""
}
