# Module 10 — Working With Text

Study notes for Module 10 of the Cisco Networking Academy / NDG **Linux Essentials** course, aligned with the **LPI Linux Essentials** certification.

## 1. Exam Objectives

**LPI Linux Essentials — Objective 3.2: Searching and Extracting Data from Files**  
**Weight:** 3

This module develops the ability to inspect text, extract selected data, filter lines using regular expressions, combine commands with pipes, and redirect input and output.

**Key commands and concepts:** `cat`, `less`, `more`, `head`, `tail`, `nl`, `sort`, `wc`, `cut`, `grep`, `grep -E`, pipes (`|`), standard streams, and redirection operators.

| Area | Skills |
|---|---|
| Viewing text | Display entire files or inspect portions of them |
| Pipelines | Feed one command's standard output into another command |
| Redirection | Send standard input, output, and errors to or from files |
| Text processing | Sort lines, count data, and extract fields or character positions |
| Searching | Match literal text and regular expressions |

## 2. Viewing Text Files

Text files contain textual data without the formatting typically associated with word-processing documents. Linux provides several utilities to inspect them directly in a terminal.

### 2.1. `cat`: Displaying and Combining Files

```bash
cat notes.txt
cat first.txt second.txt
cat -n notes.txt
```

`cat` writes file contents to standard output. When given multiple files, it displays their contents consecutively. The `-n` option numbers all output lines, including blank lines.

### 2.2. `less` and `more`: Paginated Viewing

```bash
less /etc/passwd
more /etc/passwd
```

Pagers are useful when a file is longer than the terminal window. `less` provides convenient forward/backward navigation and searching.

Common `less` controls:

| Key | Action |
|---|---|
| `Space` or `Page Down` | Move forward one screen |
| `b` or `Page Up` | Move backward one screen |
| `/pattern` | Search forward |
| `n` / `N` | Next / previous search match |
| `q` | Quit |

### 2.3. `head` and `tail`: Viewing File Portions

```bash
head /etc/passwd
head -n 5 /etc/passwd
tail -n 5 /etc/passwd
tail -f application.log
```

By default, `head` and `tail` display the first or last **10 lines**, respectively. `-n` specifies a different number of lines. `tail -f` follows a file as new content is appended, which is especially useful for logs. Stop following with `Ctrl+C`.

### 2.4. `nl`: Numbering Lines

```bash
nl notes.txt
```

`nl` adds line numbers to text. By default, it numbers nonempty lines, unlike `cat -n`, which numbers blank lines as well.

## 3. Pipes and Command Pipelines

A pipe (`|`) connects the **STDOUT** of one command to the **STDIN** of the next command.

```bash
cat /etc/passwd | less
ls /etc/ssh | nl | tail -n 5
```

Pipelines process data from left to right. **Command order changes the result.**

```bash
ls /etc/ssh | nl | tail -n 5
ls /etc/ssh | tail -n 5 | nl
```

In the first pipeline, `nl` numbers the complete listing before `tail` selects its last five lines. In the second, `tail` selects five lines first and `nl` numbers only that selection.

A pipe normally passes STDOUT, **not STDERR**, to the next command.

## 4. Standard Streams and I/O Redirection

### 4.1. Standard File Descriptors

| Descriptor | Stream | Purpose |
|---|---|---|
| `0` | STDIN | Standard input |
| `1` | STDOUT | Standard output |
| `2` | STDERR | Standard error |

Normally, commands read STDIN from the terminal and write STDOUT and STDERR to the terminal. Redirection changes those destinations or sources.

### 4.2. Output and Error Redirection

```bash
echo 'Linux' > output.txt       # Create or overwrite
echo 'Essentials' >> output.txt # Append
ls /root 2> error.log          # Redirect STDERR
ls /root > output.log 2> error.log
ls /root &> combined.log       # Redirect STDOUT and STDERR (Bash)
```

