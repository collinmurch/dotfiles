#!/usr/bin/env bash
set -euo pipefail

input="$(cat 2>/dev/null || true)"
json='{}'

if command -v jq >/dev/null 2>&1; then
  if parsed="$(printf '%s' "$input" | jq -c '.' 2>/dev/null)"; then
    json="$parsed"
  fi
fi

current_dir=""
remaining_pct=""
window_size=""
used_tokens=""
used_pct=""

if command -v jq >/dev/null 2>&1; then
  current_dir="$(jq -r '.workspace.current_dir // ""' <<<"$json")"
  remaining_pct="$(jq -r '
    if (.context_window.remaining_percentage | type) == "number"
    then (.context_window.remaining_percentage | tostring)
    else ""
    end
  ' <<<"$json")"
  window_size="$(jq -r '
    if (.context_window.context_window_size | type) == "number"
    then (.context_window.context_window_size | tostring)
    else ""
    end
  ' <<<"$json")"
  used_tokens="$(jq -r '
    (.context_window.current_usage // {}) as $u
    | [
        $u.input_tokens,
        $u.cache_creation_input_tokens,
        $u.cache_read_input_tokens
      ]
    | map(select(type == "number"))
    | if length > 0 then (add | tostring) else "" end
  ' <<<"$json")"
  used_pct="$(jq -r '
    if (.context_window.used_percentage | type) == "number"
    then (.context_window.used_percentage | tostring)
    else ""
    end
  ' <<<"$json")"
fi

if [[ -z "${current_dir}" ]]; then
  current_dir="$PWD"
fi

display_dir="$current_dir"
if [[ -n "${HOME:-}" ]]; then
  case "$current_dir" in
    "$HOME")
      display_dir="~"
      ;;
    "$HOME"/*)
      display_dir="~${current_dir#$HOME}"
      ;;
  esac
fi

branch="$(git -C "$current_dir" rev-parse --abbrev-ref HEAD 2>/dev/null || true)"
if [[ "$branch" == "HEAD" ]]; then
  branch=""
fi

is_number() {
  [[ "${1:-}" =~ ^-?[0-9]+([.][0-9]+)?$ ]]
}

compute_remaining_from_used_pct() {
  awk -v p="$1" 'BEGIN { print (100 - p) }'
}

compute_remaining_from_tokens() {
  awk -v u="$1" -v w="$2" 'BEGIN { if (w > 0) print (100 - (u * 100 / w)) }'
}

format_number() {
  awk -v n="$1" 'BEGIN { v = sprintf("%.2f", n); sub(/0+$/, "", v); sub(/\.$/, "", v); print v }'
}

format_compact() {
  awk -v n="$1" '
    function abs(x) { return x < 0 ? -x : x }
    BEGIN {
      a = abs(n)
      s = n
      suffix = ""

      if (a >= 1000000) {
        s = n / 1000000
        suffix = "M"
      } else if (a >= 1000) {
        s = n / 1000
        suffix = "K"
      }

      sa = abs(s)
      if (sa >= 100) {
        d = 0
      } else if (sa >= 10) {
        d = 1
      } else {
        d = 2
      }

      v = sprintf("%." d "f", s)
      if (d > 0) {
        sub(/0+$/, "", v)
        sub(/\.$/, "", v)
      }
      print v suffix
    }
  '
}

# Before the first API response, current_usage is null. In that state we want
# a stable startup display: repo · branch · 100% left, with no window/used.
if ! is_number "$used_tokens"; then
  remaining_pct="100"
else
  if ! is_number "$remaining_pct"; then
    if is_number "$used_pct"; then
      remaining_pct="$(compute_remaining_from_used_pct "$used_pct")"
    elif is_number "$window_size"; then
      remaining_pct="$(compute_remaining_from_tokens "$used_tokens" "$window_size")"
    fi
  fi
fi

parts=()
parts+=("$display_dir")
if [[ -n "$branch" ]]; then
  parts+=("$branch")
fi

if is_number "$remaining_pct"; then
  parts+=("$(format_number "$remaining_pct")% left")
fi
if is_number "$used_tokens" && is_number "$window_size"; then
  parts+=("$(format_compact "$window_size") window")
fi
if is_number "$used_tokens"; then
  parts+=("$(format_compact "$used_tokens") used")
fi

joined=""
for part in "${parts[@]}"; do
  if [[ -n "$joined" ]]; then
    joined="$joined · $part"
  else
    joined="$part"
  fi
done

printf '\t%s' "$joined"
