# Module 8 — Managing Files and Directories

Study notes for Chapter 8 of the Cisco Networking Academy / NDG Linux Essentials course.

## 1. Exam Objectives

**LPI Linux Essentials — Objective 2.4: Creating, Moving and Deleting Files**

**Weight:** 2

**Description:** Create, move, and delete files and directories under the home directory.

**Key Knowledge Areas:**
- Files and directories
- Case sensitivity
- Simple globbing
- Creating, copying, moving, renaming, and deleting files
- Creating and removing directories

**Important Commands:**

| Command | Purpose |
|---|---|
| `cp` | Copy files and directories |
| `mv` | Move or rename files and directories |
| `rm` | Remove files and directories |
| `rmdir` | Remove empty directories |
| `mkdir` | Create directories |
| `touch` | Create empty files or update timestamps |
| `ls` | List files and directories |
| `echo` | Display text and expanded shell arguments |
| `cat` | Display file contents |

---

## 2. Files, Directories, and Case Sensitivity

Linux filenames are case-sensitive.

For example, the following names represent three distinct files:

```text
hello.txt
Hello.txt
HELLO.txt
```

The same rule applies to directory names, command names, and paths.

Linux commonly uses UTF-8, a Unicode character encoding compatible with ASCII for its first 128 characters. Actual character encoding behavior depends on the environment and locale.

To inspect the ASCII reference manual:

```bash
man 7 ascii
```

## 3. Globbing and Shell Expansion

Globbing allows the shell to match filenames using patterns called **wildcards**.

The shell expands matching filenames **before executing a command**.

For example:

```bash
echo /etc/t*
```

Conceptually:

```text
Typed command:
echo /etc/t*
         |
         v
Shell searches for matching paths
         |
         v
/etc/terminfo
/etc/timezone
/etc/tmpfiles.d
         |
         v
Expanded command:
echo /etc/terminfo /etc/timezone /etc/tmpfiles.d
         |
         v
echo prints its arguments
```

The expansion is performed by the shell, not by `echo` or `ls`.

### 3.1 Asterisk (`*`)

The `*` wildcard matches **zero or more characters**.

| Pattern | Matches |
|---|---|
| `t*` | Names beginning with `t` |
| `*.txt` | Names ending with `.txt` |
| `r*.conf` | Names beginning with `r` and ending with `.conf` |
| `*` | Names matching any length, subject to shell rules |

Examples:

```bash
echo /etc/t*
echo /etc/*.d
echo /etc/r*.conf
```

An asterisk does not match `/` as a path separator.

By default, Bash also excludes hidden names beginning with `.` from ordinary `*` matches, unless the pattern or shell configuration permits them.

### 3.2 Question Mark (`?`)

The `?` wildcard matches **exactly one character**.

Examples:

```bash
echo /etc/t???????
echo /etc/*.???
```

Pattern interpretation:

```text
t???????
|-------|
8 characters total:
1 literal t + 7 arbitrary characters

*.???
| ||||
| |+++-- exactly 3 characters
| +----- literal dot
+------- zero or more characters
```

The pattern `*.???` matches names ending in a dot followed by exactly three characters.

Combining `*` and `?` makes it possible to match filenames with a minimum length:

```text
????       exactly 4 characters
*????      at least 4 characters
```

### 3.3 Square Brackets (`[ ]`)

Square brackets match **one character from a specified set or range**.

Examples:

```bash
echo /etc/[gu]*
echo /etc/[a-d]*
echo /etc/*[0-9]*
```

| Pattern | Meaning |
|---|---|
| `[gu]` | One character: `g` or `u` |
| `[a-d]` | One character in the range `a` through `d` |
| `[0-9]` | One digit |
| `*[0-9]*` | A name containing at least one digit |

For example:

```text
[gu]*

[gu]   first character is g or u
   *   zero or more additional characters
```

Character range interpretation can depend on the locale. The course explains ranges using ASCII ordering, which is a useful baseline for understanding common examples.

A reversed range such as `[9-0]` is invalid in ordinary range interpretation and should not be used.

### 3.4 Negated Brackets (`[! ]`)

An exclamation mark immediately after `[` negates the character set.

Examples:

```bash
echo /etc/[!DP]*
echo /etc/[!a-t]*
```

