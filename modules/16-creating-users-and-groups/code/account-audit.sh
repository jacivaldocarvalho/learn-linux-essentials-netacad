#!/usr/bin/env bash
# Read-only account inspection for Linux Essentials Module 16.
set -euo pipefail

account="${1:-${USER:-}}"
if [[ -z "$account" ]]; then
  printf 'Usage: %s USERNAME\n' "$0" >&2
  exit 2
fi

printf '== Current identity ==\n'
id
printf '\n== Account record: %s ==\n' "$account"
if ! getent passwd "$account"; then
  printf 'User not found: %s\n' "$account" >&2
  exit 1
fi
printf '\n== Group membership ==\n'
id "$account"
printf '\n== useradd defaults ==\n'
if command -v useradd >/dev/null 2>&1; then
  useradd -D || true
else
  printf 'useradd not installed\n'
fi
printf '\n== Selected login.defs settings ==\n'
if [[ -r /etc/login.defs ]]; then
  grep -E '^(UID_MIN|UID_MAX|GID_MIN|GID_MAX|CREATE_HOME|UMASK|USERGROUPS_ENAB|PASS_MAX_DAYS|PASS_MIN_DAYS|PASS_WARN_AGE)[[:space:]]' /etc/login.defs || true
fi
printf '\n== Password aging (if permitted) ==\n'
if command -v chage >/dev/null 2>&1; then
  chage -l "$account" 2>/dev/null || printf 'Insufficient permissions to read password aging for %s\n' "$account"
fi
