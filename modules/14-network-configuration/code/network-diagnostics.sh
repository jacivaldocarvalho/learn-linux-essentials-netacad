#!/usr/bin/env bash
# Chapter 14: read-only Linux network diagnostics.
set -u

section() { printf '\n=== %s ===\n' "$1"; }
run() {
  if command -v "$1" >/dev/null 2>&1; then
    "$@" || printf 'Command failed: %s\n' "$1" >&2
  else
    printf 'Unavailable: %s\n' "$1"
  fi
}

if [[ $# -gt 1 || ( $# -eq 1 && "$1" != '--online' ) ]]; then
  printf 'Usage: %s [--online]\n' "$0" >&2
  exit 2
fi

section 'Host'
run hostname
section 'IPv4 addresses'
run ip -4 addr show
section 'IPv6 addresses'
run ip -6 addr show
section 'Routes'
run ip route show
section 'Resolver settings'
if [[ -r /etc/resolv.conf ]]; then cat /etc/resolv.conf; else printf 'Cannot read /etc/resolv.conf\n'; fi
section 'Name service lookup order'
if [[ -r /etc/nsswitch.conf ]]; then grep '^hosts:' /etc/nsswitch.conf || true; else printf 'Cannot read /etc/nsswitch.conf\n'; fi
section 'Socket summary'
run ss -s
section 'Listening TCP/UDP sockets'
run ss -tuln

if [[ $# -eq 1 ]]; then
  section 'DNS lookup for example.com'
  if command -v host >/dev/null 2>&1; then
    run host example.com
  elif command -v dig >/dev/null 2>&1; then
    run dig +short example.com
  else
    printf 'Neither host nor dig is installed.\n'
  fi
  section 'ICMP test for example.com'
  run ping -c 4 -W 2 example.com
fi
