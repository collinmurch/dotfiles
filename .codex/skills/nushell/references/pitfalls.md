# Common Pitfalls

## each on Single Records

```nu
# Avoid passing a single record to each

let record = {a: 1, b: 2}
$record | each {|field| print $field}  # Only runs once

# Use items, values, or transpose instead

$record | items {|key, val| print $"($key): ($val)"}
$record | transpose key val | each {|row| ...}
```

## Optional Fields

```nu
# Accessing missing fields raises an error

$record.missing

# Use ? and default

$record.missing?           # null
$record.missing? | default "N/A"
```

## Empty Collections

```nu
# Empty list or table checks

if ($list | is-empty) { ... }

# Default value if empty

$list | default -e $val_if_empty
```