| Pattern | Meaning |
|---|---|
| `[abc]` | `a`, `b`, or `c` |
| `[!abc]` | Any matching character except `a`, `b`, or `c` |
| `[0-9]` | One digit |
| `[!0-9]` | One non-digit character |

The negation applies to the **single character position** represented by the bracket expression.

### 3.5 Listing Glob Matches with `ls -d`

A directory argument changes the default behavior of `ls`.

- For a regular file, `ls` displays the filename.
- For a directory, `ls` normally displays its contents.

Suppose `/etc/x*` matches only `/etc/xdg`.

```bash
ls /etc/x*
```

This lists the contents of `/etc/xdg`, rather than displaying the matching directory name.

Use `-d` to list the directory entry itself:

```bash
ls -d /etc/x*
```

Expected result:

```text
/etc/xdg
```

To view metadata for the matched entry:

```bash
ls -ld /etc/x*
```

**Exam distinction:**

```text
ls directory/       -> list directory contents
ls -d directory/    -> show directory entry
ls -ld directory/   -> show directory metadata
```

---

## 4. Copying Files with `cp`

The `cp` command copies files from a source to a destination.

Syntax:

```bash
cp source destination
```

Example:

```bash
cp /etc/hosts ~
```

The `~` character expands to the current user's home directory.

```text
Before:

/etc/
└── hosts

/home/sysadmin/


After cp /etc/hosts ~:

/etc/
└── hosts                  original remains

/home/sysadmin/
└── hosts                  new copy
```

Successful `cp` operations normally produce no output.

### 4.1 Verbose Copying (`-v`)

Use `-v` to display information about completed copy operations:

```bash
cp -v /etc/hosts ~
```

Example output:

```text
'/etc/hosts' -> '/home/sysadmin/hosts'
```

### 4.2 Copying Under a Different Name

Specify a filename as part of the destination:

```bash
cp /etc/hosts ~/hosts.copy
```

The resulting file is named `hosts.copy`, while the source remains unchanged.

### 4.3 Preventing Accidental Overwrites

By default, `cp` may overwrite an existing destination file.

The course introduces two protective options:

| Option | Meaning | Behavior |
|---|---|---|
| `-i` | Interactive | Ask before overwriting |
| `-n` | No clobber | Do not overwrite an existing destination |

Examples:

```bash
cp -i /etc/hosts ~/hosts.copy
cp -n /etc/hosts ~/hosts.copy
```

With `-i`, the user can accept or reject a proposed overwrite.

With `-n`, existing destination files are skipped without an interactive question.

For modern GNU Coreutils, some details of `-n` and exit status behavior vary by version. The exam-level purpose is preventing overwrites.

### 4.4 Copying Directories Recursively

By default, `cp` does not copy directory contents recursively.

Use `-r` or `-R`:

```bash
cp -r source_directory destination_directory
```

Example:

```bash
cp -r ~/Documents ~/Documents-backup
```

If `Documents-backup` does not already exist, the command creates a copy of the directory structure under that name.

```text
Documents/
├── notes.txt
└── Projects/
    └── project.txt

       cp -r
         |
         v

Documents-backup/
├── notes.txt
└── Projects/
    └── project.txt
```

If the destination directory already exists, the source directory is normally copied **inside** it.

**Important:** Recursive copying can consume substantial storage and time when directories contain many files.

For GNU `cp`, `-r` and `-R` are equivalent. Option meanings are command-specific: `ls -r`, for example, means reverse sorting.

---

## 5. Moving and Renaming with `mv`

The `mv` command moves or renames files and directories.

Syntax:

```bash
mv source destination
```

Example:

```bash
mv hosts Videos
```

The file `hosts` moves from the current directory into `Videos`.

```text
Before:

~/hosts
~/Videos/

After:

~/Videos/hosts
```

Unlike `cp`, `mv` does not leave a separate file at the original path after a successful move.

### 5.1 Renaming Files

Use a different destination filename:

```bash
mv oldname.txt newname.txt
```

The file remains in the current directory but receives a new name.

To move and rename in one operation:

```bash
mv example.txt Videos/newexample.txt
```

The file moves to `Videos` and becomes `newexample.txt`.

### 5.2 Move Options

| Option | Meaning |
|---|---|
| `-i` | Ask before overwriting |
| `-n` | Do not overwrite an existing destination |
| `-v` | Show details of the move |

Examples:

```bash
mv -i source.txt destination.txt
mv -n source.txt destination.txt
mv -v source.txt Videos/
```

