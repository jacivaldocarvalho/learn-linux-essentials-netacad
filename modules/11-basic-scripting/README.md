# Module 11 — Basic Scripting

Study notes for **Cisco Networking Academy / NDG Linux Essentials**, Chapter 11. The examples are original learning exercises based on the chapter concepts. Companion runnable scripts are in [`code/`](code/).

## 1. Exam objectives

**LPI Linux Essentials — 3.3: Turning Commands into a Script**  
**Weight:** 4  
**Objective:** Turn repetitive commands into simple scripts.

**Key knowledge areas:**
- Basic shell scripting (Section 11.2)
- Awareness of common text editors: `vi` and `nano` (Section 11.3)

| Term or tool | Purpose |
| --- | --- |
| `#!` | Shebang: selects an interpreter for direct execution |
| `/bin/bash`, `/bin/sh`, `/bin/csh` | Interpreter paths |
| `echo`, `read` | Display output and read input |
| Variables and arguments | Store and pass information |
| Exit status | Report success or failure |
| `if`, `case` | Conditional execution |
| `for`, `while` | Repeated execution |
| `nano`, `vi` | Plain-text editors |

## 2. Shell scripts and execution

A shell script is a plain-text file containing commands. Scripts reuse shell tools and add control flow, making repeated tasks consistent.

```bash
#!/bin/bash
echo "Hello, World!"
```

Two ways to run a script:

```bash
bash test.sh           # Interpreter reads the file; execute bit not required
chmod +x test.sh       # Give the file executable permission
./test.sh             # Run directly from the current directory
```

The current directory is normally absent from `$PATH`, so `./` specifies its location. `Permission denied` on direct execution can mean the execute permission is missing; other permission or filesystem restrictions can also cause it.

### Shebang

```bash
#!/bin/sh
#!/bin/bash
#!/bin/csh
```

These are alternative *first lines*, not lines to use together. The `#!` sequence identifies the interpreter for direct execution. Explicitly invoking `sh script.sh` or `bash script.sh` uses that interpreter instead, regardless of the shebang. Shell syntax is not necessarily portable between interpreters.

## 3. Editing scripts: nano and vi

`nano` is a straightforward terminal text editor; `vi` (and `vim`) is a modal editor with more advanced capabilities. Both edit plain text, unlike a word processor's formatted document files.

```bash
nano test.sh
vi test.sh
```

| nano shortcut | Action |
| --- | --- |
| `Ctrl+O` | Save (write out) |
| `Ctrl+X` | Exit; prompts to save modified content |
| `Ctrl+W` | Search |
| `Ctrl+W`, then `Ctrl+R` | Search and replace (as presented in the chapter) |
| `Ctrl+K` / `Ctrl+U` | Cut / paste |
| `Ctrl+G` | Help |
| `Ctrl+Y` / `Ctrl+V` | Page up / page down |
| `Ctrl+C` | Cursor position and file information |

In `nano`, `^X` means `Ctrl+X`. When prompted on exit, `Y` saves and `N` discards changes. An introductory `vi` workflow is `i` to enter insert mode, `Esc` to return to command mode, `:wq` to save and quit, or `:q!` to quit without saving (additional practical context; the chapter focuses on `nano`).

## 4. Variables and command substitution

```bash
ANIMAL="penguin"             # No spaces around =
SOMETHING="$ANIMAL"           # Access a variable with $
echo "My favorite animal is a $SOMETHING"
CURRENT_DIRECTORY=$(pwd)     # Capture stdout from a command
```

The chapter also demonstrates the older backtick form:

```bash
CURRENT_DIRECTORY=`pwd`
```

`$(pwd)` is a clearer modern equivalent. Use double quotes around expansions when you want to preserve spaces as part of one argument. `NAME = value` is **not** a variable assignment.

### Input and positional arguments

```bash
echo -n "What is your name? "
read NAME
echo "Hello $NAME!"
```

When invoked as `./test.sh hello goodbye`:

| Expansion | Value / meaning |
| --- | --- |
| `$0` | `./test.sh` (invocation name) |
| `$1` | `hello` |
| `$2` | `goodbye` |
| `$#` | Number of positional arguments (2) |
| `$$` | Current shell process ID |
| `$?` | Exit status of the most recently completed command |

