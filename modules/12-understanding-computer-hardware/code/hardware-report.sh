#!/usr/bin/env bash
# Read-only hardware inventory for Linux Essentials Chapter 12.
# Run: bash hardware-report.sh [output-file]
set -u

section() { printf '\n===== %s =====\n' "$1"; }
run_optional() {
  local label="$1"; shift
  section "$label"
  if command -v "$1" >/dev/null 2>&1; then
    "$@" 2>&1 || printf 'Command could not complete (permissions or environment restrictions).\n'
  else
    printf 'Unavailable: %s is not installed in this environment.\n' "$1"
  fi
}
report() {
  printf 'LINUX HARDWARE REPORT\n'
  printf 'Generated: %s\n' "$(date '+%Y-%m-%d %H:%M:%S %Z')"
  printf 'Host: %s\n' "$(hostname 2>/dev/null || printf 'unknown')"
  run_optional 'System architecture (arch)' arch
  run_optional 'CPU information (lscpu)' lscpu
  if command -v free >/dev/null 2>&1; then
    run_optional 'Memory and swap (free -h)' free -h
  else
    section 'Memory and swap'; printf 'Unavailable: free is not installed.\n'
  fi
  if command -v lsblk >/dev/null 2>&1; then
    run_optional 'Disks and partitions (lsblk)' lsblk -o NAME,TYPE,SIZE,FSTYPE,MOUNTPOINTS
  else
    section 'Disks and partitions (/dev/sd*)'
    local found=0 path
    for path in /dev/sd*; do
      if [[ -e "$path" ]]; then printf '%s\n' "$path"; found=1; fi
    done
    (( found )) || printf 'No /dev/sd* devices visible.\n'
  fi
  run_optional 'PCI devices (lspci)' lspci
  run_optional 'USB devices (lsusb)' lsusb
  section 'Notes'
  printf 'Device visibility may be limited in containers or virtual machines.\n'
  printf 'This report performs no disk changes and does not require sudo.\n'
}
if (( $# > 1 )); then
  printf 'Usage: %s [output-file]\n' "$0" >&2
  exit 2
fi
if (( $# == 1 )); then
  output="$1"
  if [[ -e "$output" ]]; then
    printf 'Refusing to overwrite existing file: %s\n' "$output" >&2
    exit 1
  fi
  report > "$output" || exit 1
  printf 'Report saved to: %s\n' "$output"
else
  report
fi
