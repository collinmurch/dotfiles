# Pipeline Input and Signatures

## Table of Contents

- [Pipeline Input vs Parameters](#pipeline-input-vs-parameters)
- [Type Signatures](#type-signatures)
- [Pipe vs Call Ambiguity](#pipe-vs-call-ambiguity)
- [Row Conditions vs Closures](#row-conditions-vs-closures)
- [Closures and Scoping](#closures-and-scoping)

## Pipeline Input vs Parameters

Pipeline input (`$in`) is not interchangeable with parameters. Pipeline input is lazily evaluated and uses a different calling convention than positional parameters.

```nu
# Wrong: treats pipeline input as a positional parameter

def my-func [list: list, value: any] {
    $list | append $value
}

# Correct: declares pipeline input in the signature

def my-func [value: any]: list -> list {
    $in | append $value
}

# Usage
[1 2 3] | my-func 4
my-func [1 2 3] 4  # Error: my-func does not take positional params
```

This distinction applies to closures as well.

## Type Signatures

```nu
# No pipeline input

def func [x: int] { ... }                    # (x) -> output

# Pipeline input only

def func []: string -> int { ... }           # string | func -> int

# Both pipeline and parameters

def func [x: int]: string -> int { ... }     # string | func x -> int

# Generic pipeline

def func []: any -> any { ... }              # works with any input type
```

## Pipe vs Call Ambiguity

```nu
# These are different

$list | my-func arg1 arg2   # $list piped, arg1 and arg2 as parameters
my-func $list arg1 arg2     # All three as positional parameters (if signature allows)
```

## Row Conditions vs Closures

Row conditions are shorthand for simple field checks. Closures provide full flexibility and can be reused.

```nu
# Row conditions

$table | where size > 100
$table | where name =~ "test"
ls | where type == file
```

Row conditions are supported by commands like `where`, `find`, `skip while`, and `take while`. Prefer `where` over the deprecated `filter`.

Limitations:
- Cannot be stored in variables
- Only field access on the left side auto-expands
- Subexpressions must use `$it`

```nu
ls | where ($it.name | str downcase) =~ readme
```

```nu
# Closures

$table | where {|row| $row.size > 100}
$table | where {$in.size > 100}

let big_files = {|row| $row.size > 1mb}
ls | where $big_files
```

## Closures and Scoping

```nu
# Closures capture environment

let multiplier = 10
let double-and-add = {|x| ($x * 2) + $multiplier}
5 | do $double-and-add
```

Outer mutable variables cannot be captured.

```nu
mut sum = 0
[1 2 3] | each {|x| $sum = $sum + $x}  # This does not compile

# Use reduce instead

let sum = [1 2 3] | reduce {|x, acc| $acc + $x}
```
