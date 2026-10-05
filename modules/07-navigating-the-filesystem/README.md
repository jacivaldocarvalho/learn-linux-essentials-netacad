# Module 7 — Navigating the Filesystem

Study notes for Chapter 7 of the Cisco Networking Academy / NDG Linux Essentials course.

## Exam Objective

### 2.3 — Using Directories and Listing Files

**Weight:** 2

**Description:** Navigation of home and system directories and listing files in various locations.

### Key Knowledge Areas

- Files and directories
- Hidden files and directories
- Home directories
- Absolute and relative paths
- Directory navigation
- Listing files and directories
- Recursive listings
- Sorting directory listings

### Key Commands and Symbols

| Command / Symbol | Purpose |
|---|---|
| `pwd` | Print the current working directory |
| `cd` | Change the current working directory |
| `ls` | List directory contents |
| `/` | Root directory and path separator |
| `~` | Current user's home directory |
| `~user` | Home directory of a specific user |
| `.` | Current directory |
| `..` | Parent directory |

---

## 1. Linux Filesystem Structure

Linux organizes files and directories in a hierarchical filesystem.

A **file** stores data such as text, programs, images, or other information. A **directory** is a special type of file used to organize files and other directories.

Conceptually:

```text
Linux Filesystem
│
├── files
│   └── store data
│
└── directories
    └── organize files and directories
```

Unlike systems that expose storage using drive letters such as `C:` or `D:`, Linux presents a single filesystem hierarchy beginning at the **root directory**:

```text
/
```

A typical structure looks like:

```text
/
├── bin/
├── boot/
├── dev/
├── etc/
├── home/
├── lib/
├── media/
├── mnt/
├── opt/
├── proc/
├── root/
├── run/
├── sbin/
├── srv/
├── sys/
├── tmp/
├── usr/
└── var/
```

Mounted filesystems and devices become accessible at locations within this hierarchy rather than through drive letters.

The root directory can be listed with:

```bash
ls /
```

For example, `/boot` contains files related to the system boot process.

---

## 2. Home Directories

On most Linux distributions, regular users have personal directories located under `/home`.

For example:

```text
/
└── home/
    ├── sysadmin/
    ├── bob/
    └── alice/
```

For the `sysadmin` user:

```text
/home/sysadmin
```

is the user's **home directory**.

It is important to distinguish `/home` from a user's home directory:

```text
/home
└── commonly contains user home directories

/home/sysadmin
└── home directory of sysadmin
```

Users normally begin a shell session in their home directory and generally have control over creating and deleting files there.

### Home Directory Shortcuts

The tilde `~` represents the current user's home directory.

For `sysadmin`:

```text
~  →  /home/sysadmin
```

A tilde followed by a username refers to that user's home directory:

```text
~bob  →  /home/bob
```

Therefore:

```bash
cd ~bob
```

changes to Bob's home directory, assuming it exists and is accessible.

---

## 3. Current Working Directory

A shell always has a **current working directory**.

The `pwd` command displays its complete path:

```bash
pwd
```

Example:

```text
/home/sysadmin
```

`pwd` stands for **print working directory**.

Conceptually:

```text
Filesystem
    │
    └── current location
            │
            └── pwd displays it
```

A useful association is:

```text
pwd → Where am I?
```

---

## 4. Changing Directories

The `cd` command changes the current working directory.

General syntax:

```text
cd [options] [path]
```

For example:

```bash
cd Documents
```

If the user begins in `/home/sysadmin`, the new location becomes:

```text
/home/sysadmin/Documents
```

A successful `cd` normally produces no output.

Running `cd` without an argument returns to the current user's home directory:

```bash
cd
```

If the specified directory cannot be found, an error is displayed:

```text
-bash: cd: Junk: No such file or directory
```

A useful association is:

```text
pwd → display the current directory
cd  → change the current directory
```

---

## 5. Paths

A **path** describes the location of a file or directory in the filesystem.

Directory components are separated by `/`.

For example:

```text
/home/sysadmin
```

can be read as:

```text
/
└── home/
    └── sysadmin/
```

Paths can identify directories or files:

```text
/home/sysadmin/file.txt
```

There are two major types:

```text
Paths
├── Absolute
└── Relative
```

---

## 6. Absolute Paths

An **absolute path** specifies a location beginning at the root directory.

It therefore starts with `/`.

Examples:

```text
/home/sysadmin
/etc
/usr/bin
/var/log
```

For example:

```bash
cd /home/sysadmin
```

means:

```text
/
└── home/
    └── sysadmin/
```

The current working directory does not change the meaning of an absolute path.

Rule:

```text
Starts with /
     │
     └── Absolute Path
```

---

## 7. Relative Paths

