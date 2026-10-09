# Midterm Exam — Modules 1–9

Study notes and answer review for the Midterm Exam covering Modules 1–9 of the Cisco Networking Academy / NDG Linux Essentials course.

## 1. Exam Overview

**Course:** Cisco Networking Academy / NDG Linux Essentials

**Assessment:** Midterm Exam — Modules 1–9

**Questions Reviewed:** 40

**Topics Covered:**
- Linux distributions and operating systems
- Software release and maintenance cycles
- Package management and desktop applications
- Network file sharing and virtualization
- Linux shells and command-line interfaces
- Open source software and licensing
- Environment variables and command execution
- Linux documentation and manual pages
- Filesystem navigation
- File and directory management
- Globbing and filename expansion
- File compression and archiving

**Exam Format:** Multiple-choice, multiple-answer, and true/false questions.

---

## 2. Linux Distributions and Software

### Question 1 — Linux on Mobile Devices

**Question:** The most popular Linux platform for mobile phones is:

**Correct Answer:** Android

Android uses the Linux kernel but is not a conventional GNU/Linux distribution.

### Question 2 — Release Cycle

**Question:** The release cycle:

**Correct Answer:** Dictates how often software is updated.

A release cycle defines how frequently new software versions are made available.

**Important distinction:**

- **Release cycle:** How frequently new versions are released.
- **Maintenance cycle:** How long a version receives maintenance and support.

### Question 3 — Package Management

**Question:** What does a distribution provide to add and remove software from the system?

**Correct Answer:** Package Manager

A package manager installs, updates, queries, and removes software packages. It can also manage dependencies.

| Distribution | Package Manager |
|---|---|
| Debian / Ubuntu | `apt` |
| Fedora | `dnf` |
| Arch Linux | `pacman` |
| openSUSE | `zypper` |

### Question 4 — Maintenance Cycle

**Question:** A maintenance cycle:

**Correct Answer:** Describes how long a version of software will be supported.

The maintenance cycle determines how long a software version receives security updates, bug fixes, and other maintenance.

Long-Term Support (LTS) releases generally provide extended maintenance periods.

### Question 5 — Choosing a Linux Distribution

**Question:** When choosing a distribution of Linux, you should consider: (choose five)

**Correct Answers:**

1. Will commercial support be required for the OS?
2. If the application software is supported by the distribution.
3. Does the distribution offer a stable version?
4. Does your organization require long-term support for the system?
5. Will users require a GUI?

**Incorrect Answer:** Popularity on social media.

A distribution should be selected according to technical requirements, application compatibility, stability, support, and user needs.

### Question 6 — Desktop Software

**Question:** Which of the following are examples of desktop software? (choose two)

**Correct Answers:**

- Music player
- Web browser

Desktop applications are typically designed for direct interaction with users.

Examples include Firefox, Chromium, VLC, and Rhythmbox.

### Question 7 — File Sharing Software

**Question:** Which of the following pieces of software deal with file sharing? (choose three)

**Correct Answers:**

- NFS
- Netatalk
- Samba

| Software | Purpose |
|---|---|
| NFS | Network file sharing, commonly between Unix/Linux systems |
| Netatalk | File sharing with Apple systems, traditionally through AFP |
| Samba | File and printer sharing through SMB/CIFS |

PostgreSQL is a database management system, while the X Window System provides graphical display functionality.

---

## 3. Shells, CLI, and Virtualization

### Question 8 — Linux Shell Capabilities

**Question:** The Linux shell: (choose three)

**Correct Answers:**

- Is customizable.
- Has a scripting language.
- Allows you to launch programs.

The shell can execute commands, automate tasks, and customize the user environment.

It is not inherently a text editor or a system configuration-file manager.

### Question 9 — Virtualization

**Question:** Virtualization means:

**Correct Answer:** A single host can be split up into multiple guests.

Virtualization allows multiple virtual machines to operate on a single physical host.

```text
Physical Host
     |
     v
 Hypervisor
     |
  +--+--+--+
  |  |  |  |
 VM1 VM2 VM3
```

**Important terms:**

- **Host:** Physical system providing resources.
- **Guest:** Virtual machine running on the host.
- **Hypervisor:** Software or platform responsible for managing virtual machines.

### Question 10 — Accessing a Shell in Graphical Mode

**Question:** In graphical mode, you can get to a shell by running which applications? (choose two)

**Correct Answers:**

- Xterm
- Terminal

Both are terminal emulators that provide access to a shell from a graphical desktop environment.

### Question 16 — PATH Environment Variable

**Question:** Which environment variable contains a list of directories that is searched for commands to execute?

**Correct Answer:** PATH

The `PATH` variable defines directories searched when a command is entered without an explicit path.

```bash
echo $PATH
```

Example:

```text
/usr/local/bin:/usr/bin:/bin
```

