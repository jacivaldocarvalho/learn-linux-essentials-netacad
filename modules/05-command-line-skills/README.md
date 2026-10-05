# Module 5 — Command Line Skills

Study notes for Chapter 5 of the Cisco Networking Academy / NDG Linux Essentials course.

> **Lab:** [Module 5 Lab — Command Line Skills](LAB.md)

## Exam Objective

### 2.1 Command Line Basics — Weight 3

Key areas covered:

- Basic shell usage
- Command-line syntax
- Command history
- Shell and environment variables
- `PATH`
- Command types
- Quoting and escaping
- Command substitution
- Basic control statements

---

## 1. The Linux Command Line

Linux graphical environments provide convenient interfaces, but the command line gives users precise control, automation capabilities, and a consistent way to interact with different Linux systems.

Common command-line skills transfer well between Linux distributions even when their graphical environments differ.

```text
Linux CLI
│
├── Precise control
├── Speed
├── Automation
└── Portability
```

---

## 2. Terminal and Shell

A terminal provides the interface where commands are entered.

The shell interprets those commands and interacts with programs and the operating system.

```text
User
 │
 ▼
Terminal
 │
 ▼
Shell
 │
 ▼
Program / Operating System
 │
 ▼
Terminal Output
```

### Bash

**Bash** stands for **Bourne Again Shell**.

It is one of the most commonly encountered Linux shells and provides features such as:

- Command history
- Command-line editing
- Variables
- Aliases
- Functions
- Shell scripting
- Conditional execution

Other shells include `sh`, `dash`, `ksh`, `zsh`, and `fish`.

---

## 3. The Shell Prompt

A typical prompt may look like:

```text
sysadmin@localhost:~$
```

It can indicate:

```text
sysadmin   → username
localhost  → hostname
~          → current directory is the user's home
$          → regular-user prompt convention
```

The prompt is configurable, so these elements should not be treated as authoritative system information.

The `~` character expands to the current user's home directory.

For example:

```bash
echo ~
```

may produce:

```text
/home/sysadmin
```

The root user's home directory is normally `/root`.

---

## 4. Command-Line Syntax

A common command structure is:

```text
command [options] [arguments]
```

Example:

```bash
ls -l /etc
```

Breakdown:

```text
ls      → command
-l      → option
/etc    → argument
```

Options modify command behavior, while arguments usually identify targets or provide input values.

Linux command names and filenames are case-sensitive.

### Short and Long Options

Short options commonly use one dash:

```bash
ls -l
```

Long GNU-style options commonly use two dashes:

```bash
ls --all
```

Some short options can be combined:

```bash
ls -la
```

These are conventions rather than universal rules; option syntax depends on the command.

---

## 5. Arguments

Arguments provide information to a command.

Example:

```bash
ls /etc
```

Here `/etc` is the argument.

Commands can accept multiple arguments:

```bash
cp source.txt destination.txt
```

Argument order can be significant.

When an argument contains spaces, quoting is normally required:

```bash
ls "Linux Notes.txt"
```

---

## 6. Command History

Bash maintains a history of previously executed commands.

Use:

```bash
history
```

to display it.

Useful forms include:

```text
history 5   → show the five most recent entries
!5          → execute history event number 5
!-5         → execute the command five events back
!!          → execute the previous command
!ls         → execute the latest command beginning with "ls"
```

The `!` forms are Bash **history expansion**.

### Arrow-Key Navigation

In an interactive Bash session:

```text
↑  → older command
↓  → newer command
```

A recalled command can be edited before pressing Enter.

Avoid placing secrets directly on command lines because command history may preserve them.

---

## 7. Shell Variables

Variables associate names with values.

Example:

```bash
course="Linux Essentials"
```

There must be no spaces around `=` in this assignment syntax.

Display the value with:

```bash
echo "$course"
```

The `$` causes parameter expansion:

```text
course     → variable name
$course    → expand its value
```

Quoting variable expansions is generally good practice:

```bash
echo "$course"
```

---

## 8. Environment Variables

Environment variables are available in the environment of a process and are normally inherited by child processes.

Common examples include:

```text
HOME
PATH
USER
LANG
```

A shell variable can be exported:

```bash
course="Linux Essentials"
export course
```

or:

```bash
export course="Linux Essentials"
```

Conceptually:

```text
Parent Shell
    │
    │ exported environment
    ▼
Child Process
```

A child process normally cannot modify the environment of its parent process.

### `HOME`