| Operator | Effect |
|---|---|
| `>` or `1>` | Redirect STDOUT; truncate an existing destination |
| `>>` or `1>>` | Append STDOUT without truncating existing contents |
| `2>` | Redirect STDERR; truncate an existing destination |
| `2>>` | Append STDERR |
| `&>` | Redirect both STDOUT and STDERR in Bash |
| `<` | Supply STDIN from a file |

Both `>` and `>>` create the target file when it does not exist, provided permissions allow it. **Only `>>` preserves existing content by appending.**

### 4.3. Input Redirection

```bash
tr 'a-z' 'A-Z' < input.txt
```

`<` supplies the file as the command's standard input. Here, `tr` converts lowercase ASCII letters to uppercase and prints the result to STDOUT; it does not modify `input.txt`.

**Exam note:** `2>` is specifically for error output. A plain `>` does not capture STDERR.

## 5. Sorting Text with `sort`

`sort` orders input lines, normally using a locale-dependent lexicographic comparison.

```bash
sort names.txt
sort -r names.txt
sort -n numbers.txt
```

| Option | Meaning |
|---|---|
| `-r` | Reverse sort order |
| `-n` | Compare numeric values |
| `-t CHAR` | Set a field delimiter |
| `-k KEY` | Select a sort key |

### 5.1. Sorting Delimited Records

```bash
sort -t: -n -k3 mypasswd
sort -t, -k2 -k1n -k3 os.csv
```

The first command sorts colon-delimited records numerically using the third field as its key. The second demonstrates multiple keys in a comma-delimited file.

**Precision matters:** A key such as `-k2` extends from field 2 to the end of the record unless an ending position is specified. To restrict comparison to individual fields, use explicit ranges:

```bash
sort -t, -k2,2 -k1,1n -k3,3 os.csv
```

This compares field 2, then field 1 numerically, then field 3.

## 6. Counting Lines, Words, and Bytes with `wc`

```bash
wc notes.txt
wc -l notes.txt
wc -w notes.txt
wc -c notes.txt
ls /etc/ | wc -l
```

| Option | Counts |
|---|---|
| `-l` | Newline characters (commonly used as a line count) |
| `-w` | Words |
| `-c` | Bytes |

Without an option, `wc` reports lines, words, and bytes. **Bytes are not necessarily characters:** multibyte encodings such as UTF-8 can represent one character with several bytes.

The pipeline `ls /etc/ | wc -l` counts output lines from `ls`; it is not a universally reliable file count when filenames contain newlines or listing formats differ.

## 7. Extracting Fields and Characters with `cut`

`cut` selects parts of each input line. It is particularly useful for records with consistent delimiters.

```bash
cut -d: -f1 /etc/passwd
cut -d: -f1,5-7 mypasswd
cut -c1-11,50- report.txt
```

| Option | Purpose |
|---|---|
| `-d CHAR` | Set the field delimiter |
| `-f LIST` | Select fields |
| `-c LIST` | Select character positions |

Ranges include `1-3` (positions 1 through 3) and `5-` (position 5 onward). A list such as `1,5-7` selects field 1 and fields 5–7.

**Limitation:** Position-based extraction is fragile when input is not fixed-width. For example, columns produced by `ls -l` vary in width, so fixed character offsets may not reliably identify a field.

## 8. Searching File Contents with `grep`

`grep` prints lines that match a search pattern. By default, matching is **case-sensitive**, and matching text may occur anywhere in a line.

```bash
grep 'bash' /etc/passwd
grep -i 'bash' /etc/passwd
grep -n 'root' /etc/passwd
grep -v 'nologin' /etc/passwd
grep -c 'root' /etc/passwd
grep -w 'root' /etc/passwd
grep --color 'root' /etc/passwd
```

| Option | Purpose |
|---|---|
| `-i` | Ignore case |
| `-n` | Show matching line numbers |
| `-v` | Invert the match; show nonmatching lines |
| `-c` | Count matching lines |
| `-w` | Match whole words |
| `--color` | Highlight matching text |
| `-E` | Use Extended Regular Expressions |