`$#` and `$$` are useful related Bash special parameters beyond the chapter's main examples.

## 5. Exit status and comments

Commands return an integer exit status. **0 means success**; nonzero values represent failures or other command-defined outcomes.

```bash
grep -q root /etc/passwd
echo "$?"                 # 0 if a match was found

grep -q unlikely_name /etc/passwd
echo "$?"                 # 1 if no match (2 for a grep error)

# This is a comment
exit 1                    # End a script with status 1
```

`grep -q` suppresses normal output, allowing the exit status to drive a decision. Read `$?` immediately: running another command updates it.

## 6. Conditional execution

### if / else / elif

An `if` tests a command's **exit status**, not its printed output.

```bash
if grep -q root /etc/passwd; then
    echo "root is in the password file"
else
    echo "root is missing from the password file"
fi
```

```bash
if [ "$1" = "hello" ]; then
    echo "hello yourself"
elif [ "$1" = "goodbye" ]; then
    echo "nice to have met you"
else
    echo "I didn't understand that"
fi
```

### test and `[ ... ]`

`test EXPRESSION` and `[ EXPRESSION ]` are equivalent for the cases below. **Spaces around the brackets are required**; `]` is a separate argument.

| Test | Meaning |
| --- | --- |
| `[ -f file.txt ]` | Existing regular file |
| `[ ! -f file.txt ]` | Not an existing regular file |
| `[ -d /tmp ]` | Existing directory |
| `[ -x file.sh ]` | Executable by current user |
| `[ 1 -eq 1 ]` | Numeric equality |
| `[ 1 -ne 2 ]` | Numeric inequality |
| `[ 3 -gt 2 ]` / `[ 2 -lt 3 ]` | Greater than / less than |
| `[ 3 -ge 3 ]` / `[ 2 -le 2 ]` | Greater-or-equal / less-or-equal |
| `[ "a" = "a" ]` | String equality |
| `[ "a" != "b" ]` | String inequality |

Numeric comparison and string comparison differ: `01` and `1` compare equal numerically, but not as strings. The chapter also introduces `test` operators `-a` (AND) and `-o` (OR); in Bash, separate tests connected by `&&` or `||` are generally clearer.

Example of creating a missing directory:

```bash
TARGET=/tmp/foo
if [ ! -d "$TARGET" ]; then
    mkdir "$TARGET"
fi
```

If `/tmp/foo` is an existing *regular file*, `! -d` is true, but `mkdir` fails because the path is occupied. The test does not guarantee the path is unused.

### case

```bash
case "$1" in
    hello|hi) echo "hello yourself" ;;
    goodbye) echo "nice to have met you" ;;
    *) echo "I didn't understand that" ;;
esac
```

`|` separates alternative patterns, `;;` ends a matching branch, `*` matches anything, and `esac` closes `case`. The first matching branch executes.

## 7. Loops and arithmetic

### for — iterate over a list

```bash
SERVERS="servera serverb serverc"
for S in $SERVERS; do
    echo "Doing something to $S"
done

for NAME in Sean Jon Isaac David; do
    echo "Hello $NAME"
done

for ITEM in *; do
    echo "$ITEM"
done
```

`*` here is a **shell glob**, not a regular-expression quantifier. The shell expands it to matching names in the current directory (with behavior depending on matches and shell settings).

### while — test each iteration

```bash
i=0
while [ "$i" -lt 10 ]; do
    echo "$i"
    i=$(( i + 1 ))
done
echo "Done counting"
```

The loop prints 0 through 9. `$(( i + 1 ))` computes a value; **`i=$(( i + 1 ))` stores** the incremented value. If a `while` condition never becomes false, the loop can continue indefinitely.

| Property | `for` | `while` |
| --- | --- | --- |
| Iteration | Elements in a list | As long as a test succeeds |
| Typical use | Files, names, servers | Counters, waiting for a condition |
| Closing keyword | `done` | `done` |

## 8. Runnable examples (`code/`)