`HOME` identifies the user's home directory:

```bash
echo "$HOME"
```

Example:

```text
/home/sysadmin
```

### `HISTSIZE`

In Bash, `HISTSIZE` controls the maximum number of commands kept in the in-memory history list.

```bash
echo "$HISTSIZE"
```

`HISTSIZE` is a shell variable and does not necessarily need to be exported into the environment.

---

## 9. The `PATH` Variable

`PATH` contains directories used when searching for external commands.

Display it with:

```bash
echo "$PATH"
```

Example structure:

```text
/usr/local/bin:/usr/bin:/bin
```

Directories are separated by colons:

```text
PATH
│
├── /usr/local/bin
├── /usr/bin
└── /bin
```

The search order matters.

If `PATH` is:

```text
/usr/local/bin:/usr/bin:/bin
```

the shell searches `/usr/local/bin` before `/usr/bin`.

### Modifying `PATH`

Prepend a directory:

```bash
PATH=/new/directory:$PATH
```

Append a directory:

```bash
PATH=$PATH:/new/directory
```

Avoid replacing the existing `PATH` unintentionally.

### Current Directory

The current directory is not normally searched automatically unless `.` is present in `PATH`.

An executable in the current directory can be invoked explicitly:

```bash
./program
```

---

## 10. Command Types

A command name does not necessarily correspond directly to an executable file.

Important Bash command categories include:

```text
Command
│
├── Alias
├── Function
├── Shell builtin
└── External executable
```

Bash also recognizes shell keywords and reserved words.

---

## 11. Internal Commands

Internal commands, or **shell builtins**, are implemented inside the shell.

Example:

```bash
type cd
```

Typical result:

```text
cd is a shell builtin
```

`cd` is an important builtin because changing directories must affect the current shell itself.

Other Bash builtins include:

```text
export
history
type
```

---

## 12. External Commands

External commands are executable files stored in the filesystem.

When only a command name is supplied, the shell can use `PATH` to locate the executable.

Example:

```bash
date
```

The executable might be located at:

```text
/usr/bin/date
```

or, depending on the system:

```text
/bin/date
```

Modern distributions may use a merged `/usr` layout where `/bin` points to `/usr/bin`.

An explicit path bypasses the normal `PATH` lookup for the executable name:

```bash
/usr/bin/date
```

---

## 13. `type` and `which`

### `type`

`type` reports how Bash interprets a command name:

```bash
type cd
type ls
```

To display all relevant matches:

```bash
type -a ls
```

It can identify aliases, functions, builtins, and external commands.

### `which`

`which` is commonly used to locate an executable through `PATH`:

```bash
which date
```

Possible output:

```text
/usr/bin/date
```

For understanding Bash command resolution, `type` is generally more informative.

Another commonly useful command is:

```bash
command -v date
```

---

## 14. Aliases

Aliases provide short substitutions for command text.

Example:

```bash
alias ll='ls -l'
```

Now:

```bash
ll
```

is expanded by the interactive shell to:

```bash
ls -l
```

List current aliases with:

```bash
alias
```

Remove one with:

```bash
unalias ll
```

Aliases created interactively normally disappear when the shell ends unless they are configured in a shell startup file such as `~/.bashrc`.

---

## 15. Shell Functions

Functions group reusable shell commands and can implement more complex behavior than aliases.

Example:

```bash
my_report () {
    ls Documents
    date
    echo "Document directory report"
}
```

A function can be inspected with:

```bash
type my_report
```

Functions can also receive arguments and contain shell logic such as conditions and loops.

---

## 16. Quoting

Quoting controls how Bash interprets characters before executing a command.

The most important mechanisms are:

```text
'...'       single quotes
"..."       double quotes
\           escape character
`command`   legacy command substitution
$(command)  preferred command substitution
```

---

## 17. Single Quotes

Single quotes provide strong literal protection.

Example:

```bash
echo '$HOME * `date`'
```

Output:

```text
$HOME * `date`
```

Inside single quotes:

```text
Variable expansion      → disabled
Command substitution    → disabled
Globbing                → disabled
```

---

## 18. Double Quotes

Double quotes suppress pathname expansion and preserve whitespace while still allowing important expansions.

Example:

```bash
echo "$HOME"
```

The variable is expanded.

Command substitution also works:

```bash
echo "Today is $(date)"
```

However:

```bash
echo "*"
```

prints a literal `*` instead of expanding filenames.

Summary:

