# Module 18 — Special Directories and Files

Study notes for **Cisco Networking Academy / NDG Linux Essentials**, Chapter 18. This module extends basic ownership and permission concepts with special permission bits, shared temporary directories, inodes, and file links.

## 1. Exam Objective and Scope

**LPI Linux Essentials — Objective 5.4: Special Directories and Files**  
**Weight:** 1

**Description:** Special directories and files on a Linux system, including special permissions.

**Key knowledge areas:**
- Using temporary files and directories (Section 18.4).
- Symbolic links (Section 18.5.2).

The chapter also explains setuid, setgid, the sticky bit, inodes, and hard links to provide the necessary context.

| Command or concept | Purpose |
|---|---|
| `chmod u+s`, `chmod g+s`, `chmod o+t` | Set special permission bits symbolically |
| `chmod 4755`, `chmod 2775`, `chmod 1777` | Set special permission bits numerically |
| `ls -ld` | Inspect the directory itself, rather than its contents |
| `/tmp`, `/var/tmp` | Shared locations for temporary files |
| `ls -i`, `ls -li` | Display inode numbers and link counts |
| `ln` | Create a hard link |
| `ln -s` | Create a symbolic link |

## 2. Special Permission Bits

Ordinary Linux permission bits (`r`, `w`, `x`) determine access for the owner, group, and others. Special permission bits provide additional behavior for executable files and shared directories.

| Special bit | Octal value | Display position | Main behavior |
|---|---:|---|---|
| setuid | `4000` | Owner execute position (`s`/`S`) | Executable runs with the file owner's effective identity |
| setgid | `2000` | Group execute position (`s`/`S`) | Executable runs with the file group's effective identity; directories pass their group to new entries |
| sticky bit | `1000` | Others execute position (`t`/`T`) | Restricts deletion or renaming of entries in shared directories |

A lowercase `s` indicates that the corresponding execute bit is also set; uppercase `S` indicates that it is not. Likewise, `t` means sticky bit plus others execute, while `T` means sticky bit without others execute.

The first octal digit encodes special bits, followed by the usual three permission digits. For example, `2775` means setgid (`2`) plus `rwxrwxr-x` (`775`).

## 3. Setuid on Executable Files

The **setuid** (set user ID) bit causes an executable program to run with the effective identity of the file's owner rather than the identity of the user who launched it.

A traditional example is the `passwd` program. Ordinary users cannot directly modify `/etc/shadow`, but `passwd` can perform the authorized password update using elevated effective permissions.

```bash
ls -l /etc/shadow
ls -l /usr/bin/passwd
```

Example listing from the course:

```text
-rwsr-xr-x 1 root root 31768 Jan 28 2010 /usr/bin/passwd
```

The `s` in `rws` identifies setuid in the owner execute position.

```bash
chmod u+s file       # Add setuid symbolically
chmod 4755 file      # Set setuid and mode 755 numerically
chmod u-s file       # Remove setuid symbolically
chmod 0755 file      # Set mode 755 without special bits
```

**Security note:** Do not experiment by applying setuid to system binaries. For demonstration, inspect the existing permissions instead. Modern systems may impose additional restrictions on setuid behavior; in particular, setting setuid on a shell script does not generally make the script execute with elevated privileges.

## 4. Setgid on Files and Directories

### 4.1. Setgid on executable files

On an executable file, **setgid** (set group ID) makes the program run with the effective group identity of the file's group owner.

The chapter uses `/usr/bin/wall` as an example of a program that can use the `tty` group's access to write messages to terminals. The precise mode of this program varies by distribution.

```bash
ls -l /usr/bin/wall
```

Course example:

```text
-rwxr-sr-x 1 root tty 30800 May 16 2018 /usr/bin/wall
```

Here, `r-s` is the group permission field: the lowercase `s` indicates group execution plus setgid.

### 4.2. Setgid on directories

When setgid is enabled on a directory, newly created files and subdirectories inherit the **group ownership of that directory**, rather than ordinarily receiving the creator's primary group. Newly created subdirectories also inherit the setgid bit.

```bash
mkdir -p shared
chmod 2775 shared
ls -ld shared

touch shared/report.txt
ls -l shared/report.txt
```

Representative directory mode:

```text
drwxrwsr-x 2 sysadmin developers 4096 Oct 19 10:00 shared
```

The new file inherits the `developers` group **if the directory belongs to that group**. The commands above do not themselves assign that group; the directory must already have the intended group owner, or an authorized administrator must configure it.

