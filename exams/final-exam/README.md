# Linux Essentials — Final Exam Review

Study notes and answer review for the **Cisco Networking Academy / NDG Linux Essentials** final assessment.

## 1. Exam Overview

| Item | Details |
|---|---|
| Course | Linux Essentials |
| Assessment | Final Exam |
| Coverage | Linux concepts, shell commands, files, processes, networking, users, groups, and permissions |


## 2. Learning Objectives and Topics

This assessment reviews concepts from the Linux Essentials curriculum, including:

1. Linux distributions, operating systems, virtualization, and cloud computing.
2. Open-source licensing, free software, copyleft, and public-domain software.
3. Shell fundamentals, command-line documentation, globbing, and regular expressions.
4. Files, directories, archives, compression, and shell scripting.
5. Processes, system information, kernel interfaces, and networking.
6. User and group administration, authentication, and privilege escalation.
7. File permissions, special permission bits, and hard and symbolic links.

These are topic summaries based on the reviewed questions, **not a reproduction of an official weighted exam blueprint**.

## 3. Answer Review — Questions 1–50

The answers below reflect the questions discussed during the review. They are paraphrased for study rather than reproduced as an official question bank.

| # | Topic / Question Summary | Reviewed Answer |
|---:|---|---|
| 1 | Kernel bundled with tools and applications | Linux distribution |
| 2 | Meaning of a software release cycle | Frequency of software releases/upgrades |
| 3 | Microsoft Windows characteristics (choose three) | Desktop/server editions; backward compatibility; PowerShell |
| 4 | Main Unix/Linux shell families | Bourne Shell and C Shell |
| 5 | Virtualization host and guest (choose two) | Host runs virtual machines; guest is a virtual machine |
| 6 | Cloud computing characteristics | All listed statements |
| 7 | Software without available source code | Closed-source software |
| 8 | Copyleft obligations | Redistributed modifications must provide corresponding source under applicable terms |
| 9 | Free Software Foundation freedoms (choose two) | Freedom to modify; freedom to share |
| 10 | Public-domain software | Not subject to exclusive copyright restrictions, e.g., rights relinquished or expired |
| 11 | Semicolon (`;`) between shell commands | True — separates sequential commands |
| 12 | Display text/messages in a shell | `echo` |
| 13 | Search forward in a manual page | `/` |
| 14 | Search for files using a filename database | `locate` |
| 15 | Top-level Linux directory | `/` |
| 16 | `ls` without options | Lists current directory entries |
| 17 | `cp` needs source and destination | True |
| 18 | Prompt before deleting with `rm` | `rm -i` |
| 19 | Glob excluding names beginning with T or W | `echo /etc/[!TW]*` |
| 20 | Suitable file for lossless compression | Log file |
| 21 | List contents of a gzip-compressed tar archive | `tar -tzf foo.tar.gz` |
| 22 | Default error-output stream | Standard error (`stderr`) |
| 23 | Match lines starting with `test` | `grep '^test' file.txt` |
| 24 | Match lines containing `start` or `end` | `egrep 'start|end' file.txt` |
| 25 | Meaning of `#!/bin/csh` | Use `/bin/csh` as script interpreter |
| 26 | Successful command exit status | `0` |
| 27 | Compare numeric `USERS` value with 5 | `test "$USERS" -eq 5` |
| 28 | Software connecting OS and hardware | Device drivers |
| 29 | GPT partitioning utilities (choose three) | `cgdisk`, `sgdisk`, `gdisk` |
| 30 | Default `ps` output | True — shows processes associated with the current terminal/session by default |
| 31 | Purpose of `free` | Reports memory usage |
| 32 | Kernel command line used at boot | `/proc/cmdline` |
| 33 | Persistent kernel parameter configuration | `/etc/sysctl.conf` (also `/etc/sysctl.d/*.conf`) |
| 34 | Display network interface IP configuration | `ifconfig` (modern alternative: `ip addr`) |
| 35 | RSA fingerprint allows `dig` remote access | False — SSH fingerprints and DNS queries are different concepts |
| 36 | `service network restart` | Restart network service and apply its configuration |
| 37 | Display socket statistics | `ss` |
| 38 | Show groups for user `bob` | `id bob` |
| 39 | Minimum password age of zero prevents changes | False |
| 40 | `sudo` can execute commands as another user | True |
| 41 | Show uptime on the first line alongside logged-in users | `w` |
| 42 | `usermod` primary and supplementary group options (choose two) | `-g` and `-G` |
| 43 | `groupmod` adds users to groups | False |
| 44 | Lock `bob`'s password using `usermod` | `usermod -L bob` |
| 45 | Low GIDs (below 500 or 1000) are typically reserved for | System groups |
| 46 | Non-owner can never delete a file | False |
| 47 | List hidden files and ownership | `ls -la` |
| 48 | Enable setuid on `/usr/bin/program` | `chmod 4755 /usr/bin/program` |
| 49 | Deleting the original name breaks a hard link | False |
| 50 | Create hard link `link` to `file` | `ln file link` |

