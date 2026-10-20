#!/usr/bin/env bash
# Archive immediate *.log files from /var/log and extract them to ~/backup.
# Usage: ./backup-logs.sh [--source DIR] [--archive-dir DIR] [--backup-dir DIR]
set -Eeuo pipefail

SOURCE_DIR=/var/log
ARCHIVE_DIR="${HOME:?HOME must be set}/archive"
BACKUP_DIR="$HOME/backup"

usage() {
  printf 'Usage: %s [--source DIR] [--archive-dir DIR] [--backup-dir DIR]\n' "$0"
}

while (($#)); do
  case "$1" in
    --source|--archive-dir|--backup-dir)
      if (($# < 2)) || [[ -z $2 ]]; then usage >&2; exit 2; fi
      case "$1" in
        --source) SOURCE_DIR=$2 ;;
        --archive-dir) ARCHIVE_DIR=$2 ;;
        --backup-dir) BACKUP_DIR=$2 ;;
      esac
      shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) printf 'Error: unknown argument: %s\n' "$1" >&2; usage >&2; exit 2 ;;
  esac
done

fail() { printf 'Error: %s\n' "$*" >&2; exit 1; }
[[ -d $SOURCE_DIR ]] || fail "source directory does not exist: $SOURCE_DIR"
[[ -r $SOURCE_DIR && -x $SOURCE_DIR ]] || fail "cannot read source directory: $SOURCE_DIR"
[[ $ARCHIVE_DIR != "$BACKUP_DIR" ]] || fail 'archive and backup directories must differ'

mkdir -p -- "$ARCHIVE_DIR" "$BACKUP_DIR"
archive="$ARCHIVE_DIR/log.tar"
[[ ! -e $archive && ! -L $archive ]] || fail "archive already exists: $archive (will not overwrite)"

# Only immediate regular files, not files in subdirectories. NUL-safe names.
mapfile -d '' -t files < <(find "$SOURCE_DIR" -maxdepth 1 -type f -name '*.log' -printf '%f\0' | sort -z)
((${#files[@]} > 0)) || fail "no .log files found directly in $SOURCE_DIR"
for file in "${files[@]}"; do
  [[ -r "$SOURCE_DIR/$file" ]] || fail "cannot read source file: $SOURCE_DIR/$file"
  [[ ! -e "$BACKUP_DIR/$file" && ! -L "$BACKUP_DIR/$file" ]] || fail "backup target already exists: $BACKUP_DIR/$file (will not overwrite)"
done

# Stage the archive in the destination filesystem, then publish atomically.
tmp=$(mktemp "$ARCHIVE_DIR/.log.tar.tmp.XXXXXXXX")
cleanup() { [[ -z ${tmp:-} ]] || rm -f -- "$tmp"; }
trap cleanup EXIT
trap 'printf "Error: command failed at line %s\n" "$LINENO" >&2' ERR

printf 'Creating archive: %s\n' "$archive"
printf '%s\0' "${files[@]}" | tar -C "$SOURCE_DIR" --null -T - -cvf "$tmp"
# Avoid replacing an archive that may have appeared while building it.
[[ ! -e $archive && ! -L $archive ]] || fail "archive appeared during creation: $archive"
ln -- "$tmp" "$archive" || fail "could not publish archive: $archive"
rm -f -- "$tmp"
tmp=''

printf '\nArchive contents:\n'
tar -tf "$archive"
printf '\nExtracting into: %s\n' "$BACKUP_DIR"
tar -xvf "$archive" -C "$BACKUP_DIR" --no-same-owner --keep-old-files

printf '\nVerifying extracted file contents:\n'
for file in "${files[@]}"; do
  cmp -s -- "$SOURCE_DIR/$file" "$BACKUP_DIR/$file" || fail "content mismatch: $file"
  printf 'OK: %s\n' "$file"
done
printf '\nBackup directory listing:\n'
ls -l -- "$BACKUP_DIR"
printf '\nCompleted: %s (%d files)\n' "$archive" "${#files[@]}"
