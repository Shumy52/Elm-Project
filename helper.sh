#!/bin/bash

if [[ -n "$1" && -f "$1" ]]; then
    input="$1"
else
    input="/dev/stdin"
fi

# Filter the input for debugging information
grep -E "Error|TODO|runtime exception|WARN" "$input" --color=auto