## 4. Essential Commands and Examples

### 4.1. Shell, documentation, and file searches

```bash
ls -la                    # Show hidden entries, permissions, owners, and groups
man ls                    # Open a manual page; press / to search
locate filename           # Search a prebuilt filename database
echo /etc/[!TW]*          # Match /etc entries not beginning with T or W
```

The glob `[!TW]` negates a character class. It is a **shell glob**, not a regular expression.

### 4.2. Files, archives, and text processing

```bash
cp source.txt copy.txt
rm -i copy.txt
tar -tzf archive.tar.gz
grep '^test' file.txt
grep -E 'start|end' file.txt
```

`^` anchors a regular expression at the beginning of a line; `|` provides alternation in extended regular expressions. `grep -E` is a modern equivalent of `egrep`.

### 4.3. Processes, system information, and networking

```bash
ps
free -h
cat /proc/cmdline
sysctl -a
ip addr
ss -tuln
w
```

`/proc/cmdline` displays the kernel's boot parameters. Persistent `sysctl` settings can be stored in `/etc/sysctl.conf` or files under `/etc/sysctl.d/`, depending on the distribution.

### 4.4. Users and groups

```bash
id bob
sudo usermod -g developers bob
sudo usermod -aG docker bob
sudo usermod -L bob
sudo usermod -U bob
sudo groupmod -n engineering developers
getent group
```

**Key distinctions:**

| Command / Option | Purpose |
|---|---|
| `usermod -g` | Set the primary group |
| `usermod -G` | Replace the supplementary group list |
| `usermod -aG` | Append supplementary groups without removing existing memberships |
| `usermod -L` | Lock password authentication |
| `usermod -U` | Unlock password authentication |
| `groupmod` | Change group attributes, such as name or GID |
| `id bob` | Display a user's UID, primary GID, and group memberships |

**Security note:** `usermod -L` locks the password, not necessarily every authentication method. Account expiration and SSH configuration may require separate controls.

### 4.5. Permissions and links

```bash
chmod 4755 /usr/bin/program  # Enable setuid (illustrative only)
ln file hardlink
ln -s file symlink
ls -li file hardlink
```

| Special permission | Octal prefix | Typical meaning |
|---|---:|---|
| setuid | `4` | Executable runs with file owner's effective UID |
| setgid | `2` | Executable runs with file group's effective GID; special directory behavior |
| Sticky bit | `1` | Restricts deletion/renaming in shared directories |

Do **not** apply setuid to arbitrary executables in a production system. It can introduce serious privilege-escalation risks.

## 5. Key Comparisons and Exam Traps

### 5.1. File deletion versus file ownership

Deleting a file generally requires **write and execute permissions on its parent directory**, not ownership of the file itself. A directory's sticky bit can restrict who may delete entries even when the directory is writable.

### 5.2. Hard links versus symbolic links

| Property | Hard link | Symbolic link |
|---|---|---|
| Created with | `ln source link` | `ln -s source link` |
| References | Same inode | Target pathname |
| Original pathname removed | Remains usable | Usually becomes dangling |
| Cross-filesystem links | Generally not supported | Supported |

### 5.3. Group management versus group membership

`groupmod` changes a group's attributes. `usermod -aG` and `gpasswd -a` are commonly used to add an existing user to a supplementary group.

### 5.4. Password lock versus full account disablement

A locked password does not always disable public-key SSH authentication. Treat `usermod -L` as a **password lock**, not an unconditional guarantee that all logins are blocked.

### 5.5. `w`, `who`, and `uptime`

| Command | Main information |
|---|---|
| `w` | Uptime, load, connected users, and their activity |
| `who` | Connected users |
| `uptime` | Uptime and load averages |

## 6. Review Checklist

- [x] Review Linux concepts, licensing, and virtualization.
- [x] Review basic shell commands and documentation.
- [x] Review globbing, regular expressions, and archives.
- [x] Review scripting and command exit statuses.
- [x] Review processes, kernel parameters, and networking.
- [x] Review users, groups, and account locking.
- [x] Review file permissions and special bits.
- [x] Review hard links and symbolic links.
- [x] Discuss all **50 final-exam questions**.

## 7. Final Assessment Status

**Question review:** Completed — **50/50 questions (100%)**.

---

*Study documentation for the Linux Essentials learning project. Examples are illustrative and may vary by distribution.*
