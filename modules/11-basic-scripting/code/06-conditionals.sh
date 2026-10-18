#!/bin/bash
# Check whether a directory exists; avoid modifying the filesystem.
TARGET="/tmp"
if [ -d "$TARGET" ]; then
    echo "$TARGET is a directory"
else
    echo "$TARGET is not a directory"
fi

# Compare the first argument as a string.
if [ "${1:-}" = "hello" ]; then
    echo "hello yourself"
elif [ "${1:-}" = "goodbye" ]; then
    echo "nice to have met you"
else
    echo "I didn't understand that"
fi