| Script | Topic | How to run |
| --- | --- | --- |
| [`01-hello-world.sh`](code/01-hello-world.sh) | `echo`, `date`, shebang | `bash code/01-hello-world.sh` |
| [`02-variables.sh`](code/02-variables.sh) | Variables and `$(pwd)` | `bash code/02-variables.sh` |
| [`03-user-input.sh`](code/03-user-input.sh) | `read` | `bash code/03-user-input.sh` |
| [`04-arguments.sh`](code/04-arguments.sh) | `$0`, `$1`, `$#` | `bash code/04-arguments.sh World` |
| [`05-exit-status.sh`](code/05-exit-status.sh) | `grep -q`, exit status | `bash code/05-exit-status.sh` |
| [`06-conditionals.sh`](code/06-conditionals.sh) | `if`, `elif`, `test` | `bash code/06-conditionals.sh hello` |
| [`07-case.sh`](code/07-case.sh) | `case` patterns | `bash code/07-case.sh hi` |
| [`08-for-loops.sh`](code/08-for-loops.sh) | Lists and globbing | `bash code/08-for-loops.sh` |
| [`09-while-loop.sh`](code/09-while-loop.sh) | `while`, arithmetic | `bash code/09-while-loop.sh` |

All examples are intentionally small. They do not create, overwrite, or remove files; the file-creation example in Section 6 is documentation only. Run from the module directory for the commands above.

## 9. Common exam pitfalls

1. **Shebang vs explicit interpreter:** `./test.sh` honors the shebang; `bash test.sh` selects Bash explicitly.
2. **Execute permission:** `./test.sh` generally needs execute permission; `bash test.sh` reads the file as input.
3. **Assignment syntax:** `A=pwd` stores literal text; `A=$(pwd)` stores command output. Do not add spaces around `=`.
4. **Positional parameters:** `$1` is the first argument, `$2` the second, `$?` the previous exit status, `$0` the invocation name.
5. **Exit code logic:** `if` and `while` treat **0 as true/success**.
6. **File tests:** `-f` means regular file, `-d` directory; `!` negates the test.
7. **Comparison type:** `-eq` compares numbers; `=` compares strings.
8. **Brackets:** `[ -f file ]` is valid; `[ -f file]` is not.
9. **Arithmetic:** `$(( i + 1 ))` does not update `i` unless assigned.
10. **Typographic dashes:** use ASCII `-d`, `-f`, `-eq`, `-n` in actual shell commands, not an en dash (`–`).
11. **Loop file creation:** `command > /tmp/foo` creates or truncates the output file *before* starting the command if redirection succeeds. A loop checking `[ ! -f /tmp/foo ]` will normally stop after the first iteration.

## 10. Module quiz review (10 questions)

| # | Correct answer | Why |
| --- | --- | --- |
| 1 | **4 — `/bin/csh` interprets the script** | Shebang specifies the interpreter for direct execution. |
| 2 | **3 and 4 — `vi`, `nano`** | Both are plain-text editors. |
| 3 | **2 — Creates `/tmp/foo` if absent** | `[ ! -d "$FOO" ]` tests for the absence of a directory; `mkdir` attempts creation. |
| 4 | **4 and 5 — `for` list; `while` test** | List iteration versus conditional repetition. |
| 5 | **2 — If `goodbye` is a file** | `./test.sh hello goodbye` sets `$2` to `goodbye`; `-f` tests a regular file. |
| 6 | **5 — `` A=`pwd` ``** | Backticks perform command substitution; `A=$(pwd)` is an equivalent modern form. |
| 7 | **3 — Previous command's exit code** | `$?` contains the latest exit status. |
| 8 | **1 — `test "$USERS" -eq 5`** | `-eq` is numeric equality. |
| 9 | **3 and 4 — At most once; skip if file exists** | Output redirection creates `/tmp/foo`, causing the next `! -f` test to fail. |
| 10 | **4 — Add 1 to `i`** | Arithmetic expansion computes `i + 1`; assignment is required to update `i`. |

**Technical qualifications to quiz wording:**

- **Q3:** If `/tmp/foo` exists as a regular file, `! -d` still succeeds, but `mkdir` fails. The intended answer assumes an absent path.
- **Q9:** The “at most once” result assumes the redirection successfully creates a regular file. If creation fails, the loop's behavior can differ. A preexisting directory named `/tmp/foo` also is not a regular file.
- **Q10:** The expression `$(( $i + 1 ))` calculates the increment; it does not itself change the stored variable.

## 11. Quick reference

