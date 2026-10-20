# Final Exam — Modules 10–18

Study notes and answer review for the Final Exam covering Modules 10–18 of the Cisco Networking Academy / NDG Linux Essentials course.

## 1. Exam Overview

**Course:** Cisco Networking Academy / NDG Linux Essentials

**Assessment:** Final Exam — Modules 10–18

**Questions Reviewed:** 40

**Exam Format:** Multiple-choice, multiple-answer, and true/false questions.

**Topics Covered:** Shell scripting and text processing; hardware and processes; networking; users and groups; permissions and special bits.


---

## 2. Shells, Text Processing, and Scripting

### Question 1 — Pipes

**Question:** What does the pipe (`|`) operator do?

**Correct Answer:** Sends the output of one command to the input of another command.

A pipeline such as `cat logfile | grep ERROR` passes standard output to the next command's standard input. It differs from file redirection (`>` and `>>`).

### Question 2 — Standard Error

**Question:** Which channel is standard error?

**Correct Answer:** Channel 2 (`STDERR`).

Standard file descriptors are `0` (stdin), `1` (stdout), and `2` (stderr). Example: `command 2>errors.log`.

### Question 3 — grep

**Question:** Which command displays lines matching a specified regular expression?

**Correct Answer:** `grep`

Use `grep -n 'error' logfile` to show matching lines with line numbers; `-i` ignores case.

### Question 4 — Pager Commands

**Question:** Which commands let you scroll through a text file? (choose two)

**Correct Answers:** `less` and `more`.

Both display long files page by page. `less` supports convenient backward navigation and searching.

### Question 5 — Line Numbers

**Question:** Which command prints line numbers?

**Correct Answer:** `nl`

`nl file.txt` numbers nonempty lines by default. `cat -n` numbers all lines.

### Question 6 — Shell Script Editors

**Question:** Which editors are suitable for writing shell scripts? (choose two)

**Correct Answers:** `vi` and `nano`.

Both edit plain-text files. `/bin/bash` is a shell interpreter, not a text editor.

### Question 7 — for and while Loops

**Question:** Which statements about `for` and `while` loops are correct? (choose two)

**Correct Answers:** A `while` loop tests a condition each cycle; a `for` loop operates over a specified list of items.

These are the introductory definitions expected by the exam. Bash also supports arithmetic `for ((...))` loops.

### Question 8 — Command Substitution

**Question:** Which expression saves the current working directory in variable `A`?

**Correct Answer:** `` A=`pwd` ``

Backticks perform command substitution. The modern equivalent is `A=$(pwd)`.

### Question 9 — Arithmetic Expansion

**Question:** What does `$(( $i + 1 ))` do?

**Correct Answer:** Calculates the value of `i` plus 1.

It does not change `i` by itself. Assignment requires `i=$((i + 1))`.

---

## 3. Hardware, Storage, and Processes

### Question 10 — CPU Architectures

**Question:** Which two CPU types are associated with Intel processors? (choose two)

**Correct Answers:** 64-bit and 32-bit.

Common x86 architecture names include `x86_64` (64-bit) and `i686` (32-bit).

### Question 11 — Virtual RAM

**Question:** Which statements describe virtual RAM? (choose three)

**Correct Answers:** It is stored on a hard drive; it is also called swap space; it is used when physical RAM is low.

**Technical note:** Swap can also be stored on an SSD, and virtual memory is a broader concept than swap.

### Question 12 — Disk Partitions

**Question:** What is a division of a hard drive called?

**Correct Answer:** Partition.

A partition is a logical region of a disk. Inspect partitions with `lsblk` or `sudo fdisk -l`.

### Question 13 — fdisk and MBR

**Question:** The `fdisk` command is a tool used for working with MBR-partitioned disks. True or False?

**Correct Answer:** True.

`fdisk` supports MBR and, in modern versions, GPT partition tables as well.

### Question 14 — CPU Information

**Question:** Which commands display CPU information? (choose two)

**Correct Answers:** `arch` and `lscpu`.

`arch` reports machine architecture; `lscpu` provides detailed CPU information.

### Question 15 — init PID

**Question:** What is the PID of the init process?

**Correct Answer:** `1`.

PID 1 is the initial userspace process, commonly `systemd` on modern systems. Check with `ps -p 1 -o pid,comm`.

### Question 16 — Log Directory

**Question:** Which directory typically contains log files?

**Correct Answer:** `/var/log`.