Directories are separated by colons (`:`).

### Question 17 — Locating an Executable

**Question:** Select the command that can report the location of a command.

**Correct Answer:** `which`

```bash
which ls
```

Possible output:

```text
/usr/bin/ls
```

The `which` command searches for an executable using `PATH`.

### Question 18 — Double Quotes

**Question:** A pair of double quotes (`" "`) will prevent the shell from interpreting any metacharacter.

**Correct Answer:** False

Double quotes suppress some shell interpretations, but variable expansion and command substitution still occur.

```bash
name="Linux"
echo "Hello $name"
```

Output:

```text
Hello Linux
```

Single quotes provide stronger literal quoting.

### Question 19 — Shell Interpretation

**Question:** The shell program interprets the commands you type into the terminal into instructions that the Linux operating system can execute.

**Correct Answer:** True

The shell parses commands, performs applicable expansions, and invokes built-in operations or external programs.

### Question 20 — CLI

**Question:** The acronym CLI stands for:

**Correct Answer:** Command Line Interface

A CLI is a text-based interface used to interact with an operating system.

| Term | Meaning |
|---|---|
| CLI | Command Line Interface |
| GUI | Graphical User Interface |
| Shell | Command interpreter |
| Terminal emulator | Application that provides terminal access |

### Question 21 — Common Linux Shell

**Question:** The most common shell used for Linux distributions is the ________ shell.

**Correct Answer:** Bash

Bash stands for **Bourne Again Shell**.

To display the user's configured login shell:

```bash
echo $SHELL
```

Possible output:

```text
/bin/bash
```

Other shells include Zsh, Fish, and tcsh.

---

## 4. Open Source and Licensing

### Question 11 — Source Code

**Question:** Source code refers to:

**Correct Answer:** A human-readable version of computer software.

Source code contains program instructions written in programming languages such as C, Python, and Java.

It differs from machine code, which contains instructions executed by a processor.

### Question 12 — Open Source

**Question:** Open source means: (choose two)

**Correct Answers:**

- You can modify the software's source code.
- You can view the software's source code.

Open source licenses also permit redistribution under their applicable conditions.

Open source software can be sold commercially. Its licensing terms do not necessarily require developers to provide technical support or publish private modifications.

### Question 13 — Copyleft

**Question:** A copyleft provision in a software license means:

**Correct Answer:** If you redistribute the software, you must distribute the source to any changes you make.

This is the expected exam answer.

More precisely, copyleft licenses such as the GPL impose source-code and licensing obligations when covered software or modified versions are distributed.

Private modifications generally do not trigger a requirement to publish source code.

### Question 14 — Linux Kernel License

**Question:** Linux is distributed under which license?

**Correct Answer:** GPLv2

The Linux kernel is primarily licensed under **GNU General Public License version 2**, with certain exceptions and additional notices.

A Linux distribution may contain other components distributed under different licenses.

### Question 15 — Creative Commons

**Question:** Creative Commons licenses allow you to: (choose three)

**Correct Answers:**

- Specify whether or not people may distribute changes.
- Allow or disallow commercial use.
- Specify whether or not changes must be shared under the same licensing terms.

| Element | Name | Meaning |
|---|---|---|
| BY | Attribution | Requires attribution |
| NC | NonCommercial | Restricts commercial use |
| ND | NoDerivatives | Restricts sharing adaptations |
| SA | ShareAlike | Requires adaptations to use the same or a compatible license |

Creative Commons licenses are commonly used for creative and educational works rather than software.

---

## 5. Linux Documentation and Help

### Question 22 — Pager Commands

**Question:** Which two pager commands are used by the man command to control movement within the document? (choose two)

**Correct Answers:**

- `more`
- `less`

Pagers display long documents one screen at a time.

The `man` command commonly uses `less`.

Useful `less` navigation keys:

| Key | Action |
|---|---|
| `Space` | Move forward one page |
| `b` | Move backward one page |
| `/pattern` | Search for a pattern |
| `n` | Find the next match |
| `q` | Quit |

### Question 23 — Searching Manual Descriptions

**Question:** To search the man page sections for the keyword `example`, which command lines could you execute? (choose two)

**Correct Answers:**

```bash
apropos example
man -k example
```

These commands search manual page names and descriptions.

**Important equivalences:**

```text
man -k = apropos
man -f = whatis
```

### Question 24 — man vs. info

**Question:** The statement that describes the difference between a man page and an info page is:

**Correct Answer:** The info page is like a guide; a man page is a more concise reference.

| Feature | man | info |
|---|---|---|
| Primary role | Command reference | Detailed documentation |
| Organization | Manual sections | Interconnected nodes |
| Typical presentation | Concise reference | Guide-like explanations |

Examples:

```bash
man ls
info ls
```

### Question 25 — Manual Page Sections

