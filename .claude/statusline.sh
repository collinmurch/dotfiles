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

if command -v jq >/dev/null 2>&1; then
  current_dir="$(jq -r '.workspace.current_dir // ""' <<<"$json")"
  remaining_pct="$(jq -r '
    if (.context_window.remaining_percentage | type) == "number" then
      (.context_window.remaining_percentage | tostring)
    elif (.context_window.used_percentage | type) == "number" then
      (100 - .context_window.used_percentage | tostring)
    else
      "100"
    end
  ' <<<"$json")"
else
  remaining_pct="100"
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

format_number() {
  awk -v n="$1" 'BEGIN { v = sprintf("%.2f", n); sub(/0+$/, "", v); sub(/\.$/, "", v); print v }'
}

if ! is_number "$remaining_pct"; then
  remaining_pct="100"
fi

parts=()
parts+=("$display_dir")
if [[ -n "$branch" ]]; then
  parts+=("$branch")
fi
parts+=("$(format_number "$remaining_pct")% left")

joined=""
for part in "${parts[@]}"; do
  if [[ -n "$joined" ]]; then
    joined="$joined · $part"
  else
    joined="$part"
  fi
done

printf '\t%s' "$joined"
