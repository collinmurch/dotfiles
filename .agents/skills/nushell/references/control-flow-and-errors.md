# Control Flow and Errors

## Conditionals

```nu
# If expressions return values

let result = if $condition {
    "yes"
} else {
    "no"
}

# Match expressions

let result = match $value {
    0 => "zero"
    1..10 => "small"
    _ => "large"
}
```

## Null Safety

```nu
# Optional fields with ?

$record.field?                    # Returns null if missing
$record.field? | default "N/A"    # Provide fallback

# Check existence

if ($record.field? != null) { ... }
```

## Error Handling

```nu
# Try-catch

try {
    dangerous-operation
} catch {|err|
    print $"Error: ($err.msg)"
}

# Returning errors

def my-func [] {
    if $condition {
        error make {msg: "Something went wrong"}
    } else {
        "success"
    }
}

# Check command success

let result = try { fallible-command }
if ($result == null) {
    # Handle error
}

# Use complete for detailed error info for external commands

let result = (fallible-external-command | complete)
if $result.exit_code != 0 {
    print $"Error: ($result.stderr)"
}
```
