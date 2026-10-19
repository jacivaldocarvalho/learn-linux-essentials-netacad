# Module 16 — Creating Users and Groups

Study notes for **Cisco Networking Academy / NDG Linux Essentials**, Chapter 16, aligned with **LPI Linux Essentials Objective 5.2: Creating Users and Groups** (**weight: 2**).

## 1. Exam Objective and Scope

**Objective 5.2 — Creating Users and Groups:** Create and manage Linux users and groups, understand user identifiers, and apply basic account configuration and password management.

**Key knowledge areas:** user commands (16.3), group commands (16.2), and user IDs (16.3.3).

| Command or path | Purpose |
|---|---|
| `groupadd`, `groupmod`, `groupdel` | Create, modify, and remove groups |
| `useradd`, `usermod`, `userdel` | Create, modify, and remove users |
| `passwd` | Set or change a user's password |
| `chage` | View and modify password-aging settings |
| `id`, `getent` | Inspect identities and account databases |
| `/etc/passwd` | Account name, UID, primary GID, home, shell |
| `/etc/shadow` | Password hashes and account/password aging |
| `/etc/group`, `/etc/gshadow` | Group definitions and protected group data |
| `/etc/skel` | Template files copied to new home directories |
| `/etc/default/useradd`, `/etc/login.defs` | Account creation defaults |

## 2. Planning Accounts and Groups (16.1)

Separate accounts enable individual home directories, group-based collaboration, controlled administrative access, and accountability. Plan shared groups before creating users to avoid later membership changes. Every user needs a **primary group**, and a user may belong to additional **supplementary groups**.

A **User Private Group (UPG)** is a group created alongside an account, typically sharing its name and numeric ID. For example, `jane` may have UID `1001` and a private group `jane` with GID `1001`. Systems without UPG may assign a shared primary group such as `users`.

## 3. Managing Groups (16.2)

### 3.1 Inspecting group records

```bash
getent group root
grep '^root:' /etc/group
```

A group record has the form `name:password-placeholder:GID:supplementary-members`, such as `research:x:1005:jane`. `getent` can include network-backed identities according to the system's configured name services.

### 3.2 Creating groups: `groupadd`

```bash
sudo groupadd research
sudo groupadd -g 1005 research
sudo groupadd -r servicegroup
getent group research
```

These are **alternative creation examples**: do not run both `groupadd research` commands on the same system. `-g` requests a specific available GID; `-r` creates a system group using the distribution's configured system GID range. Without `-g`, the system chooses an available GID according to its configuration; do not assume the algorithm always selects the highest existing GID plus one.

Traditional examples reserve GIDs below `500` (some Red Hat systems) or `1000` (some Debian systems) for system use. Actual ranges depend on distribution and configuration. Choose portable group names beginning with a lowercase letter or underscore, followed by letters, digits, underscores, or hyphens; avoid trailing hyphens.

### 3.3 Modifying groups: `groupmod`

```bash
sudo groupmod -n clerks sales   # Rename sales to clerks
sudo groupmod -g 10003 clerks  # Change clerks' GID
```

**Changing the group name** preserves the numeric GID, so file ownership continues to resolve to the renamed group. **Changing the GID** can leave files with the previous numeric GID, potentially without a matching group entry. Locate unresolved group ownership with:

```bash
sudo find / -nogroup 2>/dev/null
```

### 3.4 Deleting groups: `groupdel`

```bash
sudo groupdel clerks
```

A group cannot normally be deleted while it is the **primary group** of an existing user. Deleting a group may leave files owned by a numeric GID without a group name. Review ownership and memberships before removal.

## 4. User Creation Defaults (16.3.1–16.3.2)

### 4.1 `/etc/default/useradd`

```bash
useradd -D
```

Typical settings include:

| Setting | Meaning |
|---|---|
| `GROUP` | Default primary group on systems not using UPG |
| `HOME` | Base path for user home directories, usually `/home` |
| `INACTIVE` | Days after password expiration until the account becomes inactive; `-1` disables this default |
| `EXPIRE` | Account expiration date |
| `SHELL` | Default login shell |
| `SKEL` | Skeleton directory, usually `/etc/skel` |
| `CREATE_MAIL_SPOOL` | Whether a local mail spool is created |