Many system and application logs are stored under `/var/log`. `journalctl` provides access to systemd journal records.

### Question 17 — Variable Data

**Question:** The `/var` directory contains files that change over time. True or False?

**Correct Answer:** True.

`/var` contains variable data such as logs, caches, service state, and spool files.

### Question 18 — Process Listing

**Question:** Which commands show all processes on the system? (choose two)

**Expected Answers:** `ps aux` and `ps -ef`.

**Question ambiguity:** `ps -A` and `ps -eLf` also select all processes; the latter additionally reports thread information. Thus four listed choices are technically valid, despite the instruction to choose two.

---

## 4. Networking and Remote Access

### Question 19 — Services

**Question:** A service is...

**Correct Answer:** A feature provided by one computer to another.

Examples include SSH, HTTP, DNS, and DHCP. Services are commonly provided by background daemon processes.

### Question 20 — Hostnames

**Question:** Only servers have hostnames. True or False?

**Correct Answer:** False.

Servers, laptops, workstations, and other devices can have hostnames. Use `hostname` to inspect the local hostname.

### Question 21 — IPv4 Addresses

**Question:** Which are valid IPv4 addresses? (choose two)

**Correct Answers:** `10.33.55.77` and `192.105.10.10`.

IPv4 dotted-decimal addresses have four octets ranging from 0 to 255. `192.301.25.25` has an invalid octet; `192.105.10.10.2` has five octets.

### Question 22 — Remote Login

**Question:** Which command allows you to log in to a remote machine?

**Correct Answer:** `ssh`.

Example: `ssh user@192.168.1.100`. SSH normally uses TCP port 22.

---

## 5. Users, Groups, and Account Management

### Question 23 — Account Information Files

**Question:** Which files contain user account information? (choose two)

**Correct Answers:** `/etc/passwd` and `/etc/shadow`.

`/etc/passwd` contains account metadata; `/etc/shadow` contains password hashes and password-aging information. `/etc/group` describes groups.

### Question 24 — User Identity

**Question:** Which command displays your UID, GID, and groups?

**Correct Answer:** `id`.

Use `id`, `id -u`, `id -g`, or `id -nG` to inspect user identity and group membership.

### Question 25 — Group Membership

**Question:** Each user belongs to at least one group. True or False?

**Correct Answer:** True.

Every account has a primary GID; supplementary group membership is optional.

### Question 26 — Root's Groups

**Question:** Which command displays the groups that root belongs to?

**Correct Answer:** `id root`.

This displays root's UID, primary GID, and group memberships. `groups root` is another valid way to show group names.

### Question 27 — Reserved UIDs

**Question:** UIDs 1–499 are usually reserved for what kind of users?

**Correct Answer:** System accounts, such as server processes.

This is a traditional course convention. Modern distributions may reserve UIDs below 1000 for system accounts.

### Question 28 — useradd UID Option

**Question:** Which `useradd` option specifies the UID?

**Correct Answer:** `-u`.

Example: `sudo useradd -u 1500 alice`. The `-g` option instead selects a primary group.

### Question 29 — Recent Login

**Question:** Which command determines a user's most recent login?

**Correct Answer:** `last`.

`last alice` lists recorded sessions for that user. `lastlog` is another utility for querying last-login information.

### Question 30 — Password Hashes

**Question:** Which file contains encrypted user password information?

**Correct Answer:** `/etc/shadow`.

More precisely, this file normally stores one-way password hashes, not reversibly encrypted passwords.

### Question 31 — Primary Group Option

**Question:** Which `useradd` option sets a different primary group?

**Correct Answer:** `-g`.

Example: `sudo useradd -g developers alice`. The `-G` option selects supplementary groups.

### Question 32 — Modify a User

**Question:** Which command modifies an existing user account?

**Correct Answer:** `usermod`.

Example: `sudo usermod -aG developers alice` adds a supplementary group without replacing existing group memberships.

---

## 6. File Permissions and Special Bits

### Question 33 — chmod Methods

**Question:** Which methods can set permissions using `chmod`? (choose two)

**Correct Answers:** Symbolic and octal.

Examples: `chmod u+x script.sh` (symbolic) and `chmod 755 script.sh` (octal).

### Question 34 — chown

**Question:** `chown` can change the owner and group of a file. True or False?

**Correct Answer:** True.

Example: `sudo chown alice:developers file.txt`. `chgrp` changes the group alone.

### Question 35 — Permission to Run chmod

