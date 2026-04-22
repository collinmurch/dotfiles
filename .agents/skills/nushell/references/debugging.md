# Debugging Techniques

```nu
# Print intermediate values

$data | each {|x| print $x; $x}

# Inspect type

$value | describe

# Debug point

debug

# Timing

timeit { expensive-command }
```
