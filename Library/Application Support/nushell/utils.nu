export def deep-merge [override: record] {
    let base = $in
    $override | columns | reduce --fold $base {|col, acc|
        if $col in ($acc | columns) {
        let bv = $acc | get $col
        let ov = $override | get $col
        if ($bv | describe | str starts-with record) and ($ov | describe | str starts-with record) {
            $acc | upsert $col ($bv | deep-merge $ov)
        } else if ($bv | describe | str starts-with list) and ($ov | describe | str starts-with list) {
            $acc | upsert $col ($bv | append $ov | uniq)
        } else {
            $acc | upsert $col $ov
        }
        } else {
            $acc | upsert $col ($override | get $col)
        }
    }
}
