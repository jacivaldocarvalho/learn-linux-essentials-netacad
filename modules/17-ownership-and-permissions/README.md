# Module 17 — Ownership and Permissions

Study notes for **Cisco Networking Academy / NDG Linux Essentials**, Chapter 17, covering file ownership, permission evaluation, and access management with standard Linux commands.

## 1. Exam Objective and Scope

This module explains how Linux uses user ownership, group ownership, and permission bits to control access to files and directories.

| Command | Purpose |
|---|---|
| `id`, `groups` | Display user and group identities |
| `newgrp` | Start a shell with a different active group |
| `ls -l`, `ls -la` | Inspect permissions, ownership, and hidden files |
| `chgrp` | Change group ownership |
| `chown` | Change user and/or group ownership |
| `chmod` | Change permissions using symbolic or octal notation |
| `umask` | Display or configure the default permission mask |

## 2. Users, Groups, and Ownership

Every Linux file and directory has a **user owner** and a **group owner**. Permission checks distinguish three classes:

- **User (`u`)**: the file's owner.
- **Group (`g`)**: users who belong to the file's owning group, when they are not the owner.
- **Others (`o`)**: users who match neither the owner nor the owning group.

```bash
id
id sysadmin
groups
groups sysadmin
newgrp developers
```

`id` shows numeric IDs and group memberships; `groups` shows group names. `newgrp` starts a new shell with the specified active group, provided the user is authorized to join it.

### Permission evaluation

Linux evaluates the applicable class rather than combining permissions across all classes. If a process matches the file owner, **user** bits apply, even if group or others have more permissive bits. Otherwise, if it matches the file's group, **group** bits apply; if neither matches, **others** bits apply. Privileged processes and additional access-control mechanisms may affect effective access.

For example:

```text
----rw-r-- 1 sysadmin developers 120 Oct 19 10:00 report.txt
```

The owner `sysadmin` has no permission bits (`---`) and cannot read this file through ordinary owner permission checks, even though the group has `rw-` and others have `r--`.

## 3. Reading Permission Strings

```bash
ls -l
ls -la
```

Example:

```text
-rwxr-xr-- 1 sysadmin developers 120 Oct 19 10:00 script.sh
```

- First character: object type (`-` regular file, `d` directory, `l` symbolic link).
- Next three characters: owner permissions (`rwx`).
- Next three: group permissions (`r-x`).
- Final three: others permissions (`r--`).
- Subsequent fields include link count, owner, group, size, modification time, and name.

`ls -a` includes names beginning with `.`, while `ls -l` shows ownership details. Use **`ls -la`** to show both hidden files and their ownership.

## 4. File and Directory Permissions

| Bit | Value | Regular file | Directory |
|---|---:|---|---|
| `r` | 4 | Read file contents | List entry names |
| `w` | 2 | Modify file contents | Create, delete, or rename entries, normally together with `x` |
| `x` | 1 | Execute the file as a program | Traverse the directory and access entries by name |

Directory permissions differ from file permissions. Reading directory names requires `r`; accessing a known entry requires `x`. Creating and deleting entries generally requires **both `w` and `x` on the containing directory**. Deleting a file is normally controlled by its parent directory, not by the file's own write bit. Other constraints, such as the sticky bit, may apply.

## 5. Changing Permissions with `chmod`

### 5.1 Symbolic notation

Symbolic mode uses `u`, `g`, `o`, or `a` (all), followed by an operator and permission letters.

| Operator | Meaning |
|---|---|
| `+` | Add the specified permission bits |
| `-` | Remove the specified permission bits |
| `=` | Set exactly the specified permission bits for the selected class |

```bash
chmod u+x script.sh
chmod g-w report.txt
chmod o=rx file
chmod ug+x,o-r file
chmod a+r file
```

**Important distinction:** `chmod o+rx file` adds read and execute but does not remove an existing write bit. To ensure the others class is exactly `r-x`, use `chmod o=rx file`.

Multiple classes and operations can be modified in one invocation. For example, `chmod ug+x,o-r file` adds execute for owner and group and removes read from others.

### 5.2 Octal notation

Each permission class uses a sum of `r=4`, `w=2`, and `x=1`.