A **relative path** is interpreted from the current working directory.

It does not begin with `/`.

Suppose the current directory is:

```text
/home/sysadmin/Documents
```

with this structure:

```text
Documents/
├── School/
│   ├── Art/
│   ├── Engineering/
│   └── Math/
└── Work/
```

The command:

```bash
cd School/Art
```

uses the relative path:

```text
School/Art
```

and results in:

```text
/home/sysadmin/Documents/School/Art
```

Compare:

```text
Absolute:
/home/sysadmin/Documents/School/Art

Relative:
School/Art
```

The same relative path may refer to different locations depending on the current working directory.

---

## 8. Path Shortcuts

Linux provides shortcuts that are especially useful in relative paths.

### Parent Directory — `..`

Two dots represent the directory immediately above the current directory:

```text
.. → parent directory
```

For example:

```text
/home/sysadmin/Documents/School/Art
                              │
                           cd ..
                              ▼
/home/sysadmin/Documents/School
```

Multiple `..` components can be combined.

From:

```text
/home/sysadmin/Documents/School
```

the command:

```bash
cd ../../Downloads
```

is resolved as:

```text
/home/sysadmin/Documents/School
                 │
                 │ ..
                 ▼
/home/sysadmin/Documents
                 │
                 │ ..
                 ▼
/home/sysadmin
                 │
                 │ Downloads
                 ▼
/home/sysadmin/Downloads
```

### Current Directory — `.`

A single dot represents the current directory:

```text
. → current directory
```

Therefore:

```text
.   → current directory
..  → parent directory
```

These symbols are filesystem path components and are not limited to the `cd` command.

---

## 9. Listing Files and Directories

The `ls` command lists directory contents.

General syntax:

```text
ls [OPTION]... [FILE]...
```

Without arguments:

```bash
ls
```

it lists the current directory.

A path can also be supplied:

```bash
ls /var
```

This displays `/var` without changing the current working directory.

A useful command summary is:

| Command | Meaning |
|---|---|
| `pwd` | Where am I? |
| `cd` | Change where I am |
| `ls` | What is here? |

---

## 10. Colored `ls` Output and Aliases

Some Linux environments display different file types using different colors.

This behavior may come from an alias such as:

```text
ls → ls --color=auto
```

The command:

```bash
type ls
```

can reveal whether `ls` is an alias.

For example:

```text
ls is aliased to `ls --color=auto'
```

The coloring is therefore not an inherent requirement of a plain `ls` invocation.

In Bash, an alias can be bypassed for a command invocation with:

```bash
\ls
```

Conceptually:

```text
ls
└── alias expansion
    └── ls --color=auto

\ls
└── bypass alias expansion
```

---

## 11. Hidden Files

Linux treats names beginning with `.` as hidden.

Examples:

```text
.bashrc
.profile
.cache
```

A normal:

```bash
ls
```

omits hidden entries.

Use:

```bash
ls -a
```

to include them.

`-a` means **all**.

The output also includes:

```text
.
..
```

because these names begin with a dot.

Recall:

```text
.   → current directory
..  → parent directory
```

Many hidden files in a user's home directory contain application or shell configuration. For example, `.bashrc` is commonly used for Bash customizations such as variables and aliases.

---

## 12. Long Listings and Metadata

Files have associated information called **metadata**.

Use:

```bash
ls -l
```

to display the long listing format.

Consider:

```text
-rw-r----- 1 syslog adm 14185 Dec 15 16:38 syslog
```

The fields are:

```text
-rw-r-----  1  syslog  adm  14185  Dec 15 16:38  syslog
│           │    │      │     │         │           │
│           │    │      │     │         │           └─ name
│           │    │      │     │         └───────────── timestamp
│           │    │      │     └─────────────────────── size
│           │    │      └───────────────────────────── group owner
│           │    └──────────────────────────────────── user owner
│           └───────────────────────────────────────── hard link count
└───────────────────────────────────────────────────── type + permissions
```

The first ten characters consist of:

```text
-rw-r-----
│└───────┘
│    │
│    └── permissions
│
└── file type
```

### File Types

The first character indicates the file type.

| Symbol | File Type | Purpose |
|---|---|---|
| `-` | Regular file | Ordinary data file |
| `d` | Directory | Contains directory entries |
| `l` | Symbolic link | Points to another pathname |
| `s` | Socket | Interprocess communication |
| `p` | Pipe | Interprocess communication |
| `b` | Block device | Device interface using blocks |
| `c` | Character device | Device interface using character streams |

For example:

```text
-rw-r--r--  → regular file
drwxr-xr-x  → directory
lrwxrwxrwx  → symbolic link
```

### Permissions

The next nine characters represent file permissions:

```text
drwxr-xr-x
│└───────┘
│    │
│    └── permissions
│
└── type
```

### Hard Link Count

The number after the permissions represents the hard link count:

```text
-rw-r----- 1 syslog adm ...
            ↑
       hard link count
