# Challenge Lab A: User Management

Study notes and practical review for **Challenge Lab A: User Management**, Cisco Networking Academy / NDG Linux Essentials.

## 1. Lab Overview

**Curriculum:** Modules 8, 15, 16, 17, and 18.

**Scenario:** A company needs isolated shared directories for three new departments: Engineering, Sales, and IS. Each department has one administrator and two regular users.

**Objectives:** Create nine users, three primary groups, three department directories, and three confidential documents; enforce group isolation, ownership, and special directory permissions; verify the resulting configuration.

> **Naming note:** The lab specifies roles and departments but not account names. The names below are illustrative choices used for this solution.

| Department | Group | Administrator | Members | Directory |
|---|---|---|---|---|
| Engineering | `engineering` | `engadmin` | `enguser1`, `enguser2` | `/engineering` |
| Sales | `sales` | `salesadmin` | `salesuser1`, `salesuser2` | `/sales` |
| IS | `is` | `isadmin` | `isuser1`, `isuser2` | `/is` |

## 2. Create Department Groups

```bash
sudo groupadd engineering
sudo groupadd sales
sudo groupadd is
```

Verify:

```bash
getent group engineering
getent group sales
getent group is
```

`getent` consults the system account databases, which can include more than local `/etc/group` entries.

## 3. Create User Accounts

Every user receives a home directory, Bash login shell, and department-specific **primary group**.

```bash
sudo useradd -m -s /bin/bash -g engineering engadmin
sudo useradd -m -s /bin/bash -g engineering enguser1
sudo useradd -m -s /bin/bash -g engineering enguser2

sudo useradd -m -s /bin/bash -g sales salesadmin
sudo useradd -m -s /bin/bash -g sales salesuser1
sudo useradd -m -s /bin/bash -g sales salesuser2

sudo useradd -m -s /bin/bash -g is isadmin
sudo useradd -m -s /bin/bash -g is isuser1
sudo useradd -m -s /bin/bash -g is isuser2
```

| Option | Meaning |
|---|---|
| `-m` | Create the user's home directory |
| `-s /bin/bash` | Set Bash as the login shell |
| `-g GROUP` | Assign the primary group |

Verify accounts, shells, and groups:

```bash
getent passwd engadmin enguser1 enguser2 salesadmin salesuser1 salesuser2 isadmin isuser1 isuser2
id engadmin
id enguser1
id enguser2
id salesadmin
id salesuser1
id salesuser2
id isadmin
id isuser1
id isuser2
```

The scenario does not require setting passwords. If interactive login is needed, set passwords separately using `sudo passwd USER`.

## 4. Create Department Directories and Set Ownership

```bash
sudo mkdir /engineering /sales /is
sudo chown engadmin:engineering /engineering
sudo chown salesadmin:sales /sales
sudo chown isadmin:is /is
```

Each department administrator owns the respective directory; the corresponding department group is its group owner.

## 5. Configure Special Directory Permissions

```bash
sudo chmod 3770 /engineering /sales /is
ls -ld /engineering /sales /is
```

Expected permission pattern:

```text
drwxrws--T ... engadmin   engineering ... /engineering
drwxrws--T ... salesadmin sales       ... /sales
drwxrws--T ... isadmin    is          ... /is
```

| Octal digit | Meaning |
|---|---|
| `3` | SGID (`2`) plus sticky bit (`1`) |
| `7` | Owner: read, write, execute |
| `7` | Group: read, write, execute |
| `0` | Others: no permissions |

**SGID** makes newly created files and subdirectories normally inherit the department's group. **Sticky bit** restricts deletion and renaming of entries by other users. The directory owner and root can still remove entries, so the scenario's absolute wording that *only* a file's owner can delete it is not strictly achievable with this conventional sticky-directory setup.

The capital `T` in `drwxrws--T` indicates the sticky bit is set while others lack execute permission.

## 6. Create Confidential Documents

The lab requires one line of text in each department document:

```text
This file contains confidential information for the department.
```

Create the documents:

