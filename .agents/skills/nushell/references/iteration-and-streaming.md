# Iteration and Streaming

```nu
# each: transform each element

$list | each {|item| $item * 2}

# each --flatten: stream outputs instead of collecting
# Turns list<list<T>> into list<T> by streaming items as they arrive

ls *.txt | each --flatten {|f| open $f.name | lines } | find "TODO"

# each --keep-empty: preserve null results

[1 2 3] | each --keep-empty {|e| if $e == 2 { "found" }}
# Result: ["" "found" ""]  (vs. without flag: ["found"])

# reduce/fold: accumulate

$list | reduce --fold 0 {|item, acc| $acc + $item}

# Reduce without fold (first element is initial accumulator)

[1 2 3 4] | reduce {|it, acc| $acc - $it}  # ((1-2)-3)-4 = -8

# par-each: parallel processing

$large_list | par-each {|item| expensive-operation $item}

# for loop (imperative style)

for item in $list {
    print $item
}
```