Setgid changes **group ownership**, not the file's read/write permissions. Collaboration still depends on the resulting group permission bits and the user's `umask`.

```bash
chmod g+s shared      # Enable setgid
chmod 2775 shared     # Set setgid with rwxrwxr-x
chmod g-s shared      # Disable setgid
chmod 0775 shared     # Clear special bits and use rwxrwxr-x
```

**Exam note:** Use `ls -ld shared` to see permissions of the directory itself. Plain `ls -l shared` lists its contents.

## 5. Sticky Bit and Shared Temporary Directories

A user with write and execute access to a directory can normally remove entries in that directory, even if the user does not own the files. The **sticky bit** restricts removal and renaming of entries: normally, only the file owner, directory owner, or privileged administrator can remove an entry.

The chapter's principal examples are `/tmp` and `/var/tmp`, which are shared locations for temporary files.

```bash
ls -ld /tmp /var/tmp
```

Typical permissions:

```text
drwxrwxrwt ... /tmp
drwxrwxrwt ... /var/tmp
```

The trailing `t` denotes the sticky bit with others execute permission. Octal mode `1777` combines sticky bit (`1000`) with `rwx` for all three classes (`777`).

```bash
mkdir -p temporary
chmod 1777 temporary
ls -ld temporary

chmod o+t temporary   # Enable sticky bit
chmod o-t temporary   # Disable sticky bit
```

| Directory | Course description | Typical retention distinction |
|---|---|---|
| `/tmp` | Temporary files accessible to multiple users | Often cleaned sooner; retention is system-dependent |
| `/var/tmp` | Temporary files accessible to multiple users | Typically retained longer, including across reboots |

**Important:** A sticky bit does not make file contents private. File read and write permissions still determine access to the files themselves. The sticky bit specifically protects directory entries against unauthorized removal or renaming.

## 6. Inodes and Hard Links

A file's **inode** holds metadata such as ownership, permissions, timestamps, and references to its data blocks. Directory entries associate filenames with inode numbers. An inode number is meaningful within its filesystem.

A **hard link** is an additional filename referencing the **same inode** as another filename. Neither name is inherently more original than the other.

```bash
printf 'Linux Essentials\n' > original.txt
ln original.txt hardlink.txt
ls -li original.txt hardlink.txt
```

Illustrative output:

```text
12345 -rw-r--r-- 2 sysadmin sysadmin 17 original.txt
12345 -rw-r--r-- 2 sysadmin sysadmin 17 hardlink.txt
```

Both entries show the same inode number (`12345`). The link count (`2`, between the permissions and owner) shows that two directory entries refer to the inode.

```bash
rm original.txt
cat hardlink.txt
```

The content remains available through `hardlink.txt`. Removing one filename does not remove the file's content while another hard link remains (or a process still holds the file open).

**Limitations:** Hard links cannot cross filesystem boundaries, and ordinary users cannot create hard links to directories. The chapter demonstrates finding hard links with `find` and the inode number:

```bash
ls -i hardlink.txt
find . -inum 12345
```

Replace `12345` with the inode number actually shown by `ls -i`.

## 7. Symbolic Links

A **symbolic link** (soft link) is a separate filesystem object that stores a path to its target. It does not share the target's inode.

```bash
printf 'Linux Essentials\n' > target.txt
ln -s target.txt shortcut.txt
ls -l shortcut.txt
cat shortcut.txt
```

Illustrative output:

```text
lrwxrwxrwx 1 sysadmin sysadmin 10 Oct 19 10:00 shortcut.txt -> target.txt
```

The leading `l` denotes a symbolic link, and `-> target.txt` displays its destination. The apparent `rwxrwxrwx` mode on a symbolic link does not mean all users can access the target: access is checked against the target and its containing directories.

If the target is deleted, the symbolic link remains but becomes **broken** (dangling):

```bash
rm target.txt
ls -l shortcut.txt
cat shortcut.txt     # Fails because the target no longer exists
```

Symbolic links may reference **directories** and targets on **other filesystems**. Relative symbolic link targets are interpreted relative to the directory containing the link, not the shell's current working directory.

## 8. Comparing Hard and Symbolic Links

| Property | Hard link | Symbolic link |
|---|---|---|
| Command | `ln target link_name` | `ln -s target link_name` |
| Reference | Same inode | Path to target |
| Shares target inode | Yes | No |
| Can cross filesystems | No | Yes |
| Can point to directories | Not ordinarily | Yes |
| Target filename removed | Remaining hard link still accesses data | Link becomes broken if the referenced path disappears |
| Inspection | `ls -li` shows matching inode numbers | `ls -l` shows `l` and `-> target` |

