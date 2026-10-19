# Module 15 — System and User Security

Personal study notes for **Cisco Networking Academy / NDG Linux Essentials**, Chapter 15. Explanations, practical examples, and quiz review for LPI Linux Essentials preparation.

## 1. Exam Objective

**LPI Linux Essentials — Objective 5.1: Basic Security and Identifying User Types**  
**Weight:** 2  
**Scope:** Various types of users on a Linux system.

**Key knowledge areas:** root users, standard users, system users, account and group records, user identity, and login activity.

| Command / file | Purpose |
|---|---|
| `su` | Start a shell as another user |
| `sudo` | Run authorized commands as another user |
| `id` | Display user and group IDs |
| `getent` | Query account/group databases |
| `who` | Display current login sessions |
| `w` | Display current sessions and activity |
| `last` | Display login and reboot history |
| `/etc/passwd` | User account information |
| `/etc/shadow` | Password hashes and aging information |
| `/etc/group` | Group definitions and supplementary members |
| `/etc/gshadow` | Protected group information |

## 2. Users, Groups, and Access Control (15.1)

Linux supports multiple user accounts. Each account has a **UID** (user identifier) and at least one **primary group**, identified by a **GID**. Users may also join **supplementary groups**. File and directory permissions use user and group identities to determine access.

Three important account categories:

| Type | Typical UID | Role |
|---|---|---|
| Root | `0` | Administrative access |
| Standard user | Often `1000+` on modern distributions | Interactive human use |
| System user | Often lower reserved IDs | Run services and daemons |

UID ranges other than root are distribution-dependent. Service accounts frequently use `/usr/sbin/nologin` or `/bin/false` rather than an interactive shell; avoid deleting them without understanding the service dependency.

## 3. Administrative Privileges (15.2)

The root account has **UID 0** and broad control over the operating system. Running a complete interactive session as root increases the impact of mistakes and compromised programs. Prefer temporary elevation for administrative operations.

### 3.1. Switching identities with `su` (15.2.1)

```bash
su -                 # Login shell as root (normally asks for root's password)
su - alice           # Login shell as alice
id                   # Confirm the current identity
exit                 # Return to the previous shell
```

The `-`, `-l`, and `--login` forms request a login shell and load the destination user's login environment. Without a login shell, `su` changes identity without fully recreating that environment. Ordinary users normally authenticate with the **destination account's password**. Root can generally switch identities without a password.

### 3.2. Running privileged commands with `sudo` (15.2.2)

```bash
sudo id               # Run id as root by default
sudo -u alice id      # Run id as alice, if authorized
sudo head /etc/shadow # Read a root-protected file, if authorized
```

`sudo` normally authenticates with the **invoking user's password**, not root's password. Permission is governed by sudo policy (commonly `/etc/sudoers` and `/etc/sudoers.d/`). Authentication may be cached for a configurable period. Administrative invocations can be logged for accountability.

| Feature | `su` | `sudo` |
|---|---|---|
| Typical use | Switch to another user's shell | Run a specific command |
| Password normally used | Target user's password | Invoking user's password |
| Default target | Root | Root |
| Main benefit | Full target-user session | Explicit, controlled privilege elevation |

Some distributions, including Ubuntu by default, disable direct password authentication as root and favor `sudo`.

## 4. User Accounts: `/etc/passwd` (15.3)

Each colon-separated entry has **seven fields**:

```text
sysadmin:x:1001:1001:System Administrator:/home/sysadmin:/bin/bash
```

| Position | Field | Example | Meaning |
|---|---|---|---|
| 1 | Username | `sysadmin` | Login name |
| 2 | Password placeholder | `x` | Password hash is stored in `/etc/shadow` |
| 3 | UID | `1001` | Numeric user identity |
| 4 | Primary GID | `1001` | Numeric primary group |
| 5 | Comment (GECOS) | `System Administrator` | Descriptive information |
| 6 | Home directory | `/home/sysadmin` | Default home path |
| 7 | Login shell | `/bin/bash` | Shell or non-login program |

```bash
tail -5 /etc/passwd
grep '^sysadmin:' /etc/passwd
getent passwd sysadmin
```

`getent` is useful because account data may also come from configured network identity services rather than local files alone.

## 5. Password Security: `/etc/shadow` (15.3.1)

The restricted `/etc/shadow` file contains **password hashes**, not reversible encrypted plaintext passwords, along with password aging and account expiration settings.

A simplified nine-field record:

```text
sysadmin:$6$hash...:16874:5:30:7:60:15050:
```

| Position | Field | Meaning |
|---|---|---|
| 1 | Username | Matches the account name |
| 2 | Password | Password hash or lock marker (`!`, `*`) |
| 3 | Last change | Days since January 1, 1970 (Unix Epoch) |
| 4 | Minimum | Minimum days between password changes |
| 5 | Maximum | Maximum password age in days |
| 6 | Warning | Days of warning before password expiration |
| 7 | Inactive | Days after password expiration before account inactivation |
| 8 | Expire | Account expiration date in days since Epoch |
| 9 | Reserved | Reserved for future use |

For the illustrative policy `5:30:7:60`, the user normally waits five days between password changes, the password expires after 30 days, warnings begin seven days before expiry, and inactivation occurs after a further 60 days. **Password expiry** and **account expiry** are separate concepts.

The `$6$` prefix in traditional crypt-format hashes identifies SHA-512. Hash formats vary by distribution. Password fields containing `*` or `!` typically prevent password-based authentication.

