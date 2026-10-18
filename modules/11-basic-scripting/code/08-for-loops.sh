#!/bin/bash
# Iterate over a finite list.
SERVERS="servera serverb serverc"
for S in $SERVERS; do
    echo "Doing something to $S"
done

for NAME in Sean Jon Isaac David; do
    echo "Hello $NAME"
done

# Iterate over entries in the current directory (no changes made).
for ENTRY in *; do
    [ -e "$ENTRY" ] || continue
    echo "Found: $ENTRY"
done