### 5.3 Moving Directories

Unlike `cp`, **`mv` does not require `-r`** to move directories.

```bash
mv Documents Backup/
```

If `Backup/` exists, `Documents` moves inside it.

When moving within the same filesystem, the operation normally changes filesystem directory entries rather than copying every file individually.

Moving across filesystems may require copying data and removing the original, but the user-facing command remains `mv`.

### 5.4 Permissions and Moving Files

Moving a file requires suitable permissions on the relevant directories.

For example:

```bash
mv /etc/hosts .
```

An ordinary user may receive:

```text
Permission denied
```

Moving a file out of `/etc` requires permissions that typical non-administrative users do not possess.

For ordinary moves within a filesystem, write and execute permissions on the relevant parent directories are generally important.

---

## 6. Creating Files with `touch`

The `touch` command creates an empty file if the specified path does not exist.

```bash
touch sample
```

Check the result:

```bash
ls -l sample
```

A newly created empty file has a size of **0 bytes**.

```text
Before:
~/Documents/

After touch sample:
~/Documents/
~/sample                 0 bytes
```

Empty files can serve as placeholders or as markers checked by applications and services.

If the file already exists, `touch` normally updates its access and modification timestamps without changing its contents.

| File state | `touch` behavior |
|---|---|
| Does not exist | Create an empty file |
| Already exists | Update timestamps; preserve contents |

---

## 7. Removing Files with `rm`

The `rm` command removes files.

```bash
rm sample
```

Successful removal normally produces no output.

**Warning:** Files removed using `rm` are not sent to the desktop trash. There is no standard automatic undo operation.

### 7.1 Removing Multiple Files with Globs

Example:

```bash
rm *.txt
```

The shell expands `*.txt` into matching filenames before `rm` runs.

```text
rm *.txt
   |
   v
Shell expansion
   |
   v
rm example.txt sample.txt test.txt
   |
   v
Matching files are removed
```

A broad or incorrect pattern can delete unintended files.

### 7.2 Interactive Removal (`-i`)

Use `-i` to request confirmation for each removal:

```bash
rm -i *.txt
```

Example interaction:

```text
remove 'example.txt'? y
remove 'sample.txt'? n
remove 'test.txt'? y
```

In this example, `sample.txt` is preserved.

A useful precaution is to inspect matching names before deletion:

```bash
ls -d -- *.txt
```

Then, if the selection is correct:

```bash
rm -i -- *.txt
```

The `--` marker ends command-option parsing, protecting filenames beginning with a hyphen from being interpreted as options.

---

## 8. Removing Directories

### 8.1 Recursive Removal with `rm -r`

By default, `rm` does not remove directories:

```bash
rm Videos
```

Example error:

```text
rm: cannot remove 'Videos': Is a directory
```

Use `-r` to remove a directory and its contents:

```bash
rm -r Videos
```

```text
Before:

Videos/
├── hosts
└── myfile.txt

After rm -r Videos:

Videos/ no longer exists
```

This can remove an entire directory tree without asking questions.

For interactive recursive removal:

```bash
rm -ri Videos
```

The `-i` option requests confirmation as the recursive removal proceeds.

### 8.2 Empty Directory Removal with `rmdir`

The `rmdir` command removes **empty directories only**.

```bash
rmdir EmptyDirectory
```

If the directory contains files or subdirectories:

```bash
rmdir Documents
```

The command fails with an error such as:

```text
Directory not empty
```

### 8.3 Removal Command Comparison

| Command | Behavior |
|---|---|
| `rm file` | Remove a file |
| `rm -i file` | Ask before removing a file |
| `rm -r directory` | Remove a directory recursively |
| `rm -ri directory` | Recursive removal with confirmations |
| `rmdir directory` | Remove an empty directory only |

---

## 9. Creating Directories with `mkdir`

The `mkdir` command creates directories.

Syntax:

```bash
mkdir directory_name
```

Example:

```bash
mkdir test
```

Result:

```text
Before:

~/Documents/
~/Downloads/

After:

~/Documents/
~/Downloads/
~/test/
```

The directory is created relative to the current working directory unless another path is specified.

Directory names are case-sensitive:

```text
test/
Test/
```

These can represent two different directories.

Creating a directory requires suitable permissions in its parent directory.

If an entry with the requested name already exists, `mkdir` normally reports an error.