| Octal | Symbolic | Meaning |
|---:|---|---|
| 0 | `---` | No permissions |
| 1 | `--x` | Execute only |
| 2 | `-w-` | Write only |
| 3 | `-wx` | Write and execute |
| 4 | `r--` | Read only |
| 5 | `r-x` | Read and execute |
| 6 | `rw-` | Read and write |
| 7 | `rwx` | Read, write, and execute |

```bash
chmod 644 report.txt   # rw-r--r--
chmod 755 script.sh    # rwxr-xr-x
chmod 700 private.sh   # rwx------
chmod 754 file         # rwxr-xr--
chmod 777 directory    # rwxrwxrwx
```

`777` grants all three classes full permissions; it is generally inappropriate for shared directories without additional safeguards. Use only the access necessary for the task.

### 5.3 Who may change permissions?

The file owner and a sufficiently privileged administrator (normally `root`) may change permissions with `chmod`. Merely belonging to the file's group does not authorize permission changes.

## 6. Changing Ownership with `chown` and `chgrp`

```bash
sudo chown sam myFile
sudo chown sam:administrators myFile
sudo chown :administrators myFile
chgrp developers myFile
```

- `chown sam myFile`: set the user owner to `sam`.
- `chown sam:administrators myFile`: set user owner to `sam` and group owner to `administrators`.
- `chown :administrators myFile`: change only the group owner.
- `chgrp developers myFile`: change only the group owner.

The legacy form `chown sam.administrators myFile` may also work, but the colon separator is preferred because dots may appear in account names.

Changing a file's user owner normally requires elevated privileges. A file owner may change its group to one of the groups they belong to, subject to system rules; `root` may set arbitrary group ownership.

For recursive ownership changes:

```bash
sudo chown -R sam:administrators project/
```

`-R` affects all entries beneath the specified directory. Check the path before running recursive operations.

## 7. Default Permissions and `umask`

Ordinary file creation starts from a maximum mode of `666` (`rw-rw-rw-`), while directory creation starts from `777` (`rwxrwxrwx`). The **umask** removes selected bits from those requested defaults.

```bash
umask
umask 022
touch example.txt
mkdir example-dir
ls -ld example.txt example-dir
```

With `umask 022`, typical resulting modes are:

| Object | Initial maximum | Mask | Result |
|---|---|---|---|
| Regular file | `666` | `022` | `644` (`rw-r--r--`) |
| Directory | `777` | `022` | `755` (`rwxr-xr-x`) |

The effective mode is computed by clearing masked bits from the mode requested by the creating program; it is not generally ordinary arithmetic subtraction. Newly created regular files do **not** receive execute permission by default through the usual `666` creation mode. Programs may explicitly request different modes or adjust permissions later.

Another common example is `umask 027`: typical new files are `640`, and directories are `750`.

## 8. Practical Inspection and Verification

```bash
id
ls -la
stat myFile
chmod 640 myFile
ls -l myFile
chgrp developers myFile
ls -l myFile
umask
```

Check the file owner and active group memberships before modifying access. Verify changes with `ls -l` or `stat` and distinguish directory access requirements from file access requirements.

## 9. Exam Review: Common Distinctions

| Question | Key rule |
|---|---|
| Set others to exactly `r-x` | `chmod o=rx file` |
| Change several permission classes at once | Combine classes or comma-separated symbolic operations |
| Does ownership guarantee reading? | No; the owner's read bit can be absent |
| Octal values | `r=4`, `w=2`, `x=1` |
| Allow all users to list, create, and delete directory entries | `777` provides the needed `rwx` to all classes |
| Who can run `chmod` on a file? | Owner or `root` |
| Are regular files executable by default? | Not with the usual `666` creation mode |
| Set user and group with `chown` | `chown sam:administrators myFile` |
| Can only `root` change group ownership? | No; the owner can select an eligible group |
| List hidden files with ownership | `ls -la` |

## 10. Key Takeaways

Linux permissions are based on the applicable owner, group, or others class. Permission bits have different meanings for regular files and directories. Use symbolic `chmod` when adjusting selected bits, octal `chmod` when setting complete permission modes, `chown` and `chgrp` for ownership, and `umask` to understand default creation permissions. Verify ownership and effective modes before and after changes.