**Question:** The following sections commonly appear on a man page: (choose three)

**Correct Answers:**

- DESCRIPTION
- NAME
- SYNOPSIS

| Section | Purpose |
|---|---|
| NAME | Command name and short description |
| SYNOPSIS | Command syntax |
| DESCRIPTION | Detailed command behavior |

`LICENSE` may appear in some documentation but is not one of the three standard sections expected by this question.

---

## 6. Filesystem Navigation

### Question 26 — Root Directory

**Question:** The top-level directory on a Linux system is represented as:

**Correct Answer:** `/`

The forward slash represents the root of the Linux filesystem hierarchy.

```text
/
├── etc/
├── home/
│   └── student/
├── root/
├── tmp/
└── usr/
```

**Important distinction:**

- `/`: Filesystem root.
- `/root`: Home directory of the root user.
- `/home`: Common parent directory for regular users' home directories.

**Question note:** The provided answer options omitted `/`, but it is the technically correct answer.

### Question 27 — Tilde

**Question:** The tilde (`~`) is used to represent:

**Correct Answer:** A user's home directory.

```bash
cd ~
```

For example, `~` may expand to `/home/student`.

### Question 28 — cd Without Arguments

**Question:** The `cd` command by itself will take you to what directory?

**Correct Answer:** Your home directory.

```bash
cd
```

This normally has the same effect as:

```bash
cd ~
```

### Question 29 — Changing Directories

**Question:** What command will allow you to change your current working directory?

**Correct Answer:** `cd`

```bash
cd Documents
pwd
```

The `cd` command changes directories; `pwd` displays the current working directory.

### Question 30 — First Character in ls -l

**Question:** The first character in a long listing (`ls -l`) indicates:

**Correct Answer:** If something is a file, directory, or symbolic link.

Example:

```text
-rw-r--r--  file.txt
drwxr-xr-x  Documents
lrwxrwxrwx  shortcut -> file.txt
```

| First Character | File Type |
|---|---|
| `-` | Regular file |
| `d` | Directory |
| `l` | Symbolic link |
| `c` | Character device |
| `b` | Block device |

The following nine characters represent file permissions.

---

## 7. Managing Files and Globbing

### Question 31 — Renaming Files

**Question:** Which command can be used to rename a file?

**Correct Answer:** `mv`

```bash
mv oldname.txt newname.txt
```

The `mv` command can move or rename files and directories.

### Question 32 — touch

**Question:** The `touch` command can be used to: (choose two)

**Correct Answers:**

- Create new files.
- Update the timestamp of existing files.

```bash
touch notes.txt
```

If `notes.txt` does not exist, an empty file is created.

If it exists, its access and modification timestamps are normally updated without changing its contents.

### Question 33 — Glob Characters

**Question:** Which of the following are glob characters? (choose three)

**Correct Answers:**

- Asterisk (`*`)
- Question mark (`?`)
- Square brackets (`[ ]`)

| Pattern | Meaning |
|---|---|
| `*` | Zero or more characters |
| `?` | Exactly one character |
| `[abc]` | One character from the set |
| `[a-z]` | One character from the range |

The dash (`-`) is not a standalone glob character, although it can indicate a range inside brackets.

### Question 34 — Purpose of Globbing

**Question:** The main purpose of using glob characters is to be able to provide a list of filenames to a command.

**Correct Answer:** True

The shell expands filename patterns into matching pathnames.

```bash
ls *.txt
```

For example, the shell may expand this into:

```bash
ls notes.txt report.txt
```

### Question 35 — Asterisk

**Question:** The asterisk character is used to represent zero or more of any character in a filename.

**Correct Answer:** True

For example:

```bash
ls file*.txt
```

This may match:

```text
file.txt
file1.txt
file123.txt
```

By default, `*` does not match leading dots in hidden filenames.

---

## 8. Compression and Archiving

### Question 36 — How Compression Works

**Question:** Compression of a file works by:

**Correct Answer:** Removing redundant information.

Compression reduces the storage required for data by representing repeated or predictable information more efficiently.

**Important distinction:**

- **Compression:** Reduces data size.
- **Archiving:** Combines files and directories into an archive.

### Question 37 — Lossy Compression

**Question:** Lossy compression: (choose three)

**Correct Answers:**

- Is often used with images.
- Usually results in better compression than lossless.
- Sacrifices some quality.

| Feature | Lossy | Lossless |
|---|---|---|
| Exact restoration | No | Yes |
| Information discarded | Yes | No |
| Typical applications | Images, audio, video | Documents, programs, backups |
| Examples | JPEG, MP3 | gzip, bzip2, xz |

Lossy compression can achieve smaller file sizes by discarding information considered less important.

### Question 38 — Compression Commands

**Question:** Which commands can be used to compress a file? (choose three)

**Correct Answers:**