**Exam note:** In both commands, the existing target comes **first**, and the new link name comes **second**.

## 9. Practical Lab — Safe Workspace

Run this exercise in your home directory. It creates only disposable files under `~/module18-lab` and does not require `sudo`.

```bash
mkdir -p ~/module18-lab
cd ~/module18-lab

# Directory special permissions
mkdir -p shared temporary
chmod 2775 shared
chmod 1777 temporary
ls -ld shared temporary

# Inode and link behavior
printf 'Linux Essentials\n' > original.txt
ln original.txt hardlink.txt
ln -s original.txt symlink.txt
ls -li original.txt hardlink.txt symlink.txt

# Observe what happens after removing one filename
rm original.txt
cat hardlink.txt
ls -l symlink.txt
```

**Expected observations:** `shared` displays `s` in the group execute position, `temporary` displays `t` in the others execute position, the hard link and original share an inode, and the symbolic link becomes dangling after `original.txt` is removed.

This single-user exercise shows permission bits but cannot prove cross-user deletion restrictions. Testing those requires separate user accounts and a controlled environment.

## 10. Common Exam Pitfalls

- **`4000`, `2000`, and `1000` are different bits:** setuid, setgid, and sticky bit, respectively.
- **Setgid on a file is not setgid on a directory:** one affects the program's effective group; the other affects inherited group ownership.
- **`ls -ld` versus `ls -l`:** `-d` inspects the directory entry itself.
- **Sticky bit is not file confidentiality:** it restricts deletion/renaming in shared directories.
- **Hard links share an inode:** deleting one filename does not invalidate the other.
- **Symbolic links store a path:** deleting or moving the referenced target may break the link.
- **`ln` versus `ln -s`:** only `-s` requests a symbolic link.
- **A symbolic link can cross filesystems; a hard link cannot.**

## 11. Chapter Review — Questions 1–10

| Question | Correct answer | Reason |
|---|---|---|
| 1. Is `/tmp` designed for temporary files from any user? | **True** | It is a shared temporary directory. |
| 2. Which command sets sticky bit on `/shared`? | **`chmod 1777 /shared`** | `1` is the sticky-bit octal digit. |
| 3. What does setgid do? (Choose two) | **Files inherit the directory's group; executables run with the file group's effective identity** | Setgid has different directory and executable behaviors. |
| 4. Which listing shows setgid on `/shared`? | **`drwxrwsrwx`** | The `s` occupies the group execute position. |
| 5. What does setgid on a directory do? | **New files inherit the directory's group owner** | It changes default group inheritance. |
| 6. Must a hard link and its target be on the same filesystem? | **True** | Both names reference one filesystem's inode. |
| 7. Must a symbolic link and its target be on the same filesystem? | **False** | The link stores a pathname and can cross filesystems. |
| 8. Create hard link `link` to `file` | **`ln file link`** | `ln` creates a hard link by default. |
| 9. Create symbolic link `link` to `file` | **`ln -s file link`** | `-s` selects a symbolic link. |
| 10. Show information about the directory itself (choose two) | **`ls -ld`, `ls -d`** | `-d` selects the directory entry rather than its contents. |

## 12. Quick Reference

### Special permissions

| Task | Command |
|---|---|
| Inspect a directory's permissions | `ls -ld directory` |
| Enable setuid | `chmod u+s file` |
| Enable setgid | `chmod g+s file_or_directory` |
| Enable sticky bit | `chmod o+t directory` |
| Set setuid with mode `755` | `chmod 4755 file` |
| Set setgid with mode `775` | `chmod 2775 directory` |
| Set sticky bit with mode `777` | `chmod 1777 directory` |
| Remove special bits via full mode | `chmod 0755 file` |

### Links and inodes

| Task | Command |
|---|---|
| Display inode | `ls -i file` |
| Display inode and link count | `ls -li file` |
| Create hard link | `ln target link_name` |
| Create symbolic link | `ln -s target link_name` |
| Inspect symbolic link destination | `ls -l link_name` |
| Search by inode number | `find . -inum NUMBER` |

The central distinction in this chapter is **how special bits modify access behavior** and **how hard and symbolic links refer to files differently**. For the exam, recognize the permission characters (`s`, `S`, `t`, `T`), octal prefixes (`4`, `2`, `1`), and link commands (`ln`, `ln -s`).