**Exam note:** `grep -c` counts matching **lines**, not every individual occurrence of the pattern.

## 9. Basic Regular Expressions (BRE)

Regular expressions describe patterns rather than only literal strings. Quote patterns to protect special characters from interpretation by the shell.

| Expression | Meaning | Example |
|---|---|---|
| `.` | Any single character | `grep 'r..f' red.txt` |
| `[abc]` | One character from the set | `grep '[aeiou]' file.txt` |
| `[0-9]` | One digit | `grep '[0-9]' profile.txt` |
| `[^0-9]` | One nondigit character | `grep '[^0-9]' profile.txt` |
| `*` | Zero or more of the preceding element | `grep 're*d' red.txt` |
| `^` | Beginning of line | `grep '^root' /etc/passwd` |
| `$` | End of line | `grep 'r$' alpha-first.txt` |
| `\` | Escape a special regex character | `grep 're\*' newhome.txt` |

### 9.1. Understanding Repetition

```bash
grep 're*d' red.txt
grep 'r[oe]*d' red.txt
grep 'ee*' red.txt
```

- `re*d` matches `rd`, `red`, `reed`, and so on: `*` applies only to `e`.
- `r[oe]*d` matches `r`, followed by zero or more `o`/`e` characters, followed by `d`.
- `ee*` matches one or more consecutive `e` characters because the first `e` is mandatory.

### 9.2. Anchoring Matches

```bash
grep '^test' file.txt  # Lines beginning with test
grep 'test$' file.txt  # Lines ending with test
grep '^test$' file.txt # Lines containing exactly test
```

`^` and `$` are position anchors; they do not match ordinary text characters in these examples.

### 9.3. Shell Quoting Versus Regex Escaping

```bash
grep 're\*' newhome.txt
```

The single quotes keep the shell from interpreting the pattern. Inside the BRE, `\*` makes the asterisk literal, so this searches for the text `re*`, not repetitions of `e`.

## 10. Extended Regular Expressions (ERE)

Use `grep -E` for ERE syntax. The older `egrep` command is equivalent in common environments but is deprecated in favor of `grep -E`.

| ERE operator | Meaning | Example |
|---|---|---|
| `?` | Zero or one of the preceding element | `grep -E 'colou?r' spelling.txt` |
| `+` | One or more of the preceding element | `grep -E 'e+' red.txt` |
| `\|` | Alternation (OR) | `grep -E 'gray\|grey' spelling.txt` |
| `(...)` | Group a subexpression | `grep -E '(start\|end)' file.txt` |

**Important:** The backslashes preceding `|` in this Markdown table are only Markdown escapes to display a literal pipe. **The actual ERE alternation operator is the unescaped `|`**, as shown in these executable commands:

```bash
grep -E 'gray|grey' spelling.txt
grep -E 'start|end' file.txt
```

### 10.1. BRE vs. ERE

| Feature | BRE (`grep`) | ERE (`grep -E`) |
|---|---|---|
| Any character `.` | Supported | Supported |
| Character classes `[ ]` | Supported | Supported |
| Repetition `*` | Supported | Supported |
| Anchors `^` and `$` | Supported | Supported |
| `?`, `+`, `|` as operators | Not unescaped POSIX BRE operators | Supported unescaped |
| Parentheses for grouping | `\(` and `\)` | `(` and `)` |

GNU `grep` also supports escaped extensions such as `\?`, `\+`, and `\|` in BRE mode. These extensions should not be confused with portable POSIX BRE syntax.

## 11. Common Exam Pitfalls

1. **Confusing STDOUT with STDERR:** `>` redirects standard output; `2>` redirects error output.
2. **Confusing overwrite and append:** `>` truncates existing content; `>>` appends.
3. **Assuming pipes carry every stream:** `|` normally passes STDOUT only.
4. **Ignoring pipeline order:** `nl | tail` and `tail | nl` number different sets of lines.
5. **Assuming `grep` ignores case:** Use `-i` for case-insensitive matching.
6. **Assuming `grep` shows line numbers:** Use `-n`; use `nl` to number file content.
7. **Confusing `^` and `$`:** `^` anchors the beginning; `$` anchors the end.
8. **Confusing `-d` and `-f` in `cut`:** `-d` defines the delimiter; `-f` selects fields.
9. **Treating `*` as a general wildcard in regex:** It repeats the **preceding** element; it does not independently mean “any text.”
10. **Forgetting shell quoting:** An unquoted `|` is interpreted as a shell pipeline operator, not as ERE alternation.
11. **Assuming `sort -k2` means only field 2:** Specify `-k2,2` when that exact field is required.
12. **Equating bytes and characters:** `wc -c` counts bytes, which may differ from Unicode character counts.

## 12. Module Quiz Review

The following answers correspond to the ten review questions studied in this module.

| Question | Topic | Correct answer | Reason |
|---|---|---|---|
| 1 | Redirect error messages | `ls /root 2> error.log` | File descriptor `2` is STDERR. |
| 2 | Channel 2 | **STDERR** | Standard error uses descriptor `2`. |
| 3 | Append command output | `echo Testing >> output.file` | `>>` appends to the file. |
| 4 | Default `grep` behavior | Displays lines containing the specified regex | Matches may appear anywhere on a line. |
| 5 | Match beginning of line | `grep ^test file.txt` | `^` anchors the beginning of a line. |
| 6 | Match `start` or `end` | `egrep 'start\|end' file.txt` | ERE `|` means OR; quoting protects it from the shell. |
| 7 | `cut` delimiter option | `-d` | Defines the field separator. |
| 8 | Print line numbers | `nl` | Displays text with line numbering. |
| 9 | `echo "text" > file.txt` creates a missing file | **True** | `>` creates or truncates its destination. |
| 10 | `echo "text" >> file.txt` preserves existing content | **True** | `>>` appends rather than truncating. |

**Modern form for Question 6:**

```bash
grep -E 'start|end' file.txt
```

**Note on Question 5:** The quiz's unquoted `^test` works in ordinary Bash usage, but quoting regex patterns (`'^test'`) is clearer and more reliable.

## 13. Quick Reference

### Viewing and Counting

| Task | Command |
|---|---|
| Display a file | `cat file.txt` |
| Read interactively | `less file.txt` |
| Show first 10 lines | `head file.txt` |
| Show last 5 lines | `tail -n 5 file.txt` |
| Follow appended log data | `tail -f app.log` |
| Number nonblank lines | `nl file.txt` |
| Count lines | `wc -l file.txt` |
| Count words | `wc -w file.txt` |
| Count bytes | `wc -c file.txt` |

### Redirection and Pipelines

| Task | Syntax |
|---|---|
| Overwrite with STDOUT | `command > file` |
| Append STDOUT | `command >> file` |
| Redirect STDERR | `command 2> errors.log` |
| Redirect both streams (Bash) | `command &> all.log` |
| Read from file as STDIN | `command < file` |
| Pipe STDOUT to another command | `command1 \| command2` |

### Sorting, Extracting, and Searching

| Task | Command |
|---|---|
| Sort lines | `sort file.txt` |
| Sort numerically | `sort -n file.txt` |
| Sort in reverse | `sort -r file.txt` |
| Extract first colon-separated field | `cut -d: -f1 file.txt` |
| Extract character positions 1–10 | `cut -c1-10 file.txt` |
| Search for text | `grep 'text' file.txt` |
| Search without case sensitivity | `grep -i 'text' file.txt` |
| Show matching line numbers | `grep -n 'text' file.txt` |
| Show nonmatching lines | `grep -v 'text' file.txt` |
| Match at start of line | `grep '^text' file.txt` |
| Match at end of line | `grep 'text$' file.txt` |
| Match either of two patterns | `grep -E 'start\|end' file.txt` |

---

**Study focus:** Know the standard streams and their descriptors, distinguish redirection from pipelines, recognize common text-processing options, and identify BRE/ERE syntax in exam questions.
