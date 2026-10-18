#!/bin/bash
# Capture exit status immediately after the tested command.
if grep -q root /etc/passwd; then
    echo "root was found"
else
    status=$?
    echo "grep did not find root (or failed); status: $status"
fi
# Explicit exit status, successful example.
exit 0
