# Module 9 — Archiving and Compression

Study notes for Chapter 9 of the Cisco Networking Academy / NDG Linux Essentials course.

## 1. Exam Objectives

**LPI Linux Essentials — Objective 3.1: Archiving Files on the Command Line**

**Weight:** 2

**Description:** Archive files in the home directory.

**Key Knowledge Areas:**
- Files, directories, and archives
- Archiving versus compression
- Lossless and lossy compression
- Compressing and decompressing files
- Creating, listing, and extracting TAR archives
- gzip and bzip2 compression with TAR
- Creating, listing, and extracting ZIP archives
- Extracting individual files and directories from archives

**Important Commands:**

| Command | Purpose |
|---|---|
| `tar` | Create, list, and extract archives |
| `gzip` | Compress files using gzip |
| `gunzip` | Decompress gzip-compressed files |
| `bzip2` | Compress files using bzip2 |
| `bunzip2` | Decompress bzip2-compressed files |
| `xz` | Compress files using xz |
| `unxz` | Decompress xz-compressed files |
| `zip` | Create and update ZIP archives |
| `unzip` | List, test, and extract ZIP archives |

---

## 2. Archiving vs. Compression

Archiving and compression are related but different operations.

**Archiving** combines multiple files and directories into one archive while preserving their paths and structure.

**Compression** reduces the amount of storage required to represent data.

An archive does not necessarily have to be compressed.

```text
ARCHIVING

file1.txt ──┐
file2.txt ──┼──> backup.tar
folder/   ──┘

COMPRESSION

backup.tar ──> backup.tar.gz

EXTRACTION

backup.tar.gz
      |
      v
Decompress + Extract
      |
      +── file1.txt
      +── file2.txt
      +── folder/
```

### Common File Extensions

| Extension | Description |
|---|---|
| `.tar` | Uncompressed TAR archive |
| `.gz` | gzip-compressed file |
| `.bz2` | bzip2-compressed file |
| `.xz` | xz-compressed file |
| `.tar.gz` | TAR archive compressed with gzip |
| `.tgz` | Short form of `.tar.gz` |
| `.tar.bz2` | TAR archive compressed with bzip2 |
| `.tbz`, `.tbz2` | Alternative extensions for bzip2-compressed TAR archives |
| `.zip` | ZIP archive, typically containing compressed files |

### Why Use Archives and Compression?

- Distribute software and documentation.
- Create backups.
- Reduce storage requirements.
- Transfer groups of files more conveniently.
- Rotate and preserve log files.
- Reduce network transfer size.

Compression consumes processing resources, so there can be a trade-off between CPU usage, memory usage, compression ratio, and transfer time.

---

## 3. Compression Concepts

### 3.1 Lossless Compression

Lossless compression preserves all original information.

After decompression, the restored data is identical to the original.

Common uses include:

- Source code
- Documents
- Log files
- Software packages
- Backups

Examples of lossless compression tools:

- `gzip`
- `bzip2`
- `xz`

### 3.2 Lossy Compression

Lossy compression removes some information to reduce file size.

It is commonly used for images, audio, and video when an exact reconstruction is not required.

Repeated lossy compression can reduce quality.

### Comparison

| Property | Lossless | Lossy |
|---|---|---|
| Original data fully recoverable | Yes | No |
| Appropriate for source code | Yes | No |
| May discard information | No | Yes |
| Typical applications | Software, logs, documents | Images, audio, video |

**Exam note:** Files that are already compressed often compress poorly a second time and may even become slightly larger.

---

## 4. Compressing Files with gzip

`gzip` is a lossless compression utility that uses the DEFLATE algorithm, combining LZ77 and Huffman coding.

### 4.1 Compress a File

```bash
gzip longfile.txt
```

The result is normally:

```text
longfile.txt.gz
```

By default, `gzip` removes the original file after successful compression.

```text
BEFORE

longfile.txt

       |
       | gzip longfile.txt
       v

AFTER

longfile.txt.gz
```

### 4.2 Display Compression Information

```bash
gzip -l longfile.txt.gz
```

Typical columns include:

```text
compressed  uncompressed  ratio  uncompressed_name
```

The command reports the compressed size, original size, compression ratio, and original filename.

### 4.3 Decompress a File

Either command can be used:

```bash
gunzip longfile.txt.gz
```

```bash
gzip -d longfile.txt.gz
```

By default, the compressed file is replaced by the restored original.

**Exam note:** `gzip` compresses a file; it does not extract the contents of a TAR archive.

---

## 5. Other Compression Utilities

### 5.1 bzip2

`bzip2` uses a compression method based on the Burrows–Wheeler transform.

Compress:

