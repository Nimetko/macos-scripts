#!/bin/bash

# ===== User configuration =====
EDITOR=${EDITOR:-nvim}  # Default to nvim, can be overridden by env or by editing here
# =============================

# List of patterns (case-insensitive)
patterns=("todo" "todo.*")

found=""
dir="$PWD"
while [[ "$dir" != "/" ]]; do
    for pat in "${patterns[@]}"; do
        # Case-insensitive globbing
        shopt -s nocaseglob
        for f in "$dir"/$pat; do
            if [[ -f "$f" ]]; then
                found="$f"
                break 2
            fi
        done
        shopt -u nocaseglob
    done
    dir=$(dirname "$dir")
done

# If not found, search subdirectories (downward, case-insensitive, for all patterns)
if [[ -z "$found" ]]; then
    found=$(find . -type f \( -iname "todo" -o -iname "todo.*" \) | head -n 1)
    [[ -n "$found" ]] && found="$PWD/${found#./}"
fi

if [[ -n "$found" && -f "$found" ]]; then
    "$EDITOR" "$found"
else
    echo "No TODO file found."
    exit 1
fi