For example, `sudo useradd -D -f 30` configures a 30-day inactivity period as a default for subsequently created accounts. Inspect current defaults before changing them.

### 4.2 `/etc/login.defs`

```bash
grep -Ev '^#|^$' /etc/login.defs
```

Important entries include `UID_MIN`, `UID_MAX`, `GID_MIN`, `GID_MAX`, `PASS_MAX_DAYS`, `PASS_MIN_DAYS`, `PASS_WARN_AGE`, `CREATE_HOME`, `UMASK`, `USERGROUPS_ENAB`, and `ENCRYPT_METHOD`. The chapter's CentOS 6 example uses `UID_MIN=500`, `GID_MIN=500`, and `UMASK=077`; modern installations may differ. Password complexity and hash policies can also be governed by PAM and other system components.

`/etc/skel` contains initial files copied into a new user's home directory when that directory is created, with ownership assigned to the new user.

## 5. User IDs and Account Properties (16.3.3)

| Property | Relevant option | Explanation |
|---|---|---|
| Username | Positional argument | Unique login name |
| UID | `-u` | Numeric user identity |
| Primary group | `-g` | Existing group name or GID |
| Supplementary groups | `-G` | Comma-separated list |
| Create home | `-m` | Create and populate the home directory |
| Skip home creation | `-M` | Do not create the home directory |
| Home base | `-b` | Alternative base directory |
| Explicit home path | `-d` | Set a specific home directory |
| Skeleton path | `-k` | Alternative skeleton directory; use with `-m` |
| Login shell | `-s` | Set shell, e.g. `/bin/bash` |
| GECOS/comment | `-c` | Store a descriptive name |

**UID conventions:** UID `0` is root. System/service accounts traditionally occupy UIDs `1–499`; some distributions reserve `1–999`. Regular accounts commonly start at UID `1000` on modern systems. The chapter notes UID `65534` for `nfsnobody` on some systems. Ranges and service names vary.

**UIDs and GIDs identify ownership**, not display names. Changing an account's name preserves its UID, whereas changing its UID can leave files associated with the old numeric identity.

## 6. Creating Users: `useradd` (16.3.4)

Create groups first, then the account:

```bash
sudo groupadd research
sudo groupadd sales
sudo useradd -u 1009 -g users -G sales,research -m -c 'Jane Doe' jane
```

This example assumes the primary group `users` exists, UID `1009` is available, and `jane` does not already exist. It creates a user with primary group `users`, supplementary groups `sales` and `research`, a home directory, and the GECOS comment `Jane Doe`.

Verify:

```bash
getent passwd jane
id jane
sudo getent shadow jane
getent group research
```

A newly created account may not yet have a usable password. Set one separately:

```bash
sudo passwd jane
```

The account's properties appear in `/etc/passwd`, password information in `/etc/shadow`, and group memberships in `/etc/group` and `/etc/gshadow`.

## 7. Passwords and Aging (16.3.5)

A strong password should be difficult to guess, kept confidential, and handled according to the system's password policy. The chapter discusses length, character composition, and lifetime; overly frequent forced changes can also create undesirable user behavior.

### 7.1 `passwd`

```bash
passwd                 # Change your own password
sudo passwd jane       # Set or change Jane's password
```

An ordinary user typically supplies the current password before choosing a new one. The administrator can reset another account's password. Password hashes are stored in `/etc/shadow`, which requires privileged access. Hashing is not reversible encryption.

### 7.2 `chage`

| Option | Function |
|---|---|
| `-l` | List password-aging information |
| `-d` | Set last password change date |
| `-E` | Set account expiration date |
| `-I` | Set inactivity days after password expiration |
| `-m` | Set minimum days between password changes |
| `-M` | Set maximum password age |
| `-W` | Set warning days before expiration |

```bash
sudo chage -l jane
sudo chage -M 60 jane
sudo chage -m 5 jane
sudo chage -W 7 jane
sudo chage -E 2026-12-31 jane
```

**Exam distinction:** `-M` limits **password age**, whereas `-E` sets **account expiration**.

## 8. Modifying Users: `usermod` (16.3.6)