```bash
printf '%s\n' 'This file contains confidential information for the department.' | sudo tee /engineering/confidential.txt >/dev/null
printf '%s\n' 'This file contains confidential information for the department.' | sudo tee /sales/confidential.txt >/dev/null
printf '%s\n' 'This file contains confidential information for the department.' | sudo tee /is/confidential.txt >/dev/null

sudo chown engadmin:engineering /engineering/confidential.txt
sudo chown salesadmin:sales /sales/confidential.txt
sudo chown isadmin:is /is/confidential.txt

sudo chmod 640 /engineering/confidential.txt /sales/confidential.txt /is/confidential.txt
```

| Mode | Owner | Group | Others |
|---|---|---|---|
| `640` | Read/write | Read only | No access |

Verify:

```bash
sudo ls -l /engineering/confidential.txt
sudo ls -l /sales/confidential.txt
sudo ls -l /is/confidential.txt
```

**Observed troubleshooting:** Running `ls -l /engineering/confidential.txt` as a regular account outside the `engineering` group returned **Permission denied**. This is expected: looking up a file requires directory traversal (`x`), which mode `3770` denies to others. The administrator can inspect it using `sudo ls -l ...`. Do not loosen the directories to `777` to make inspection work.

## 7. Test Effective Access

Read as an authorized department member:

```bash
sudo -u enguser1 cat /engineering/confidential.txt
```

Attempt to read from a different department (should fail):

```bash
sudo -u salesuser1 cat /engineering/confidential.txt
```

Test that a regular member cannot modify the confidential document (should fail):

```bash
sudo -u enguser1 sh -c 'echo test >> /engineering/confidential.txt'
```

Test that the administrator has write access without changing the one-line document:

```bash
sudo -u engadmin test -w /engineering/confidential.txt && echo 'Write permission granted'
```

Test the sticky bit with a temporary file:

```bash
sudo -u enguser1 touch /engineering/enguser1-test.txt
sudo -u enguser2 rm /engineering/enguser1-test.txt  # Expected: Operation not permitted
sudo -u enguser1 rm /engineering/enguser1-test.txt
```

**Additional nuance:** Directory write permission controls whether a user can unlink an entry, not the file's write bit. A group member with directory write access and the sticky bit restriction can still delete **their own** files, but not another member's files. The directory owner remains an exception.

## 8. Automated Setup

An equivalent Bash setup script is provided as [`setup.sh`](./setup.sh). It requires root privileges and explicit `--apply` confirmation:

```bash
sudo bash setup.sh --apply
```

The script performs preflight checks and **refuses to run if any target account, group, directory, or document already exists**, to avoid overwriting a completed lab or changing unrelated system resources. It is designed for a **fresh disposable lab environment**, not for rerunning on the environment already configured manually.

## 9. Quick Reference

| Command | Purpose |
|---|---|
| `groupadd GROUP` | Create a group |
| `useradd -m -s /bin/bash -g GROUP USER` | Create an account with a primary group |
| `getent passwd USER` | Verify account creation |
| `getent group GROUP` | Verify group creation |
| `id USER` | Verify UID, GID, and group membership |
| `mkdir /DIR` | Create a department directory |
| `chown USER:GROUP PATH` | Set owner and group |
| `chmod 3770 DIR` | Set SGID, sticky bit, and group-only access |
| `chmod 640 FILE` | Owner read/write; group read; others none |
| `ls -ld DIR` | Inspect directory permissions without entering it |
| `sudo ls -l DIR/FILE` | Inspect protected files administratively |
| `sudo -u USER COMMAND` | Test a command as another user |

## 10. Final Review Checklist

- [ ] Three department groups exist.
- [ ] Nine users exist, each with Bash and the correct primary group.
- [ ] Three directories exist directly under `/`.
- [ ] Each directory has the correct administrator and group ownership.
- [ ] Each directory has mode `3770`.
- [ ] Each department has one confidential document containing the required single line.
- [ ] Each confidential document has matching owner/group and mode `640`.
- [ ] Members can read their own department's document but cannot edit it.
- [ ] Members of other departments cannot access the directory.
- [ ] Sticky-bit behavior was tested using temporary files.

---

**Challenge Lab A: User Management — completed and reviewed.**