```

### User and Group Owners

Every file has a user owner and group owner:

```text
-rw-r----- 1 syslog adm ...
              │     │
              │     └── group owner
              └──────── user owner
```

### File Size

For regular files, the size field is normally displayed in bytes:

```text
-rw-r----- 1 syslog adm 14185 ...
                          ↑
                         size
```

For directories, this value must not be interpreted as the total size of everything stored below the directory.

### Timestamp

The timestamp normally represents the last modification of file contents.

For directories, it reflects changes to the directory entries, such as adding or removing a file.

### File Name

The final field identifies the file or directory:

```text
-rw-r--r-- ... bootstrap.log
               └───────────┘
                    name
```

For a symbolic link, `ls -l` can show the link and its target:

```text
link-name -> target-path
```

---

## 13. Human-Readable File Sizes

Long listings normally show file sizes in bytes.

For example:

```text
292584
```

The `-h` option provides a **human-readable** representation when used with the long listing format:

```bash
ls -lh
```

For example:

```text
292584 → 286K
```

The options mean:

```text
-l → long listing
-h → human-readable sizes
```

Short options can be combined:

```bash
ls -lh
```

This changes only the presentation of the size, not the file itself.

---

## 14. Listing a Directory Itself

Normally, `ls` applied to a directory lists its contents.

The `-d` option causes the directory entry itself to be listed instead.

For the current directory:

```bash
ls -d
```

produces:

```text
.
```

because:

```text
. → current directory
```

The option becomes especially useful with `-l`:

```bash
ls -ld
```

Compare:

```text
ls -l
└── metadata for entries inside the directory

ls -ld
└── metadata for the directory itself
```

For example:

```text
drwxr-xr-x 1 sysadmin sysadmin 224 Nov 7 17:07 .
```

The final `.` indicates that the metadata belongs to the current directory.

---

## 15. Recursive Listings

A **recursive listing** displays a directory and then recursively displays the contents of its subdirectories.

Use:

```bash
ls -R
```

The option uses an uppercase `R`.

For example:

```bash
ls -R /etc/ppp
```

may traverse:

```text
/etc/ppp/
├── ip-down.d/
│   └── bind9
└── ip-up.d/
    └── bind9
```

Conceptually:

```text
directory/
├── list entries
│
├── subdirectory/
│   └── list entries
│
└── subdirectory/
    └── list entries
```

Recursive listings should be used carefully on large directory trees. Starting at `/`, for example, can produce a very large amount of output and may traverse mounted filesystems as well.

---

## 16. Sorting Listings

By default, `ls` sorts entries alphabetically by name.

Several options change the sorting behavior.

### Sort by Size — `-S`

Uppercase `-S` sorts by size, largest first:

```bash
ls -S
```

It is especially useful with a long listing:

```bash
ls -lS
```

Conceptually:

```text
largest
   ↓
   ↓
smallest
```

Human-readable sizes can also be included:

```bash
ls -lSh
```

### Sort by Modification Time — `-t`

The `-t` option sorts by modification time, with the most recently modified entries first:

```bash
ls -lt
```

```text
newest
  ↓
  ↓
oldest
```

### Reverse Sort — `-r`

The `-r` option reverses the sorting order.

For example:

```bash
ls -lrS
```

sorts by size from smallest to largest:

```text
smallest
   ↓
largest
```

Similarly:

```bash
ls -lrt
```

sorts by modification time from oldest to newest:

```text
oldest
  ↓
newest
```

### Full Modification Time

The `--full-time` option displays a detailed timestamp:

```bash
ls --full-time
```

For example:

```text
2018-07-19 06:52:16.000000000 +0000
```

It uses the long listing format.

It can also be combined with time sorting:

```bash
ls -t --full-time
```

---

## 17. `ls` Options Reference

| Option | Meaning | Example |
|---|---|---|
| `-a` | Show all entries, including hidden ones | `ls -a` |
| `-l` | Use long listing format | `ls -l` |
| `-h` | Show human-readable sizes with long output | `ls -lh` |
| `-d` | List a directory itself instead of its contents | `ls -ld` |
| `-R` | List directories recursively | `ls -R` |
| `-S` | Sort by size, largest first | `ls -lS` |
| `-t` | Sort by modification time, newest first | `ls -lt` |
| `-r` | Reverse the sorting order | `ls -lrt` |
| `--full-time` | Show detailed timestamps in long format | `ls --full-time` |
| `--color=auto` | Use colored output when appropriate | `ls --color=auto` |

Common combinations:

| Command | Result |
|---|---|
| `ls -la` | Long listing including hidden entries |
| `ls -lh` | Long listing with human-readable sizes |
| `ls -ld` | Metadata for a directory itself |
| `ls -lS` | Long listing sorted largest to smallest |
| `ls -lSh` | Size-sorted long listing with readable sizes |
| `ls -lt` | Long listing sorted newest to oldest |
| `ls -lrS` | Long listing sorted smallest to largest |
| `ls -lrt` | Long listing sorted oldest to newest |

Remember that Linux command-line options are case-sensitive:

```text
-S → sort by size
-R → recursive listing
```

---

## 18. Navigation Reference

The core navigation concepts can be summarized as:

```text
/
│
└── home/
    └── sysadmin/       ← ~
        ├── Documents/
        │   └── School/
        │       └── Art/
        └── Downloads/
