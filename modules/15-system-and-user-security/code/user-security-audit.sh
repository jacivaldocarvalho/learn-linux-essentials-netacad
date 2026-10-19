#!/usr/bin/env bash
# Module 15 — read-only user and session inspection.
set -u

section() { printf '\n== %s ==\n' "$1"; }
run_if_available() {
  if command -v "$1" >/dev/null 2>&1; then
    "$@" || printf 'Command failed: %s\n' "$1" >&2
  else
    printf 'Not installed: %s\n' "$1"
  fi
}

section 'Current identity'
run_if_available id
section 'Current group names'
run_if_available id -Gn
section 'Root account record (no password hashes)'
run_if_available getent passwd root
section 'Current account record'
run_if_available getent passwd "$(id -un)"
section 'Active login sessions'
run_if_available who
section 'Session activity'
run_if_available w
section 'Recent login history'
if command -v last >/dev/null 2>&1; then
  last -n 5 || printf 'Login history unavailable\n' >&2
else
  printf 'Not installed: last\n'
fi
section 'Recent reboot history'
if command -v last >/dev/null 2>&1; then
  last -n 3 reboot || printf 'Reboot history unavailable\n' >&2
else
  printf 'Not installed: last\n'
fi
