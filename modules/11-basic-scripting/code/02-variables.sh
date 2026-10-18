#!/bin/bash
# Assignment, expansion, and command substitution.
ANIMAL="penguin"
SOMETHING="$ANIMAL"
CURRENT_DIRECTORY=$(pwd)
echo "My favorite animal is a $SOMETHING"
echo "You are in $CURRENT_DIRECTORY"