---

## 10. Command Options: Important Distinctions

The same option letter may have different meanings depending on the command.

| Command | Option | Meaning |
|---|---|---|
| `cp -r` | `-r` | Recursive copy |
| `cp -R` | `-R` | Recursive copy |
| `rm -r` | `-r` | Recursive removal |
| `ls -r` | `-r` | Reverse sort |
| `ls -R` | `-R` | Recursive listing |
| `cp -i` | `-i` | Confirm overwrites |
| `mv -i` | `-i` | Confirm overwrites |
| `rm -i` | `-i` | Confirm removals |
| `cp -n` | `-n` | Avoid overwriting |
| `mv -n` | `-n` | Avoid overwriting |
| `cp -v` | `-v` | Verbose copying |
| `mv -v` | `-v` | Verbose moving |

The `mv` command handles directories without a recursive option.

---

## 11. Quick Reference

### Globbing

| Pattern | Meaning |
|---|---|
| `*` | Zero or more characters |
| `?` | Exactly one character |
| `[abc]` | One character from a set |
| `[a-z]` | One character from a range |
| `[!abc]` | One character not in a set |
| `*.txt` | Names ending in `.txt` |
| `file?` | `file` followed by one character |
| `*[0-9]*` | Names containing a digit |
| `ls -d pattern` | Display matching entries without listing directory contents |

### File and Directory Operations

| Command | Purpose |
|---|---|
| `cp file target/` | Copy a file |
| `cp -v file target/` | Copy with verbose output |
| `cp -i file target/` | Confirm before overwriting |
| `cp -n file target/` | Avoid overwriting |
| `cp -r dir target/` | Copy a directory recursively |
| `mv file target/` | Move a file |
| `mv old new` | Rename a file |
| `mv -i old new` | Confirm before overwriting |
| `mv -n old new` | Avoid overwriting |
| `touch file` | Create an empty file or update timestamps |
| `rm file` | Remove a file |
| `rm -i file` | Confirm before removal |
| `rm -r dir` | Remove a directory tree |
| `rm -ri dir` | Confirm recursive removal |
| `rmdir dir` | Remove an empty directory |
| `mkdir dir` | Create a directory |

---

## 12. Knowledge Check

**1. Does `cp` require a source and a destination?**

Yes. Its basic syntax is:

```bash
cp source destination
```

**2. Which two `cp` options help prevent accidental overwrites?**

`-i` and `-n`.

**3. What does `rm -r` do?**

Removes a directory and its files and subdirectories recursively.

**4. Which `rm` option requests confirmation?**

`-i`.

**5. Which command renames a file?**

`mv`.

**6. What are two common uses of `touch`?**

Creating empty files and updating timestamps of existing files.

**7. Which three constructs are the primary globbing wildcards?**

`*`, `?`, and `[ ]`.

**8. Why use globbing?**

To expand filename patterns into lists of matching pathnames supplied to commands.

**9. What does `*` represent?**

Zero or more characters.

**10. Which patterns match the three names `gai.conf`, `pam.conf`, and `ucf.conf`?**

Both of the following match all three:

```bash
echo /etc/*?.*o?
echo /etc/???.*f
```

The first pattern requires a filename with at least one character before the dot and a suffix ending in `o` followed by one character.

The second requires exactly three characters before the dot and a suffix ending in `f`.

Other files may also match these patterns; globbing does not inherently restrict results to exactly those three filenames.

---

## 13. Key Takeaways

1. Linux filenames are case-sensitive.
2. The shell expands glob patterns before commands execute.
3. `*` matches zero or more characters, while `?` matches exactly one.
4. `[ ]` selects one character from a set or range; `[! ]` negates the set.
5. Use `ls -d` when you want to display matching directory names instead of their contents.
6. `cp` copies files, and `cp -r` copies directories recursively.
7. `cp -i` and `cp -n` help protect existing destination files.
8. `mv` moves or renames files and directories without requiring `-r`.
9. `touch` creates empty files or updates existing file timestamps.
10. `rm` removes files without using the desktop trash.
11. `rm -r` removes directory trees; `rmdir` removes only empty directories.
12. `mkdir` creates directories.
13. Recursive operations and glob patterns should be checked carefully before execution.

**Exam focus:** Understand glob expansion, recognize the differences between copying and moving, distinguish interactive and no-clobber options, and know which commands create or remove files and directories.