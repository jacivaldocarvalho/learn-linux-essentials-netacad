# Module 5 Lab — Command Line Skills

Condensed notes from the Module 5 command-line lab.

## Files and Directories

Useful commands:

```bash
ls
ls -l
whoami
uname
uname -n
pwd
```

A typical prompt:

```text
sysadmin@localhost:~$
```

represents:

```text
sysadmin   → user
localhost  → hostname
~          → home directory
$          → regular-user prompt
```

`ls -l` provides a long listing:

```text
drwxr-xr-x 2 sysadmin sysadmin 4096 Oct 31 19:52 Desktop
```

Important fields include:

```text
permissions | links | owner | group | size | modification time | name
```

`pwd` displays the current working directory:

```bash
pwd
```

Example:

```text
/home/sysadmin
```

---

## Command History

Display history:

```bash
history
```

Display recent entries:

```bash
history 5
```

Execute a specific event:

```bash
!9
```

Execute a command relative to the current history position:

```bash
!-5
```

Useful shortcuts:

```text
↑       older command
↓       newer command
!!      previous command
!name   latest command beginning with "name"
```

---

## Shell Variables

Use `echo` to display text or expanded variable values:

```bash
echo Hello Student
echo "$HISTSIZE"
echo "$PATH"
echo "$HOME"
```

Important variables:

```text
HOME       → home directory
PATH       → command-search directories
HISTSIZE   → Bash in-memory history size
```

`PATH` entries are separated by `:`.

Example:

```text
/usr/local/bin:/usr/bin:/bin
```

Locate an executable through `PATH`:

```bash
which date
```

---

## Command Types

Use `type` to determine how Bash interprets a command:

```bash
type cd
type cp
type ls
type -a ls
```

Examples:

```text
cd     → shell builtin
cp     → external executable
ls     → may also have an alias
```

List aliases:

```bash
alias
```

Example:

```bash
alias ll='ls -alF'
```

`type` is generally more useful than `which` when determining Bash command resolution.

---

## Quoting

### Single Quotes

Prevent shell expansion:

```bash
echo '$HOME'
```

Output:

```text
$HOME
```

### Double Quotes

Allow variable expansion and command substitution but suppress globbing:

```bash
echo "$HOME"
echo "Today is $(date)"
echo "D*"
```

### Command Substitution

Legacy:

```bash
echo "Today is `date`"
```

Preferred:

```bash
echo "Today is $(date)"
```

### Escaping

Use `\` to escape a character:

```bash
echo \$HOME
```

Output:

```text
$HOME
```

---

## Control Statements

Three important operators:

```text
;     run next command regardless
&&    run next command on success
||    run next command on failure
```

Examples:

```bash
echo Hello; echo Linux; echo Student

echo Start && echo Going && echo Gone

echo Success && false && echo Bye

false || echo "Command failed"
```

Exit status:

```text
0          → success
non-zero   → failure
```

Check the previous exit status with:

```bash
echo $?
```

---

## Lab Quick Reference

```text
ls              list files
ls -l           long listing
whoami          effective username
uname -n        node/hostname
pwd             working directory

history         command history
history 5       five latest history entries
!n              execute event n
!-n             execute n events back
!!              previous command

echo "$VAR"     display expanded variable
which command   locate executable through PATH
type command    identify Bash command type
type -a command show all relevant matches
alias           list aliases

'...'           literal quoting
"..."           controlled expansion
\               escape
$(command)      command substitution

;               always continue
&&              continue on success
||              continue on failure
```