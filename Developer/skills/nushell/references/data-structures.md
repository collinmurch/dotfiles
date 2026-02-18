# Data Structures

## Lists

```nu
# Filter with index

$list | enumerate | where {|e| $e.index > 5 and $e.item.some-bool-field}

# Transform with previous state

$list | reduce --fold 0 {|item, acc| $acc + $item.value}
```

## Records

```nu
# Create record

{name: "Alice", age: 30}

# Merge records (right-biased)

$rec1 | merge $rec2

# Merge many records (right-biased)

[$rec1 $rec2 $rec3 $rec4] | into record

# Update field

$rec | update name {|r| $"Dr. ($r.name)"}

# Insert field

$rec | insert active true

# Insert field based on existing fields

{x: 1, y: 2} | insert z {|r| $r.x + $r.y}

# Upsert (update or insert)

$rec | upsert count {|r| ($r.count? | default 0) + 1}

# Reject fields

$rec | reject password secret_key

# Select fields

$rec | select name age email
```

## Tables

Tables are lists of records.

```nu
let table = [
    {name: "Alice", age: 30}
    {name: "Bob", age: 25}
]

# Filter rows

$table | where age > 25

# Add column

$table | insert retired {|row| $row.age > 65}

# Rename column

$table | rename -c {age: years}

# Group by

$table | group-by status --to-table

# Transpose (rows and columns)

$table | transpose name data
```
