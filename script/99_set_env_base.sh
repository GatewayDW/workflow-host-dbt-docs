#!/bin/sh
var_count=0
while IFS= read -r line; do
    if [[ ! $line =~ ^# ]]; then
        export $line
        ((var_count++))
    fi
done < <(grep -v '^#' .env)

echo "Number of env variables set: $var_count"