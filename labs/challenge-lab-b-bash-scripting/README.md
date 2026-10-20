# Challenge Lab B: User Management Scripting

Study notes and Bash implementation for the Cisco Networking Academy / NDG Linux Essentials challenge lab.

## 1. Lab Overview

**Modules:** 11 — Basic Scripting; 16 — Creating Users and Groups; 17 — Ownership and Permissions.

**Objective:** Automate creation of a unique group, a unique user with a Bash login shell and primary membership in that group, an interactive password, and a protected directory under `/` named after the user.

## 2. Script

See [`setup.sh`](setup.sh). It accepts the username and group name interactively; neither is hardcoded.

Run on a disposable Linux lab VM:

```bash
chmod +x setup.sh
sudo ./setup.sh
```

The script requires root privileges and prompts for the new group name and username. It checks `getent group` and `getent passwd` for existing names, rejects an existing `/<username>` path, and invokes `passwd` to set a password interactively.

## 3. Key Commands

| Command | Purpose |
|---|---|
| `getent group NAME` | Check whether a group exists |
| `getent passwd NAME` | Check whether a user exists |
| `groupadd NAME` | Create a group |
| `useradd -m -s /bin/bash -g GROUP NAME` | Create a user with home directory, Bash shell, and primary group |
| `passwd NAME` | Set an interactive password |
| `mkdir /NAME` | Create a root-level directory |
| `chown USER:GROUP /NAME` | Set directory ownership |
| `chmod 3770 /NAME` | Owner/group full access; SGID and sticky bit; no access for others |
| `id NAME` | Inspect UID, primary GID, and supplementary groups |
| `ls -ld /NAME` | Inspect directory metadata without entering it |

## 4. Permission Breakdown

`3770` consists of `2000` (SGID), `1000` (sticky bit), and `770` (owner/group `rwx`, others no permissions). SGID normally causes new files to inherit the directory's group. The sticky bit prevents ordinary group members from deleting or renaming files they do not own.

**Important limitation:** The directory owner and root can still delete other users' files. Thus the literal requirement that *only* a file owner can delete it is not fully enforceable with these traditional mode bits when the directory owner is a different user.

## 5. Error Handling

The script uses `set -Eeuo pipefail` to stop on unhandled errors, unset variables, or pipeline failures. The special variable `$?` contains the previous command's exit status (`0` for success, nonzero for failure). The script primarily uses `if` conditions and automatic error handling rather than repeatedly inspecting `$?`.

The script does not automatically roll back a group or user if a later step fails. Check the existing system state before rerunning after a partial failure.

## 6. Instructor Demonstration

1. Run `sudo ./setup.sh` and provide a unique group and user.
2. Show the output from `getent group GROUP`, `getent passwd USER`, `id USER`, and `ls -ld /USER`.
3. Run the script again and enter the same group name; observe the duplicate-group error and retry prompt.
4. Provide a new group name and then the previously created username; observe the duplicate-user error and retry prompt.
5. Complete with another unique username, or stop with `Ctrl+C` before creating further accounts if the instructor only needs the error demonstration.

## 7. Quick Reference

```text
Unique group        -> getent group
Unique user         -> getent passwd
Bash login shell    -> useradd -s /bin/bash
Primary group       -> useradd -g GROUP
Password            -> passwd USER
Command status      -> $?
Owner/group access  -> chmod 770
SGID + sticky bit   -> chmod 3770
Executable script   -> chmod +x setup.sh
```

## 8. Final Review Checklist

- [ ] The script runs with `sudo` and has the executable bit set.
- [ ] A unique group is created.
- [ ] A unique user is created with `/bin/bash` and the correct primary group.
- [ ] A password is set interactively.
- [ ] The directory `/<username>` exists and has the correct owner and group.
- [ ] The directory has mode `3770`.
- [ ] Duplicate group and username inputs display errors and allow retries.
- [ ] `getent`, `id`, and `ls -ld` confirm the final state.

---

**Challenge Lab B review complete — User Management Scripting.**
