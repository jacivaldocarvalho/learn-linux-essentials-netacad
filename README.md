# Linux Essentials — Cisco Networking Academy

[![Cisco Networking Academy](https://img.shields.io/badge/Cisco-Networking%20Academy-1BA0D7?logo=cisco&logoColor=white)](https://www.netacad.com/)
[![LPI Linux Essentials](https://img.shields.io/badge/LPI-Linux%20Essentials-F7941D?logo=linux&logoColor=white)](https://www.lpi.org/our-certifications/linux-essentials-overview/)
![Linux](https://img.shields.io/badge/Linux-Study%20Notes-FCC624?logo=linux&logoColor=black)
![Language](https://img.shields.io/badge/Language-English-blue)
![Modules](https://img.shields.io/badge/Modules-11%20Completed-success)
![Midterm Exam](https://img.shields.io/badge/Midterm%20Exam-Completed-success)

Study notes, exercises, commands, and practical examples from my learning journey through the **Linux Essentials** course offered by **Cisco Networking Academy (NetAcad)** and developed in collaboration with **Network Development Group (NDG)**.

This repository serves as a personal reference for Linux fundamentals and for reviewing topics relevant to the **Linux Professional Institute (LPI) Linux Essentials** certification.

## About the Course

Linux Essentials introduces the Linux operating system and practical command-line skills. Topics include:

- Linux fundamentals, operating systems, and distributions
- Open source software and licensing
- Command Line Interface (CLI) and shell fundamentals
- Filesystem navigation and file management
- Linux documentation and help utilities
- Archiving and compression
- Text processing, pipelines, and I/O redirection
- Regular expressions and text filtering
- Shell scripting, variables, conditionals, and loops
- File permissions, users, groups, processes, networking, and security concepts

The course also supports preparation for the **LPI Linux Essentials Certificate**.

## Repository Structure

```text
jc-linux-essentials-netacad/
├── README.md
├── modules/
│   ├── 01-introduction-to-linux/
│   │   └── README.md
│   ├── 02-operating-systems/
│   │   └── README.md
│   ├── 03-working-in-linux/
│   │   └── README.md
│   ├── 04-open-source-software-and-licensing/
│   │   └── README.md
│   ├── 05-command-line-skills/
│   │   ├── README.md
│   │   └── LAB.md
│   ├── 06-getting-help/
│   │   └── README.md
│   ├── 07-navigating-the-filesystem/
│   │   └── README.md
│   ├── 08-managing-files-and-directories/
│   │   └── README.md
│   ├── 09-archiving-and-compression/
│   │   └── README.md
│   ├── 10-working-with-text/
│   │   └── README.md
│   └── 11-basic-scripting/
│       ├── README.md
│       └── code/
│           ├── 01-hello-world.sh
│           ├── 02-variables.sh
│           ├── 03-user-input.sh
│           ├── 04-arguments.sh
│           ├── 05-exit-status.sh
│           ├── 06-conditionals.sh
│           ├── 07-case.sh
│           ├── 08-for-loops.sh
│           └── 09-while-loop.sh
└── exams/
    └── midterm-modules-01-09/
        └── README.md
```

### `modules/`

Original study notes organized by course module. Each module documents important concepts, commands, examples, and exam-relevant details. Some modules include additional lab notes or executable examples.

### `modules/11-basic-scripting/code/`

Standalone Bash scripts illustrating concepts from Module 11. Each example can be inspected, modified, and run independently. See the [Module 11 README](modules/11-basic-scripting/README.md) for explanations.

### `exams/`

Assessment reviews containing answers, technical explanations, examples, and revision checklists.

## Course Progress

**Current progress:** Modules **1–11 completed**, including the **Midterm Exam (Modules 1–9)**.

| Milestone | Status |
|---|---|
| Modules 1–9 | Completed |
| Midterm Exam (Modules 1–9) | Completed |
| Module 10 — Working With Text | Completed |
| Module 11 — Basic Scripting | Completed |
| Remaining course modules | Not yet documented |

## Modules

| Module | Topic | Status |
|---|---|---|
| 01 | [Introduction to Linux](modules/01-introduction-to-linux/README.md) | Completed |
| 02 | [Operating Systems](modules/02-operating-systems/README.md) | Completed |
| 03 | [Working in Linux](modules/03-working-in-linux/README.md) | Completed |
| 04 | [Open Source Software and Licensing](modules/04-open-source-software-and-licensing/README.md) | Completed |
| 05 | [Command Line Skills](modules/05-command-line-skills/README.md) | Completed |
| 06 | [Getting Help](modules/06-getting-help/README.md) | Completed |
| 07 | [Navigating the Filesystem](modules/07-navigating-the-filesystem/README.md) | Completed |
| 08 | [Managing Files and Directories](modules/08-managing-files-and-directories/README.md) | Completed |
| 09 | [Archiving and Compression](modules/09-archiving-and-compression/README.md) | Completed |
| 10 | [Working With Text](modules/10-working-with-text/README.md) | Completed |
| 11 | [Basic Scripting](modules/11-basic-scripting/README.md) | Completed |

### Module 5 — Command Line Skills

- Basic shell and Bash
- Command syntax, options, and arguments
- Command history
- Shell and environment variables
- `PATH`
- Command types, aliases, and functions
- Quoting, escaping, and command substitution
- Control operators (`;`, `&&`, `||`)

[Study Notes](modules/05-command-line-skills/README.md) · [Lab Notes](modules/05-command-line-skills/LAB.md)

### Module 6 — Getting Help

- Linux documentation resources
- Manual pages and manual sections
- `man` and `info`
- `whatis` and `apropos`
- `--help` command options
- `locate` and `whereis`
- Documentation in `/usr/share/doc`

[Study Notes](modules/06-getting-help/README.md)

### Module 7 — Navigating the Filesystem

- Linux filesystem hierarchy
- Absolute and relative paths
- Current and parent directories
- Home directory shortcuts
- `pwd`, `cd`, and `ls`
- Hidden files and directories
- Directory listing options

[Study Notes](modules/07-navigating-the-filesystem/README.md)

### Module 8 — Managing Files and Directories

- Case-sensitive filenames
- Filename globbing (`*`, `?`, `[ ]`)
- Copying files and directories with `cp`
- Moving and renaming files with `mv`
- Creating files with `touch`
- Removing files with `rm`
- Creating directories with `mkdir`
- Removing empty directories with `rmdir`

[Study Notes](modules/08-managing-files-and-directories/README.md)

### Module 9 — Archiving and Compression

- Archiving versus compression
- Lossless and lossy compression
- `gzip`, `bzip2`, and `xz`
- TAR archive creation, listing, and extraction
- gzip and bzip2 compression with `tar`
- ZIP archive creation and extraction
- Recursive archiving and selective extraction

[Study Notes](modules/09-archiving-and-compression/README.md)

### Module 10 — Working With Text

- Viewing file content with `cat`, `less`, `more`, `head`, and `tail`
- Pipelines (`|`) and command chaining
- Standard streams: STDIN, STDOUT, and STDERR
- I/O redirection with `<`, `>`, `>>`, `2>`, and `&>`
- Sorting text with `sort`, including fields and numeric keys
- File statistics with `wc`
- Extracting columns and character ranges with `cut`
- Filtering text with `grep`
- Basic and extended regular expressions, including `grep -E`

**LPI objective:** 3.2 — Searching and Extracting Data from Files (weight: 3).

[Study Notes](modules/10-working-with-text/README.md)

### Module 11 — Basic Scripting

- Shell scripts, execution methods, and the shebang (`#!`)
- Script permissions and `chmod +x`
- Text editors: `nano`, `vi`, and `vim`
- Variables, expansion, and command substitution
- Reading input with `read` and passing positional arguments
- Exit codes, `$?`, and `exit`
- Conditionals using `if`, `elif`, `else`, `test`, and `case`
- File tests and numeric/string comparisons
- `for` and `while` loops
- Arithmetic expansion with `$(( ... ))`
- Separate executable Bash examples in `code/`

**LPI objective:** 3.3 — Turning Commands into a Script (weight: 4).

[Study Notes](modules/11-basic-scripting/README.md) · [Bash Examples](modules/11-basic-scripting/code/)

## Running the Module 11 Examples

From the repository root:

```bash
cd modules/11-basic-scripting
bash code/01-hello-world.sh
bash code/02-variables.sh
bash code/04-arguments.sh World
bash code/06-conditionals.sh hello
bash code/07-case.sh hi
bash code/08-for-loops.sh
bash code/09-while-loop.sh
```

The `03-user-input.sh` example requests interactive input. Review a script before running it, and use a suitable test environment when experimenting with changes.

## Exams

| Assessment | Coverage | Status |
|---|---|---|
| [Midterm Exam](exams/midterm-modules-01-09/README.md) | Modules 1–9 | Completed |

### Midterm Exam — Modules 1–9

Review of 40 questions covering:

- Linux distributions and operating systems
- Software management and release cycles
- Open source software and licensing
- Shells, CLI, and environment variables
- Linux documentation and help commands
- Filesystem navigation
- File and directory management
- Globbing
- Archiving and compression

The exam review includes correct answers, technical explanations, command examples, and a final review checklist.

[Midterm Exam Review](exams/midterm-modules-01-09/README.md)

## References

- [Cisco Networking Academy](https://www.netacad.com/)
- [Linux Professional Institute — Linux Essentials](https://www.lpi.org/our-certifications/linux-essentials-overview/)
- [Network Development Group (NDG)](https://www.netdevgroup.com/)
- [The Linux Kernel Archives](https://www.kernel.org/)
- [GNU Project](https://www.gnu.org/)

## Disclaimer

This repository contains **personal study notes and original learning material** created while taking the course. Explanations, summaries, and practical examples are intended as independent study resources.

Official course content belongs to its respective authors and copyright holders. This repository is **not affiliated with or endorsed by** Cisco Networking Academy, NDG, or the Linux Professional Institute, and is not intended to reproduce or replace their official materials.
