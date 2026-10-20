#!/usr/bin/env bash
# Challenge Lab B: User Management Scripting
set -Eeuo pipefail

if (( EUID != 0 )); then
  printf 'Error: run this script with sudo.\n' >&2
  exit 1
fi

valid_name() {
  [[ $1 =~ ^[a-z_][a-z0-9_-]*$ ]] && (( ${#1} <= 32 ))
}

while :; do
  read -r -p 'Enter a new group name: ' group_name
  if ! valid_name "$group_name"; then
    printf 'Error: use 1-32 lowercase letters, digits, underscores or hyphens; start with a letter or underscore.\n' >&2
  elif getent group "$group_name" >/dev/null; then
    printf 'Error: group "%s" already exists. Try another name.\n' "$group_name" >&2
  else
    break
  fi
done

while :; do
  read -r -p 'Enter a new username: ' user_name
  if ! valid_name "$user_name"; then
    printf 'Error: invalid username. Try another name.\n' >&2
  elif getent passwd "$user_name" >/dev/null; then
    printf 'Error: user "%s" already exists. Try another name.\n' "$user_name" >&2
  elif [[ -e "/$user_name" || -L "/$user_name" ]]; then
    printf 'Error: /%s already exists. Try another username.\n' "$user_name" >&2
  else
    break
  fi
done

printf '\nCreating group "%s"...\n' "$group_name"
groupadd -- "$group_name"
printf 'Creating user "%s"...\n' "$user_name"
useradd -m -s /bin/bash -g "$group_name" -- "$user_name"

printf '\nSet a password for %s:\n' "$user_name"
if ! passwd "$user_name"; then
  printf 'Error: password setup failed. Account may exist; inspect it before retrying.\n' >&2
  exit 1
fi

printf '\nCreating /%s...\n' "$user_name"
mkdir -- "/$user_name"
chown -- "$user_name:$group_name" "/$user_name"
chmod 3770 -- "/$user_name"

printf '\nVerification:\n'
getent group "$group_name"
getent passwd "$user_name"
id "$user_name"
ls -ld -- "/$user_name"
printf '\nCompleted successfully.\n'
