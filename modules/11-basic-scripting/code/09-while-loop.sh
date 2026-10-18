#!/bin/bash
# Count from zero through nine.
i=0
while [ "$i" -lt 10 ]; do
    echo "$i"
    i=$(( i + 1 ))
done
echo "Done counting"
