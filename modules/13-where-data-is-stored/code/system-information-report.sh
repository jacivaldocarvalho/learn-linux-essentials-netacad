#!/usr/bin/env bash
# Module 13 — Where Data Is Stored
# Read-only system information report; no elevated privileges required.
set -u

section() { printf '\n=== %s ===\n' "$1"; }
run() {
  if command -v "$1" >/dev/null 2>&1; then
    "$@" 2>&1 || printf '[Notice] Command could not complete: %s\n' "$1"
  else
    printf '[Unavailable] %s is not installed.\n' "$1"
  fi
}

printf 'Linux System Information Report\n'
printf 'Generated: '; date '+%Y-%m-%d %H:%M:%S %Z'
printf 'Host: '; hostname 2>/dev/null || printf 'unavailable\n'

section 'Kernel and architecture'
run uname -srmo
if [[ -r /proc/cmdline ]]; then
  printf 'Kernel boot parameters: '
  cat /proc/cmdline
fi

section 'Init process (PID 1)'
run ps -p 1 -o pid,ppid,user,comm,args

section 'Process snapshot (first 12 lines)'
if command -v ps >/dev/null 2>&1; then
  ps -ef | head -n 12
else
  printf '[Unavailable] ps is not installed.\n'
fi

section 'System load'
run uptime
if [[ -r /proc/loadavg ]]; then
  printf '/proc/loadavg: '
  cat /proc/loadavg
fi

section 'RAM and swap'
run free -h

section 'Kernel module sample'
if [[ -r /proc/modules ]]; then
  head -n 8 /proc/modules
else
  printf '[Unavailable] /proc/modules is not readable.\n'
fi

section 'Filesystem directories'
for path in / /boot /dev /etc /home /proc /sys /usr /usr/local /var /var/log; do
  if [[ -d "$path" ]]; then
    printf '[present] %s\n' "$path"
  else
    printf '[absent]  %s\n' "$path"
  fi
done

section 'Logging tools'
for tool in journalctl dmesg last; do
  if command -v "$tool" >/dev/null 2>&1; then
    printf '[available] %s\n' "$tool"
  else
    printf '[missing]   %s\n' "$tool"
  fi
done
printf 'Kernel log messages are not included (may require privileges).\n'

section 'Summary'
printf 'Report finished. All operations were read-only.\n'