```bash
bzip2 report.txt
```

Result:

```text
report.txt.bz2
```

Decompress:

```bash
bunzip2 report.txt.bz2
```

### 5.2 xz

`xz` commonly uses LZMA2, which stands for *Lempel–Ziv–Markov chain Algorithm 2*.

Compress:

```bash
xz report.txt
```

Result:

```text
report.txt.xz
```

Decompress:

```bash
unxz report.txt.xz
```

### Compression Tool Comparison

| Tool | Typical Extension | Algorithm or Method | Decompression Command |
|---|---|---|---|
| `gzip` | `.gz` | DEFLATE (LZ77 + Huffman) | `gunzip` |
| `bzip2` | `.bz2` | Burrows–Wheeler-based | `bunzip2` |
| `xz` | `.xz` | LZMA2 | `unxz` |

The tools differ in compression ratio, speed, and memory requirements.

---

## 6. Working with tar

`tar` stands for *Tape Archive*.

It was traditionally designed to store files on tape but is widely used to manage archives on Linux.

### 6.1 The Three Main Modes

| Mode | Option | Purpose |
|---|---|---|
| Create | `-c` | Create an archive |
| List | `-t` | Display archive contents |
| Extract | `-x` | Extract archive contents |

### 6.2 Important Options

| Option | Meaning |
|---|---|
| `-c` | Create an archive |
| `-t` | List archive contents |
| `-x` | Extract archive contents |
| `-f` | Specify the archive filename |
| `-v` | Verbose output |
| `-z` | Use gzip compression |
| `-j` | Use bzip2 compression |

**Important:** When combining short options, `-f` must be followed by the archive filename. Placing `-f` last in a combined option group helps avoid mistakes.

---

## 7. Creating TAR Archives

### 7.1 Create an Uncompressed Archive

```bash
tar -cf alpha_files.tar alpha*
```

This command:

1. Uses `-c` to create an archive.
2. Uses `-f` to specify `alpha_files.tar`.
3. Includes files matching `alpha*`.

The shell expands the wildcard before `tar` processes the filenames.

The original files remain in place.

### 7.2 Create a gzip-Compressed Archive

```bash
tar -czf alpha_files.tar.gz alpha*
```

Options:

- `-c`: create
- `-z`: gzip compression
- `-f`: archive filename

```text
alpha1.txt ──┐
alpha2.txt ──┼──> TAR ──> gzip ──> alpha_files.tar.gz
alpha3.txt ──┘
```

### 7.3 Create a bzip2-Compressed Archive

```bash
tar -cjf folders.tbz School
```

Options:

- `-c`: create
- `-j`: bzip2 compression
- `-f`: archive filename

Unlike `zip`, `tar` includes directory contents recursively by default.

---

## 8. Listing TAR Archive Contents

Use `-t` to inspect an archive without extracting its files.

### Uncompressed TAR

```bash
tar -tf backup.tar
```

### gzip-Compressed TAR

```bash
tar -tzf alpha_files.tar.gz
```

### bzip2-Compressed TAR

```bash
tar -tjf folders.tbz
```

Example output:

```text
School/
School/Engineering/
School/Engineering/hello.sh
School/Art/
School/Art/linux.txt
School/Math/
School/Math/numbers.txt
```

Notice that the archive stores directory paths, not just filenames.

### Alternative Pipeline Example

```bash
bunzip2 -c folders.tbz | tar -t
```

Here:

- `bunzip2 -c` writes decompressed data to standard output.
- `|` sends that output to the next command.
- `tar -t` lists the archive contents.

The meaning of `-c` depends on the program:

| Command | Meaning of `-c` |
|---|---|
| `tar -c` | Create an archive |
| `bunzip2 -c` | Write decompressed data to standard output |

---

## 9. Extracting TAR Archives

### 9.1 Extract a bzip2-Compressed TAR Archive

```bash
tar -xjf folders.tbz
```

The command extracts the archive into the current directory.

The archive itself remains unchanged.

### 9.2 Display Extracted Filenames

```bash
tar -xjvf folders.tbz
```

The `-v` option displays the names of files as they are processed.

### 9.3 Understand Option Ordering

Correct:

```bash
tar -xjvf folders.tbz
```

Incorrect:

```bash
tar -xjfv folders.tbz
```

In the incorrect command, `-f` consumes the next character, `v`, as the archive filename.

An explicit alternative is:

```bash
tar -x -j -v -f folders.tbz
```

### 9.4 Extract a Specific File

```bash
tar -xjvf folders.tbz School/Art/linux.txt
```

The requested path must match the path stored in the archive.

For example, specifying only:

```text
linux.txt
```

