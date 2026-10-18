#!/bin/bash
# Run: ./04-arguments.sh World
echo "Script: $0"
echo "Hello ${1:-World}"
echo "Number of arguments: $#"
