#!/bin/sh
set -e

input=$(cat)

eval "$(printf '%s' "$input" | jq -r '
  @text "dir=\(.workspace.current_dir // "")
  tin=\(.context_window.current_usage.input_tokens // 0)
  tcachec=\(.context_window.current_usage.cache_creation_input_tokens // 0)
  tcacher=\(.context_window.current_usage.cache_read_input_tokens // 0)
  csize=\(.context_window.context_window_size // 0)
  total_cost=\(.cost.total_cost_usd // "")"
')"

vcs_info=$(
  cd "$dir" 2>/dev/null || exit 0
  d=$(pwd)
  while [ -n "$d" ]; do
    if [ -d "$d/.jj" ]; then
      printf '%s ' '◆'
      jj log -r@ -n1 --no-graph --ignore-working-copy \
        -T 'separate(" ", change_id.shortest(), parents.map(|p| p.local_bookmarks().map(|x| x.name()).join(" ")).join(" "))' 2>/dev/null
      exit 0
    elif [ -d "$d/.git" ]; then
      read -r head < "$d/.git/HEAD" 2>/dev/null || exit 0
      case "$head" in
        ("ref: refs/heads/"*) printf ' %s' "${head#ref: refs/heads/}" ;;
        (*) printf ' %.7s' "$head" ;;
      esac
      exit 0
    elif [ -f "$d/.git" ]; then
      read -r gitlink < "$d/.git" 2>/dev/null || exit 0
      gitdir="${gitlink#gitdir: }"
      read -r head < "$gitdir/HEAD" 2>/dev/null || exit 0
      case "$head" in
        ("ref: refs/heads/"*) printf ' %s' "${head#ref: refs/heads/}" ;;
        (*) printf ' %.7s' "$head" ;;
      esac
      exit 0
    fi
    d=${d%/*}
  done
)

fmt_tok() {
  t=$1
  if [ "$t" -ge 1000000 ]; then
    echo "$((t / 1000000)).$((t % 1000000 / 100000))M"
  elif [ "$t" -ge 1000 ]; then
    echo "$((t / 1000))k"
  else
    echo "$t"
  fi
}

printf '%s' "${dir##*/}"

[ -n "$vcs_info" ] && printf ' - %s' "$vcs_info"

ttok=$((tin + tcachec + tcacher))
if [ "$tin" -gt 0 ] && [ "$csize" -gt 0 ]; then
  pct=$((ttok * 100 / csize))
  printf ' | %d%% %s/%s' "$pct" "$(fmt_tok $ttok)" "$(fmt_tok $csize)"
else
  printf ' | n/a'
fi

if [ -n "$total_cost" ]; then
  printf ' | $%.4f' "$total_cost"
fi
