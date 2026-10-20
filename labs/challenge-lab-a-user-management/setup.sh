#!/usr/bin/env bash
# Challenge Lab A: User Management — fresh-lab setup only.
# Usage: sudo bash setup.sh --apply
set -Eeuo pipefail

readonly CONTENT='This file contains confidential information for the department.'
readonly GROUPS_TO_CREATE=(engineering sales is)
readonly USERS_TO_CREATE=(
  'engadmin:engineering' 'enguser1:engineering' 'enguser2:engineering'
  'salesadmin:sales' 'salesuser1:sales' 'salesuser2:sales'
  'isadmin:is' 'isuser1:is' 'isuser2:is'
)
readonly DEPARTMENTS=(
  'engineering:engadmin:engineering'
  'sales:salesadmin:sales'
  'is:isadmin:is'
)

if [[ "${1:-}" != '--apply' || "$#" -ne 1 ]]; then
  printf 'Usage: sudo bash %s --apply\n' "$0" >&2
  printf 'This script creates local users/groups and protected directories at /.\n' >&2
  exit 2
fi
if (( EUID != 0 )); then
  printf 'Error: run this script as root (sudo).\n' >&2
  exit 1
fi
for cmd in getent groupadd useradd install chown chmod id; do
  command -v "$cmd" >/dev/null || { printf 'Missing command: %s\n' "$cmd" >&2; exit 1; }
done
[[ -x /bin/bash ]] || { printf 'Missing /bin/bash\n' >&2; exit 1; }

# Preflight: do not modify existing accounts, groups, or directory trees.
for group in "${GROUPS_TO_CREATE[@]}"; do
  if getent group "$group" >/dev/null; then
    printf 'Refusing: group already exists: %s\n' "$group" >&2
    exit 1
  fi
done
for record in "${USERS_TO_CREATE[@]}"; do
  user=${record%%:*}
  if getent passwd "$user" >/dev/null; then
    printf 'Refusing: user already exists: %s\n' "$user" >&2
    exit 1
  fi
done
for record in "${DEPARTMENTS[@]}"; do
  dept=${record%%:*}
  if [[ -e "/$dept" || -L "/$dept" ]]; then
    printf 'Refusing: path already exists: /%s\n' "$dept" >&2
    exit 1
  fi
done

printf 'Creating three groups...\n'
for group in "${GROUPS_TO_CREATE[@]}"; do groupadd "$group"; done

printf 'Creating nine users...\n'
for record in "${USERS_TO_CREATE[@]}"; do
  user=${record%%:*}
  group=${record#*:}
  useradd -m -s /bin/bash -g "$group" "$user"
done

printf 'Creating department directories and documents...\n'
for record in "${DEPARTMENTS[@]}"; do
  IFS=: read -r dept admin group <<< "$record"
  directory="/$dept"
  install -d -m 0700 "$directory"
  chown "$admin:$group" "$directory"
  # install creates the file with a restrictive mode, without relying on umask.
  install -m 0600 /dev/null "$directory/confidential.txt"
  printf '%s\n' "$CONTENT" > "$directory/confidential.txt"
  chown "$admin:$group" "$directory/confidential.txt"
  chmod 0640 "$directory/confidential.txt"
  chmod 3770 "$directory"
done

printf '\nVerification:\n'
for record in "${USERS_TO_CREATE[@]}"; do id "${record%%:*}"; done
for record in "${DEPARTMENTS[@]}"; do
  IFS=: read -r dept admin group <<< "$record"
  ls -ld "/$dept"
  ls -l "/$dept/confidential.txt"
done
printf '\nSetup complete. Passwords were not set.\n'