**Question:** Who can use `chmod` on a file?

**Correct Answer:** The file owner and root.

Belonging to the file's group does not by itself permit changing its mode bits.

### Question 36 — Default Execute Permission

**Question:** The execute permission is never set on files by default. True or False?

**Correct Answer:** True (expected exam answer).

Ordinary files are normally created from a base mode of `666` before the umask is applied, so execute bits are absent. **Technical note:** Applications may explicitly create executable files or preserve existing execute permissions.

### Question 37 — Sticky Bit

**Question:** What does the sticky bit permission do?

**Correct Answer:** Prevents other users from removing files they do not own from a shared directory.

It also restricts renaming. `/tmp` commonly uses mode `1777`; the file owner, directory owner, and root are exceptions.

### Question 38 — SUID

**Question:** What does setuid permission do?

**Correct Answer:** Allows a command to run as the file owner.

More precisely, a SUID executable runs with the effective UID of its owner. The special octal bit is `4000`; symbolic notation is `chmod u+s program`.

### Question 39 — SGID

**Question:** What does setgid permission do? (choose two)

**Correct Answers:** Allows a command to run as the file's group owner; allows new files in a directory to inherit the directory's group.

SGID on an executable sets its effective GID; on a directory, it enables group inheritance. The special octal bit is `2000`.

### Question 40 — Directory Metadata

**Question:** Which `ls` commands show information about the directory itself? (choose two)

**Correct Answers:** `ls -ld` and `ls -d`.

The `-d` option lists the directory entry rather than its contents; `-l` adds detailed metadata.

---

## 7. Quick Reference

### Linux Commands

| Command | Purpose |
|---|---|
| `grep -n PATTERN file` | Show matching lines with line numbers |
| `less file` | Page through a file |
| `nl file` | Number text lines |
| `arch` | Show machine architecture |
| `lscpu` | Show CPU information |
| `lsblk` | List block devices |
| `ps aux` | List processes (BSD format) |
| `ps -ef` | List processes (full format) |
| `ps -A` | List all processes |
| `ssh user@host` | Log in remotely |
| `hostname` | Display hostname |
| `ip -4 addr` | Show IPv4 addresses |
| `id` | Show current UID, GID, and groups |
| `id root` | Show root account identity |
| `last` | Show login history |
| `sudo useradd -u 1500 alice` | Create account with specified UID |
| `sudo useradd -g developers alice` | Create account with specified primary group |
| `sudo usermod -aG developers alice` | Add supplementary group |
| `chmod u+x file` | Add owner execute permission |
| `chmod 755 file` | Set octal permissions |
| `sudo chown alice:developers file` | Change owner and group |
| `chmod +t directory` | Set sticky bit |
| `chmod g+s directory` | Set SGID |
| `ls -ld directory` | Show directory metadata |

### Essential Exam Associations

```text
STDIN             -> 0
STDOUT            -> 1
STDERR            -> 2
Pipe              -> |
PID of init       -> 1
Log directory     -> /var/log
Variable data     -> /var
IPv4              -> Four octets, each 0–255
Remote login      -> ssh
Account metadata  -> /etc/passwd
Password hashes   -> /etc/shadow
UID and groups    -> id
System UIDs       -> Traditionally 1–499
useradd -u        -> UID
useradd -g        -> Primary group
useradd -G        -> Supplementary groups
usermod           -> Modify account
chmod             -> Permissions
chown             -> Owner and group
SUID              -> 4000
SGID              -> 2000
Sticky bit        -> 1000
ls -d             -> Directory itself
```

---

## 8. Final Review Checklist

- [ ] I can distinguish pipelines, redirection, and standard streams.
- [ ] I can use `grep`, `less`, `more`, and `nl`.
- [ ] I understand shell loops, command substitution, and arithmetic expansion.
- [ ] I can identify CPU architecture, disk partitions, swap, and process IDs.
- [ ] I know the purposes of `/var` and `/var/log`.
- [ ] I can recognize valid IPv4 addresses and use SSH.
- [ ] I understand `/etc/passwd`, `/etc/shadow`, UID, GID, and groups.
- [ ] I can distinguish `useradd`, `usermod`, and their options.
- [ ] I can set symbolic and octal permissions with `chmod`.
- [ ] I understand `chown`, SUID, SGID, and sticky bit.
- [ ] I can explain the ambiguity in the process-listing question.

---

**Final Exam review complete — Modules 10–18.**