```bash
sudo head /etc/shadow   # Requires appropriate privileges; sensitive output
```

Never publish actual `/etc/shadow` contents or password hashes in a repository.

## 6. System Accounts (15.4)

Services may run under dedicated accounts rather than root. A typical entry is:

```text
sshd:x:103:65534::/var/run/sshd:/usr/sbin/nologin
```

The non-login shell helps prevent interactive use. System accounts may lack conventional home directories and may have locked password fields. The UID ranges described in the course are conventions, not universal rules.

## 7. Group Accounts: `/etc/group` (15.5)

A group record contains **four colon-separated fields**:

```text
mail:x:12:mail,postfix
```

| Position | Field | Meaning |
|---|---|---|
| 1 | Group name | `mail` |
| 2 | Password placeholder | `x` (protected group information may be in `/etc/gshadow`) |
| 3 | GID | `12` |
| 4 | Member list | `mail,postfix` (supplementary members) |

The user's **primary GID** is recorded in `/etc/passwd`; the `/etc/group` member list primarily records **supplementary membership**. Therefore, an empty group member list does not imply that nobody has that group as their primary group.

A user and group may share the same name. Traditional UNIX implementations commonly limited users to 16 group memberships; modern Linux supports substantially more, with actual limits depending on configuration.

```bash
getent group mail
grep '^mail:' /etc/group
```

## 8. Inspecting Identity with `id` (15.6)

```bash
id                    # Current user, primary group, all groups
id root               # Root's identity
id -u                 # Current UID only
id -g                 # Primary GID only
id -G                 # All group IDs
id -Gn                # All group names
```

Example:

```text
uid=1001(sysadmin) gid=1001(sysadmin) groups=1001(sysadmin),4(adm),27(sudo)
```

Here `sysadmin` has primary group `sysadmin` and supplementary groups `adm` and `sudo`.

## 9. Current Sessions: `who` and `w` (15.7)

```bash
who                   # Logged-in users, terminals, times, origins
who -b                # Last system boot, when supported
who -r                # Current runlevel, when supported
w                     # Sessions, activity, uptime, load average
```

Terminal names beginning with `tty` typically denote local text terminals; `pts` denotes pseudoterminals (common for SSH and terminal emulators). Remote hostnames or IPs may appear in the origin field.

`w` columns include `USER`, `TTY`, `FROM`, `LOGIN@`, `IDLE`, `JCPU`, `PCPU`, and `WHAT`. Its first line includes system uptime and load averages for 1, 5, and 15 minutes. **Load average is not identical to CPU utilization percentage**; it measures runnable and certain waiting tasks.

## 10. Login History: `last` (15.8)

```bash
last                  # Previous logins, logouts, and reboot records
last sysadmin         # History for one user
last reboot           # Reboot records
```

`last` reads login history traditionally stored in `/var/log/wtmp`; the system may report `still logged in` for active sessions. `who` uses current-session records (typically `utmp`), while `last` reads historical `wtmp` records. Availability and paths vary across Linux distributions.

| Command | Primary question answered |
|---|---|
| `id` | Who am I and which groups do I belong to? |
| `who` | Who is logged in right now? |
| `w` | Who is logged in and what are they doing? |
| `last` | Who logged in previously, and when did the system reboot? |
| `uptime` | How long has the system been running? |

## 11. Practical Read-Only Lab

The accompanying `code/user-security-audit.sh` script displays the current identity, root account record, primary and supplementary groups, and login/session summaries. It avoids printing password hashes or modifying account settings.

```bash
bash modules/15-system-and-user-security/code/user-security-audit.sh
```

Results depend on available utilities, distribution, and whether the system maintains login records.

## 12. Chapter Quiz Review

| Question | Correct answer | Reason |
|---|---|---|
| 1. Each user belongs to at least one group. | **True** | Every account has a primary GID. |
| 2. A user can belong to... | **At least 16 groups** | Intended answer: Linux supports many memberships. This does **not** mean 16 memberships are required. |
| 3. Sudo privileges specify which users may run commands as other users. | **True** | Sudo policy controls authorization. |
| 4. All Linux systems allow direct root login. | **False** | Some distributions disable direct root password login by default. |
| 5. Traditional UNIX systems allowed how many groups? | **16** | Historical membership limit described by the course. |
| 6. Usernames cannot be the same as group names. | **False** | Matching user and primary-group names are common. |
| 7. `last` displays reboot records... | **By default** | Reboot events are included in login history. |
| 8. `sudo` normally requests the invoking user's password. | **True** | It normally does not request root's password. |
| 9. `/etc/shadow` contains encrypted passwords. | **True** | Course wording; technically these are one-way password hashes. |
| 10. Which command views `/var/log/wtmp` entries? | **`last`** | Reads historical login and reboot records. |

**Exam distinctions:** `su` vs. `sudo`; UID vs. GID; primary vs. supplementary groups; `/etc/passwd` vs. `/etc/shadow` vs. `/etc/group`; current sessions (`who`, `w`) vs. history (`last`).

## 13. Quick Reference

| Task | Command |
|---|---|
| Display account record | `getent passwd username` |
| Display group record | `getent group groupname` |
| Show current identity | `id` |
| Show a user's identity | `id username` |
| Show group names | `id -Gn` |
| Start a root login shell | `su -` |
| Execute an authorized root command | `sudo command` |
| Execute as a named user | `sudo -u username command` |
| Show active logins | `who` |
| Show active sessions and activity | `w` |
| Show login history | `last` |
| Show reboot history | `last reboot` |
