#!/usr/bin/env bash

raw_input="$(cat)"

RAW_INPUT="$raw_input" python3 <<'PYCODE'
import json
import math
import os
import subprocess
import sys


def deep_get(obj, *keys):
    cur = obj
    for key in keys:
        if not isinstance(cur, dict):
            return None
        cur = cur.get(key)
        if cur is None:
            return None
    return cur


def format_number(value, decimals=2):
    try:
        number = float(value)
    except (TypeError, ValueError):
        return None
    if math.isnan(number) or math.isinf(number):
        return None
    text = f"{number:.{decimals}f}".rstrip("0").rstrip(".")
    return text or "0"


def format_compact_tokens(value):
    try:
        number = float(value)
    except (TypeError, ValueError):
        return None
    if math.isnan(number) or math.isinf(number):
        return None

    abs_number = abs(number)
    scaled = number
    suffix = ""

    if abs_number >= 1_000_000:
        scaled = number / 1_000_000
        suffix = "M"
    elif abs_number >= 1_000:
        scaled = number / 1_000
        suffix = "K"

    abs_scaled = abs(scaled)
    if abs_scaled >= 100:
        decimals = 0
    elif abs_scaled >= 10:
        decimals = 1
    else:
        decimals = 2

    text = f"{scaled:.{decimals}f}"
    if decimals > 0:
        text = text.rstrip("0").rstrip(".")
    return f"{text or '0'}{suffix}"


def as_float(value):
    try:
        number = float(value)
    except (TypeError, ValueError):
        return None
    if math.isnan(number) or math.isinf(number):
        return None
    return number


def display_path(path):
    if not isinstance(path, str) or not path:
        return None
    home = os.path.expanduser("~")
    if path == home or path.startswith(home + os.sep):
        return "~" + path[len(home) :]
    return path


def get_branch(path):
    if not path:
        return None
    try:
        result = subprocess.run(
            ["git", "-C", path, "rev-parse", "--abbrev-ref", "HEAD"],
            check=False,
            capture_output=True,
            text=True,
        )
    except OSError:
        return None
    if result.returncode != 0:
        return None
    branch = result.stdout.strip()
    if not branch or branch == "HEAD":
        return None
    return branch


raw_input = os.environ.get("RAW_INPUT", "")
try:
    payload = json.loads(raw_input) if raw_input.strip() else {}
except json.JSONDecodeError:
    payload = {}

current_dir = deep_get(payload, "workspace", "current_dir")
if not isinstance(current_dir, str) or not current_dir:
    current_dir = os.getcwd()

model_id = deep_get(payload, "model", "id")

remaining_pct = as_float(deep_get(payload, "context_window", "remaining_percentage"))
used_pct = as_float(deep_get(payload, "context_window", "used_percentage"))
if used_pct is None and remaining_pct is not None:
    used_pct = 100.0 - remaining_pct

window_size = as_float(deep_get(payload, "context_window", "context_window_size"))

usage_obj = deep_get(payload, "context_window", "current_usage")
usage_tokens = None
if isinstance(usage_obj, dict):
    usage_sum = 0.0
    usage_found = False
    for key in (
        "input_tokens",
        "output_tokens",
        "cache_creation_input_tokens",
        "cache_read_input_tokens",
    ):
        token_value = as_float(usage_obj.get(key))
        if token_value is None:
            continue
        usage_sum += token_value
        usage_found = True
    if usage_found:
        usage_tokens = usage_sum

# Docs say context_window_size is 200000 by default (or 1000000 extended).
# Some versions may report a scaled-down value; normalize when we can infer it.
if window_size is not None and window_size < 10_000:
    if used_pct is not None and used_pct > 0 and usage_tokens is not None:
        estimated_window = usage_tokens * 100.0 / used_pct
        if estimated_window >= 100_000:
            window_size = estimated_window
    elif isinstance(model_id, str) and model_id.startswith("claude-"):
        window_size = window_size * 100.0

used_tokens = usage_tokens
if used_tokens is None and window_size is not None and used_pct is not None:
    used_tokens = window_size * used_pct / 100.0

remaining = format_number(remaining_pct, decimals=2) if remaining_pct is not None else None
window = format_compact_tokens(window_size)
used = format_compact_tokens(used_tokens)

parts = []
display_dir = display_path(current_dir)
if display_dir:
    parts.append(display_dir)

branch = get_branch(current_dir)
if branch:
    parts.append(branch)

if remaining is not None:
    parts.append(f"{remaining}% left")
if window is not None:
    parts.append(f"{window} window")
if used is not None:
    parts.append(f"{used} used")

sys.stdout.write("\t" + " · ".join(parts))
PYCODE