```

From `/home/sysadmin/Documents/School/Art`:

```text
.    → /home/sysadmin/Documents/School/Art
..   → /home/sysadmin/Documents/School
../.. → /home/sysadmin/Documents
~    → /home/sysadmin
```

Path rules:

| Form | Meaning |
|---|---|
| `/` | Root directory |
| `/path/to/item` | Absolute path |
| `path/to/item` | Relative path |
| `.` | Current directory |
| `..` | Parent directory |
| `~` | Current user's home |
| `~bob` | Bob's home directory |

---

## 19. Exam-Focused Review

### Filesystem and Paths

```text
/        → root directory
~        → current user's home directory
~user    → specified user's home directory
.        → current directory
..       → parent directory
```

An **absolute path**:

```text
/etc/ppp
```

starts with `/`.

A **relative path**:

```text
../../home/sysadmin
```

does not start with `/` and is resolved from the current directory.

### Core Commands

```text
pwd → print current working directory
cd  → change current working directory
ls  → list directory contents
```

### Important `ls` Options

```text
-a → all, including hidden entries
-l → long listing
-h → human-readable sizes
-d → directory itself
-R → recursive
-S → sort by size
-t → sort by modification time
-r → reverse sort
```

### Hidden Files

A hidden file or directory begins with:

```text
.
```

Example:

```text
.bashrc
```

Use:

```bash
ls -a
```

to display hidden entries.

### Long Listing

Remember the basic structure:

```text
-rw-r----- 1 syslog adm 14185 Dec 15 16:38 syslog
│└───────┘ │   │     │    │        │          │
│    │      │   │     │    │        │          └─ name
│    │      │   │     │    │        └──────────── timestamp
│    │      │   │     │    └───────────────────── size
│    │      │   │     └────────────────────────── group
│    │      │   └──────────────────────────────── user
│    │      └──────────────────────────────────── hard links
│    └─────────────────────────────────────────── permissions
└──────────────────────────────────────────────── file type
```

---

## 20. Knowledge Check Review

Key answers from this module:

1. Display all files, including hidden files:

   ```text
   ls -a
   ```

2. `/etc/ppp` is an **absolute path** because it begins with `/`.

3. `../../home/sysadmin` is a **relative path** because it does not begin with `/`.

4. `~` represents a user's **home directory**.

5. From the root account, Bob's home can be addressed using either:

   ```bash
   cd /home/bob
   ```

   or:

   ```bash
   cd ~bob
   ```

6. `..` represents the **parent directory**.

7. `..` is a path component representing the directory above the current directory; its meaning is not limited to `cd`.

8. `ls` without arguments lists the **current directory**.

9. Human-readable sizes in a long listing use:

   ```bash
   ls -lh
   ```

10. The statement that plain `ls` color-codes results by default is **false**. Environments commonly provide this behavior through `--color=auto`, often via an alias.

---

## Quick Reference

```text
Navigation
──────────
pwd             current working directory
cd DIR          change directory
cd              go to home directory
cd ..           go to parent directory

Paths
─────
/               root
~               current user's home
~user           another user's home
.               current directory
..              parent directory

Listing
───────
ls              list current directory
ls PATH         list specified path
ls -a           include hidden entries
ls -l           long listing
ls -lh          readable sizes
ls -ld          directory itself
ls -R           recursive listing
ls -lS          largest → smallest
ls -lt          newest → oldest
ls -lrS         smallest → largest
ls -lrt         oldest → newest
```

The central model for filesystem navigation is:

```text
             Linux Filesystem
                    │
                    ▼
                    /
                    │
          ┌─────────┴─────────┐
          │                   │
        home                 etc
          │
       sysadmin  ← ~
          │
    ┌─────┴─────┐
Documents    Downloads
    │
  School
    │
   Art

pwd → identify current location
cd  → change current location
ls  → inspect a location
```
