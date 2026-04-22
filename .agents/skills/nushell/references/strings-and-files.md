# Strings and File Patterns

## String Manipulation

```nu
# Interpolation

$"Hello ($name)!"
$"Sum: (1 + 2)"  # "Sum: 3"

# Split and join

"a,b,c" | split row ","        # ["a", "b", "c"]
["a", "b"] | str join ", "     # "a, b"

# Regex

"hello123" | parse --regex '(?P<word>\w+)(?P<num>\d+)'

# Multi-line strings

$"
Line 1
Line 2
"
```

## Glob Patterns

```nu
# Basic patterns

glob *.rs                         # All .rs files in current dir
glob **/*.rs                      # Recursive .rs files
glob **/*.{rs,toml}               # Multiple extensions
```

Prefer `glob` over `find` or `ls` for file searches when possible.