will not match:

```text
School/Art/linux.txt
```

### 9.5 Extract a Specific Directory

For an archive containing paths such as:

```text
home/fred/file1.txt
home/fred/file2.txt
home/alex/file3.txt
```

Extract only Fred's directory:

```bash
tar -xzf backup.tar.gz home/fred/
```

**Exam note:** Use the path recorded in the archive. Do not assume that the stored path begins with `/`.

### 9.6 Extraction Safety

Extracting an archive may overwrite existing files.

Inspect its contents first:

```bash
tar -tjf folders.tbz
```

When appropriate, extract into a separate directory to avoid conflicts.

---

## 10. Working with ZIP Files

ZIP combines archiving and compression.

The main commands are:

- `zip`: create or update ZIP archives.
- `unzip`: list, test, or extract ZIP archives.

Unlike `tar`, ZIP commands normally accept the archive filename as a direct argument rather than requiring `-f`.

### 10.1 Create a ZIP Archive

```bash
zip alpha_files.zip alpha*
```

The command adds files matching `alpha*` to the archive.

Output may include messages such as:

```text
adding: alpha1.txt (deflated 32%)
```

Already-compressed files may be reported as stored without additional compression.

### 10.2 Directory Recursion

By default, `zip` does not recursively include the contents of directories.

This command adds the directory entry but not its complete contents:

```bash
zip School.zip School
```

To include the directory tree:

```bash
zip -r School.zip School
```

**Exam note:** `tar` processes directories recursively by default; `zip` requires `-r` for recursive inclusion.

### 10.3 List ZIP Contents

```bash
unzip -l School.zip
```

Typical output columns include:

```text
Length   Date   Time   Name
```

The `Length` column represents the original, uncompressed size.

### 10.4 Extract a ZIP Archive

```bash
unzip School.zip
```

Files are extracted into the current directory.

The ZIP archive remains in place.

If a destination file already exists, `unzip` may ask whether to overwrite it.

Common responses include:

| Response | Meaning |
|---|---|
| `y` | Overwrite this file |
| `n` | Do not overwrite this file |
| `A` | Overwrite all |
| `N` | Overwrite none |
| `r` | Rename the extracted file |

### 10.5 Extract into a Separate Directory

```bash
mkdir tmp
cp School.zip tmp/School.zip
cd tmp
unzip School.zip
```

This keeps the extracted files separate from the original working directory.

### 10.6 Extract a Specific File

```bash
unzip School.zip School/Math/numbers.txt
```

The path must match the entry stored inside the ZIP archive.

### 10.7 Extract Files Using a Pattern

```bash
unzip School.zip 'School/Art/*t'
```

Or:

```bash
unzip School.zip School/Art/\*t
```

Both forms prevent the shell from expanding the wildcard, allowing `unzip` to interpret the pattern against archive entries.

For example, the pattern may match:

```text
School/Art/linux.txt
School/Art/red.txt
School/Art/animals.txt
```

---

## 11. tar vs. zip

| Feature | `tar` | `zip` |
|---|---|---|
| Main purpose | Archiving | Archiving and compression |
| Compression by default | No | Typically yes |
| Recursive directory handling | Yes | Requires `-r` |
| Archive filename option | `-f` | Positional argument |
| Create | `tar -cf` | `zip` |
| List | `tar -tf` | `unzip -l` |
| Extract | `tar -xf` | `unzip` |
| gzip integration | `-z` | Not applicable |
| bzip2 integration | `-j` | Not applicable |

### Workflow Comparison

```text
TAR WORKFLOW

Files / Directories
        |
        v
      tar -c
        |
        v
     backup.tar
        |
        v
  Optional gzip/bzip2
        |
        v
 backup.tar.gz / backup.tar.bz2


ZIP WORKFLOW

Files / Directories
        |
        v
      zip -r
        |
        v
     backup.zip
```

---

## 12. Common Exam Traps

### Trap 1: Confusing Archiving with Compression

`tar -cf backup.tar folder/` creates an archive without necessarily compressing it.

`tar -czf backup.tar.gz folder/` creates and gzip-compresses an archive.

### Trap 2: Assuming gzip Preserves the Original

By default:

```bash
gzip myfile.tar
```

replaces `myfile.tar` with `myfile.tar.gz`.

### Trap 3: Confusing tar Modes

- `-c`: create
- `-t`: list
- `-x`: extract

Compression is not one of the three main modes.

### Trap 4: Misplacing the tar Filename Option

Correct:

```bash
tar -xjvf folders.tbz
```

Incorrect:

```bash
tar -xjfv folders.tbz
```

### Trap 5: Using the Wrong Compression Option

