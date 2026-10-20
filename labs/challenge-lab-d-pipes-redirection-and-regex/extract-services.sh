#!/usr/bin/env bash
# Challenge Lab D: extract unique service names without intermediate files.
set -Eeuo pipefail

usage() {
  cat <<'HELP'
Usage: ./extract-services.sh [--input FILE] [--output FILE] [--expect-count N]

Defaults:
  --input        /etc/services
  --output       $HOME/uniqueservices.txt
  --expect-count Optional expected number of unique names (e.g. 340 in NetAcad)

The output file is overwritten. No intermediate files are created.
HELP
}

input=/etc/services
output="$HOME/uniqueservices.txt"
expected=

while (($#)); do
  case "$1" in
    --input|--output|--expect-count)
      if (($# < 2)); then printf 'Error: missing value for %s\n' "$1" >&2; exit 2; fi
      case "$1" in
        --input) input=$2 ;;
        --output) output=$2 ;;
        --expect-count) expected=$2 ;;
      esac
      shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) printf 'Error: unknown argument: %s\n' "$1" >&2; usage >&2; exit 2 ;;
  esac
done

if [[ ! -f "$input" || ! -r "$input" ]]; then
  printf 'Error: input file is missing or unreadable: %s\n' "$input" >&2
  exit 1
fi
if [[ -n "$expected" && ! "$expected" =~ ^[0-9]+$ ]]; then
  printf 'Error: --expect-count must be a nonnegative integer\n' >&2
  exit 2
fi
if [[ "$input" -ef "$output" ]]; then
  printf 'Error: input and output refer to the same file\n' >&2
  exit 2
fi
if [[ ! -d "$(dirname -- "$output")" ]]; then
  printf 'Error: output directory does not exist: %s\n' "$(dirname -- "$output")" >&2
  exit 1
fi

# C locale ensures ASCII [a-zA-Z] matching and reproducible lexical sorting.
# The shell redirection writes directly to the final destination.
if LC_ALL=C awk '/^[a-zA-Z]/ { print $1 }' "$input" | LC_ALL=C sort -u > "$output"; then
  printf 'Created: %s\n' "$output"
  wc -l -- "$output"
else
  printf 'Error: unable to generate the service list\n' >&2
  exit 1
fi

if [[ -n "$expected" ]]; then
  count=$(wc -l < "$output")
  if (( count != expected )); then
    printf 'Error: expected %s names, found %s\n' "$expected" "$count" >&2
    exit 1
  fi
  printf 'Expected count verified: %s\n' "$count"
fi

printf '\nFirst 10 services:\n'
head -n 10 -- "$output"
printf '\nLast 10 services:\n'
tail -n 10 -- "$output"