```text
Inside "..."

$VAR        → expands
$(command)  → executes and substitutes output
* ? [...]   → no pathname expansion
```

---

## 19. Escaping

A backslash can remove the special meaning of the next relevant character.

Example:

```bash
echo \$HOME
```

Output:

```text
$HOME
```

Another example:

```bash
echo Linux\ Essentials
```

The escaped space remains part of the same shell word.

---

## 20. Command Substitution

Command substitution executes a command and substitutes its standard output into the surrounding command.

Legacy syntax:

```bash
echo "Today is `date`"
```

Preferred syntax:

```bash
echo "Today is $(date)"
```

Conceptually:

```text
$(date)
   │
   ▼
execute date
   │
   ▼
capture stdout
   │
   ▼
substitute output
```

`$(...)` is preferred because it is clearer and easier to nest.

---

## 21. Globbing

Shell wildcard patterns can match filesystem names.

Common patterns:

```text
*       zero or more characters
?       exactly one character
[...]   one character matching the set/range
```

Example:

```bash
echo D*
```

could expand to:

```text
Desktop Documents Downloads
```

The expansion is performed by the shell before `echo` receives its arguments.

Double quotes disable this expansion:

```bash
echo "D*"
```

Output:

```text
D*
```

---

## 22. Control Statements

Bash provides operators for sequencing and conditional execution.

```text
command1 ;  command2
command1 && command2
command1 || command2
```

Their behavior depends on the exit status of commands.

```text
0          → success
non-zero   → failure
```

The most recent exit status can be inspected with:

```bash
echo $?
```

### Semicolon — `;`

```bash
command1; command2
```

The second command runs regardless of whether the first succeeds.

```text
; → run next regardless
```

### Logical AND — `&&`

```bash
command1 && command2
```

The second command runs only if the first succeeds.

```text
&& → continue on success
```

Example:

```bash
mkdir project && cd project
```

### Logical OR — `||`

```bash
command1 || command2
```

The second command runs only if the first fails.

```text
|| → continue on failure
```

Example:

```bash
cd project || echo "Unable to enter directory"
```

### Summary

```text
Operator    command1 succeeds    command1 fails

;           run command2         run command2
&&          run command2         skip command2
||          skip command2        run command2
```

The commands `true` and `false` are useful for testing this behavior:

```text
true   → successful exit status
false  → failed exit status
```

---

## 23. Shell Processing Model

Many features from this module become easier to understand when remembering that the shell processes the command line before executing commands.

A simplified model is:

```text
User Input
    │
    ▼
Shell Parsing
    │
    ├── Quoting / escaping
    ├── Variable expansion
    ├── Command substitution
    └── Pathname expansion
    │
    ▼
Final Arguments
    │
    ▼
Command Resolution
    │
    ├── Alias / function / builtin
    └── External command via PATH
    │
    ▼
Execution
    │
    ▼
Exit Status
```

The actual Bash expansion process contains additional stages, but this model is sufficient for the concepts introduced in this module.

---

## 24. Exam Quick Reference

```text
Bash
└── Bourne Again Shell

history
└── display command history

!5
└── execute history event #5

!-5
└── execute command five events back

!!
└── repeat previous command

echo "$VAR"
└── display an expanded variable value

HOME
└── user's home directory

PATH
└── directories used to locate external commands

:
└── separates PATH entries

export
└── mark variable for inheritance by child processes

type
└── determine how Bash interprets a command

which
└── locate an executable through PATH

'...'
└── literal protection

"..."
├── allows variable expansion
├── allows command substitution
└── suppresses globbing

\char
└── escape a character

`command`
└── legacy command substitution

$(command)
└── preferred command substitution

;
└── execute next command regardless

&&
└── execute next command on success

||
└── execute next command on failure

exit status 0
└── success

non-zero exit status
└── failure
```

---

## Key Takeaways

- Bash is a widely used Linux shell.
- Commands commonly follow `command [options] [arguments]`.
- Bash history allows previous commands to be recalled and executed.
- Variables store values that can be expanded with `$`.
- Exported variables can be inherited by child processes.
- `PATH` controls where external commands are searched for.
- `type` identifies how Bash resolves command names.
- Aliases provide command-text substitutions.
- Single and double quotes affect shell expansion differently.
- `$(command)` performs command substitution.
- Backslash escapes individual special characters.
- `;`, `&&`, and `||` control execution of multiple commands.
- Successful commands conventionally return exit status `0`.