- `-z`: gzip
- `-j`: bzip2

For a `.tar.gz` archive, use `-z`, not `-j`.

### Trap 6: Omitting Stored Directory Paths

When extracting selected members, use the paths stored in the archive.

### Trap 7: Forgetting ZIP Recursion

```bash
zip -r School.zip School
```

is required to recursively include the directory tree.

### Trap 8: Letting the Shell Expand a ZIP Pattern

Prefer:

```bash
unzip documents.zip 'ProjectX/*'
```

rather than relying on an unquoted wildcard.

---

## 13. Module Quiz Review

### Question 1 — How Compression Works

**Answer:** Removing redundant information.

Compression reduces data size by representing information more efficiently. It is not the same as combining files into an archive.

### Question 2 — Running `gzip myfile.tar`

**Answers:**

- `myfile.tar` is removed.
- `myfile.tar.gz` contains the compressed version of `myfile.tar`.

These describe the default behavior after successful compression.

### Question 3 — Displaying Compression Statistics

**Answer:**

```bash
gzip -l tags
```

The `-l` option displays compression statistics. In normal use, the argument is typically the compressed filename, such as `tags.gz`.

### Question 4 — Understanding `tar -cvjf`

Given:

```bash
tar -cvjf homedirs.tbz /home
```

**Answers:**

- The output archive will be compressed.
- Filenames will be displayed during processing.

The `-j` option enables bzip2 compression, and `-v` enables verbose output.

### Question 5 — Extracting One User's Directory

**Answer:**

```bash
tar -xzf backup.tar.gz home/fred/
```

This extracts entries matching the stored directory path `home/fred/`.

### Question 6 — Listing ZIP Contents

**Expected answer:**

```bash
unzip -l documents.zip
```

This lists ZIP entries without extracting them.

### Question 7 — Extracting Files Under ProjectX

**Expected answer:**

```bash
unzip documents.zip ProjectX/*
```

A safer shell form is:

```bash
unzip documents.zip 'ProjectX/*'
```

The quoted wildcard is interpreted by `unzip`.

### Question 8 — Commands That Compress Files

**Answers:**

- `gzip`
- `bzip2`
- `zip`

`bunzip2` decompresses files, while `cat` displays or concatenates data.

### Question 9 — Main tar Modes

**Answers:**

- Create
- List
- Extract

Their corresponding options are `-c`, `-t`, and `-x`.

### Question 10 — Lempel–Ziv–Markov Chain Algorithm

**Technically correct option:** `xz`.

`xz` uses LZMA2. Its corresponding decompression utility is `unxz`.

**Question issue:** The question requests two answers, but only one listed option is technically correct. `gzip` uses DEFLATE (LZ77 + Huffman), not LZMA; `bzip` is Burrows–Wheeler-based; and `lossless` and `lossy` are compression categories, not programs.

---

## 14. Quick Reference

### Compression

| Task | Command |
|---|---|
| Compress with gzip | `gzip file.txt` |
| Decompress gzip | `gunzip file.txt.gz` |
| Alternative gzip decompression | `gzip -d file.txt.gz` |
| Display gzip statistics | `gzip -l file.txt.gz` |
| Compress with bzip2 | `bzip2 file.txt` |
| Decompress bzip2 | `bunzip2 file.txt.bz2` |
| Compress with xz | `xz file.txt` |
| Decompress xz | `unxz file.txt.xz` |

### TAR Archives

| Task | Command |
|---|---|
| Create TAR | `tar -cf backup.tar folder/` |
| Create gzip TAR | `tar -czf backup.tar.gz folder/` |
| Create bzip2 TAR | `tar -cjf backup.tar.bz2 folder/` |
| List TAR | `tar -tf backup.tar` |
| List gzip TAR | `tar -tzf backup.tar.gz` |
| List bzip2 TAR | `tar -tjf backup.tar.bz2` |
| Extract TAR | `tar -xf backup.tar` |
| Extract gzip TAR | `tar -xzf backup.tar.gz` |
| Extract bzip2 TAR | `tar -xjf backup.tar.bz2` |
| Verbose extraction | `tar -xjvf backup.tar.bz2` |
| Extract selected directory | `tar -xzf backup.tar.gz home/fred/` |

### ZIP Archives

| Task | Command |
|---|---|
| Create ZIP | `zip backup.zip file1 file2` |
| Recursively ZIP directory | `zip -r backup.zip folder/` |
| List ZIP contents | `unzip -l backup.zip` |
| Extract ZIP | `unzip backup.zip` |
| Extract specific file | `unzip backup.zip folder/file.txt` |
| Extract selected directory contents | `unzip backup.zip 'folder/*'` |