| Option | Function |
|---|---|
| `-c` | Change GECOS/comment |
| `-d` | Set home path (does not move contents by itself) |
| `-e` | Set account expiration |
| `-f` | Set inactive period |
| `-g` | Change primary group |
| `-G` | Replace supplementary group list |
| `-a` | Append to supplementary groups when combined with `-G` |
| `-l` | Change login name |
| `-L` | Lock password authentication |
| `-s` | Change login shell |
| `-u` | Change UID |
| `-U` | Unlock password authentication |

```bash
sudo usermod -aG development jane  # Add one supplementary group
sudo usermod -G development jane   # Replace ALL supplementary groups
sudo usermod -l janedoe jane       # Rename login
sudo usermod -L jane               # Lock password
sudo usermod -U jane               # Unlock password
```

These examples are **independent demonstrations**; after renaming `jane`, subsequent commands must use `janedoe`. **Critical exam trap:** `-G` alone **replaces** the supplementary group list; `-aG` **appends** without removing existing memberships. Group changes typically require a new login session to become effective.

`usermod -L` locks the password but does not necessarily block other authentication methods, such as SSH public-key access. Changes to a logged-in user's identity may fail or take effect only after re-login.

## 9. Deleting Users: `userdel` (16.3.7)

```bash
sudo userdel jane       # Remove account, retain home directory
sudo userdel -r jane    # Remove account, home directory, and mail spool
```

These are **mutually exclusive alternatives**. `-r` can irreversibly delete user data, and it does not guarantee removal of files outside the home directory. Files left behind may display numeric ownership without a matching user or group.

```bash
sudo find / -nouser 2>/dev/null
sudo find / -nogroup 2>/dev/null
```

Consider backups and retention requirements before deleting accounts. Locking an account can be an alternative when preserving identity and ownership is important.

## 10. Guided Practice: Safe Account Inspection

The accompanying read-only script `code/account-audit.sh` displays the current user's identity, account defaults, relevant group records, and password-aging details for a specified user. It does not create, change, or delete accounts.

```bash
bash -n code/account-audit.sh
bash code/account-audit.sh "$USER"
```

To practice state-changing commands, use an isolated lab VM and confirm each change with `id`, `getent`, and `chage -l`.

## 11. Chapter Review — Questions 1–10

| # | Topic | Correct answer | Reason |
|---|---|---|---|
| 1 | Traditional UIDs 1–499 | **System accounts, such as server processes** | Reserved for system/service identities |
| 2 | Specify a UID with `useradd` | **`-u`** | Assigns a numeric UID |
| 3 | `groupmod` can change a GID | **True** | `groupmod -g` changes the GID |
| 4 | `groupmod` adds users to a group | **False** | Use `usermod -aG` for supplementary membership |
| 5 | Command to modify a group | **`groupmod`** | Changes group name or GID |
| 6 | Lock Bob's password | **`usermod -L bob`** | Locks password authentication |
| 7 | GIDs below 500/1000 | **System use** | Traditionally reserved for system groups |
| 8 | In UPG, UID must differ from GID | **False** | A UPG typically matches the user's UID |
| 9 | `groupmod` can rename a group | **True** | `groupmod -n` renames it |
| 10 | `groupmod` cannot change a GID | **False** | `groupmod -g` changes it |

## 12. Quick Command Reference

| Task | Command |
|---|---|
| Create a regular group | `sudo groupadd team` |
| Create a system group | `sudo groupadd -r servicegroup` |
| Rename a group | `sudo groupmod -n new old` |
| Change group GID | `sudo groupmod -g 2000 team` |
| Delete a group | `sudo groupdel team` |
| Create a user with home | `sudo useradd -m alice` |
| Create user with chosen UID | `sudo useradd -u 1500 alice` |
| Set primary group | `sudo usermod -g team alice` |
| Append supplementary group | `sudo usermod -aG team alice` |
| Set a password | `sudo passwd alice` |
| Inspect password aging | `sudo chage -l alice` |
| Lock a password | `sudo usermod -L alice` |
| Remove a user and home | `sudo userdel -r alice` |
| Show identity | `id alice` |
| Show user record | `getent passwd alice` |
| Show group record | `getent group team` |

**Key distinctions to retain:** `-g` vs. `-G`; `-G` vs. `-aG`; `groupmod -n` vs. `groupmod -g`; password expiration vs. account expiration; changing names vs. changing numeric IDs; `userdel` vs. `userdel -r`.