| Task | Syntax |
| --- | --- |
| Create/edit script | `nano script.sh` |
| Run with Bash | `bash script.sh` |
| Make executable | `chmod +x script.sh` |
| Execute locally | `./script.sh` |
| Assign variable | `A="value"` |
| Expand variable | `"$A"` |
| Capture command output | `A=$(pwd)` |
| Read input | `read NAME` |
| First/second argument | `$1` / `$2` |
| Previous exit status | `$?` |
| Return failure | `exit 1` |
| Check file / directory | `[ -f path ]` / `[ -d path ]` |
| Compare numbers | `[ "$A" -eq 5 ]` |
| Compare strings | `[ "$A" = "hello" ]` |
| Conditional | `if ...; then ...; fi` |
| Multi-way choice | `case "$1" in ... esac` |
| Iterate list | `for X in a b; do ...; done` |
| Conditional loop | `while [ condition ]; do ...; done` |
| Increment variable | `i=$(( i + 1 ))` |

---

## 12. vi / vim — Essential Keyboard Shortcuts

The `vi` editor is a standard Unix text editor, while `vim` (*Vi IMproved*) is an enhanced implementation. Unlike `nano`, `vi` is a **modal editor**, meaning that keys perform different actions depending on the current mode.

### Editor Modes

| Mode | Purpose | How to Enter |
|---|---|---|
| Normal mode | Navigate and execute editing commands | Press `Esc` |
| Insert mode | Type and modify text | Press `i`, `a`, or `o` |
| Command-line mode | Save, quit, search-related settings, and other commands | Press `:` in Normal mode |

### Opening and Closing Files

| Command | Description |
|---|---|
| `vi script.sh` | Open or create a file |
| `i` | Enter Insert mode before the cursor |
| `a` | Enter Insert mode after the cursor |
| `o` | Insert a new line below and enter Insert mode |
| `Esc` | Return to Normal mode |
| `:w` | Save the file |
| `:q` | Quit the editor |
| `:wq` | Save and quit |
| `:x` | Save if modified and quit |
| `:q!` | Quit without saving changes |

### Navigation

| Shortcut | Description |
|---|---|
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |
| `0` | Move to the beginning of the line |
| `$` | Move to the end of the line |
| `gg` | Go to the first line (Vim) |
| `G` | Go to the last line |
| `5G` | Go to line 5 |
| `w` | Move to the next word |
| `b` | Move to the previous word |

### Editing Text

| Shortcut | Description |
|---|---|
| `x` | Delete the character under the cursor |
| `dd` | Delete (cut) the current line |
| `yy` | Copy (yank) the current line |
| `p` | Paste after the cursor or below the current line |
| `P` | Paste before the cursor or above the current line |
| `u` | Undo the last change |
| `Ctrl + r` | Redo an undone change (Vim) |
| `cw` | Change text through the end of the word |
| `D` | Delete from the cursor to the end of the line |

### Searching

| Shortcut | Description |
|---|---|
| `/pattern` | Search forward for a pattern |
| `?pattern` | Search backward for a pattern |
| `n` | Repeat the search in the same direction |
| `N` | Repeat the search in the opposite direction |

### Practical Example

Open a shell script:

```bash
vi hello.sh
```

1. Press `i` to enter Insert mode.
2. Type the following script:

```bash
#!/bin/bash
echo "Hello, Linux Essentials!"
```

3. Press `Esc` to return to Normal mode.
4. Type `:wq` and press `Enter` to save and exit.
5. Run the script:

```bash
chmod +x hello.sh
./hello.sh
```

Expected output:

```text
Hello, Linux Essentials!
```

### LPI Linux Essentials Exam Tips

- `vi` and `nano` are both suitable for editing plain-text shell scripts.
- `vi` uses different editing modes; `nano` is more straightforward for beginners.
- Press `Esc` before entering commands such as `:wq` or `:q!`.
- Remember the essential commands: `i`, `Esc`, `:w`, `:q`, `:wq`, and `:q!`.
- The `.sh` extension is conventional, but it is not required for a shell script to run.

**Source:** Cisco Networking Academy / NDG Linux Essentials, Chapter 11, Sections 11.1–11.4.3, and the ten chapter review questions provided during study. Explanations and scripts are independently written study material.