- `zip`
- `bzip2`
- `gzip`

| Compression | Decompression |
|---|---|
| `gzip` | `gunzip` |
| `bzip2` | `bunzip2` |
| `xz` | `unxz` |
| `zip` | `unzip` |

`cat` does not compress files, and `bunzip2` is a decompression command.

### Question 39 — Main tar Modes

**Question:** The three main modes of `tar` are: (choose three)

**Correct Answers:**

- Extract
- List
- Create

| Mode | Option | Example |
|---|---|---|
| Create | `-c` | `tar -cf backup.tar folder/` |
| List | `-t` | `tar -tf backup.tar` |
| Extract | `-x` | `tar -xf backup.tar` |

Compression can be combined with these modes, but it is not one of the three main modes.

### Question 40 — tar -f Option

**Question:** In `tar -czf foo.tar.gz bar`, what is the purpose of the `f` flag?

**Correct Answer:** Tells tar to write to the file that follows the flag.

Command:

```bash
tar -czf foo.tar.gz bar
```

| Component | Meaning |
|---|---|
| `-c` | Create an archive |
| `-z` | Use gzip compression |
| `-f` | Specify the archive filename |
| `foo.tar.gz` | Output archive |
| `bar` | File or directory to archive |

The `-f` option specifies the archive filename. In create mode, the archive is written to that file.

---

## 9. Quick Reference

### Linux Commands

| Command | Purpose |
|---|---|
| `echo $PATH` | Display executable search paths |
| `which command` | Locate an executable |
| `echo $SHELL` | Display configured login shell |
| `man command` | Open a manual page |
| `info command` | Open Info documentation |
| `apropos keyword` | Search manual descriptions |
| `man -k keyword` | Search manual descriptions |
| `whatis command` | Display a brief manual description |
| `cd` | Change to the home directory |
| `cd ..` | Move to the parent directory |
| `cd /` | Change to the filesystem root |
| `pwd` | Display the current directory |
| `ls -l` | Display a long directory listing |
| `mv old new` | Rename or move a file |
| `touch file` | Create a file or update timestamps |
| `gzip file` | Compress with gzip |
| `bzip2 file` | Compress with bzip2 |
| `zip archive.zip file` | Create or update a ZIP archive |
| `tar -cf archive.tar folder/` | Create a TAR archive |
| `tar -tf archive.tar` | List TAR contents |
| `tar -xf archive.tar` | Extract TAR contents |
| `tar -czf archive.tar.gz folder/` | Create a gzip-compressed TAR archive |

### Essential Exam Associations

```text
Android            -> Mobile Linux-based platform
Release cycle      -> Frequency of new versions
Maintenance cycle  -> Duration of support
Package manager    -> Install, update, remove software
NFS                -> Unix/Linux network file sharing
Samba              -> SMB/CIFS file sharing
Netatalk           -> Apple file sharing
Bash               -> Bourne Again Shell
CLI                -> Command Line Interface
PATH               -> Executable search directories
which              -> Executable location
GPLv2              -> Linux kernel license
Copyleft           -> Redistribution obligations
man -k             -> apropos
man -f             -> whatis
/                  -> Filesystem root
~                  -> User's home directory
cd                 -> Change directory
mv                 -> Move or rename
touch              -> Create file or update timestamps
*                  -> Zero or more characters
?                  -> Exactly one character
[ ]                -> Character set or range
tar -c             -> Create
tar -t             -> List
tar -x             -> Extract
tar -f             -> Archive filename
tar -z             -> gzip
tar -j             -> bzip2
```

---

## 10. Final Review Checklist

- [ ] I can distinguish a release cycle from a maintenance cycle.
- [ ] I understand package managers and distribution selection criteria.
- [ ] I can identify desktop software and file-sharing technologies.
- [ ] I understand the basic concepts of virtualization.
- [ ] I can explain the purpose of the shell, terminal, and CLI.
- [ ] I know how `PATH` and `which` work.
- [ ] I understand the difference between single and double quotes.
- [ ] I can distinguish source code, machine code, and software licenses.
- [ ] I know the meaning of copyleft and GPLv2.
- [ ] I recognize the main Creative Commons license elements.
- [ ] I can use `man`, `info`, `apropos`, and `whatis`.
- [ ] I know the common sections of a man page.
- [ ] I understand the filesystem root, home directories, and relative paths.
- [ ] I can navigate directories with `cd`.
- [ ] I can identify file types using `ls -l`.
- [ ] I can rename files using `mv`.
- [ ] I understand the two main uses of `touch`.
- [ ] I can use `*`, `?`, and `[ ]` for filename globbing.
- [ ] I understand lossless and lossy compression.
- [ ] I can identify compression and decompression commands.
- [ ] I know the three main `tar` modes and the purpose of `-f`.

---

**Midterm Exam review complete — Modules 1–9.**
