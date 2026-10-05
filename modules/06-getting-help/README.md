# Module 6 — Getting Help

Study notes for Chapter 6 of the Cisco Networking Academy / NDG Linux Essentials course.

## Exam Objectives

### 2.2 Using the Command Line to Get Help

**Weight:** 2

Key knowledge areas:

- Man pages
- Info pages
- Searching documentation
- Locating commands and documentation
- Additional system documentation

Important commands and paths:

```text
man
info
whatis
apropos
whereis
locate
updatedb
/usr/share/doc/
```

---

## 6.1 Introduction

Linux provides thousands of commands, options, configuration files, libraries, and system interfaces.

It is not practical to memorize every command and option. An important Linux skill is knowing how to locate reliable documentation quickly.

Common local help sources include:

```text
Linux Help
│
├── command --help
│   └── quick syntax and options
│
├── man
│   └── reference documentation
│
├── info
│   └── structured documentation
│
├── whatis / apropos
│   └── search manual-page information
│
├── whereis / locate
│   └── locate commands, documentation, and files
│
└── /usr/share/doc/
    └── additional package documentation
```

The essential skill is not memorizing every available option, but knowing **where to find the required information**.

---

## 6.2 Man Pages

The traditional Unix and Linux documentation system is based on **manual pages**, commonly called **man pages**.

Use:

```bash
man command
```

Example:

```bash
man ls
```

Man pages are primarily designed as **reference documentation**.

They are useful for:

- checking command syntax;
- looking up command options;
- understanding command behavior;
- identifying related files;
- checking configuration-file formats;
- finding related commands and documentation.

A manual page is commonly identified by its name and section:

```text
ls(1)
```

This means the `ls` manual page from section 1.

---

## 6.2.1 Viewing Man Pages

A man page commonly contains sections such as:

```text
NAME
SYNOPSIS
DESCRIPTION
OPTIONS
FILES
AUTHOR
REPORTING BUGS
COPYRIGHT
SEE ALSO
```

Not every page contains every section.

A useful mental model is:

```text
NAME
    → What is it?

SYNOPSIS
    → How is it invoked?

DESCRIPTION
    → What does it do?

OPTIONS
    → What behavior can be selected?

FILES
    → Which files are related?

SEE ALSO
    → What related documentation exists?
```

### SYNOPSIS Notation

Consider:

```text
command [OPTION]... [FILE]...
```

Documentation notation commonly uses:

```text
[ITEM]      optional item

ITEM...     item may be repeated

[ITEM]...   zero or more occurrences

A|B         alternative: A or B
```

For example:

```text
ls [OPTION]... [FILE]...
```

means that `ls` can be invoked with zero or more options and zero or more file arguments.

The brackets shown in a SYNOPSIS are **documentation notation**. They are normally not typed literally.

This is different from shell syntax such as:

```bash
ls file[123]
```

where brackets are part of a shell glob pattern.

### Alternatives with `|`

In a SYNOPSIS:

```text
A|B
```

means that `A` and `B` are **alternatives**.

For example:

```text
-u|--utc|--universal
```

means:

```text
-u
OR
--utc
OR
--universal
```

The alternatives separated by `|` are not intended to be used together in that position.

Do not confuse this documentation notation with the shell pipeline operator:

```bash
command1 | command2
```

In the shell, `|` connects the standard output of one command to the standard input of another.

### Nested Optional Items

A SYNOPSIS may contain nested optional elements.

For example:

```text
[[month] year]
```

This indicates that:

- both may be omitted;
- `year` may be supplied by itself;
- if `month` is supplied, `year` is also required.

The exact interpretation follows the nesting of the brackets.

---

## 6.2.2 Navigating Man Pages

Man pages are displayed through a **pager program**.

Common pagers associated with `man` include:

```text
less
more
```

`less` is commonly used on modern Linux systems and provides richer navigation features than `more`.

Typical `less` navigation keys include:

```text
↑ / ↓      move through the document
Space      next screen
b          previous screen
/word      search forward
n          next search match
N          previous search match
g          beginning
G          end
h          help
q          quit
```

Conceptually:

```text
man command
     │
     ▼
Manual document
     │
     ▼
Pager
     │
     ├── less
     └── more
```

The `man` command provides and formats the documentation, while the pager controls interactive movement through it.

---

## 6.2.3 Searching Man Pages

While reading a man page, start a forward search with:

```text
/
```

Then enter the search term.

For example, while viewing:

```bash
man ls
```

search for:

```text
/human-readable
```

After a match is found:

```text
n → next match
N → previous match
```

A typical workflow is:

```text
man ls
   │
   ▼
/human-readable
   │
   ▼
matching text
   │
   ├── n → next occurrence
   └── N → previous occurrence
```

The interactive search behavior normally comes from the pager, commonly `less`.

---

## 6.2.4 Man Pages Categorized by Sections

Linux contains manual pages for much more than ordinary commands.

The traditional manual is divided into numbered sections.

| Section | Category |
| --- | --- |
| 1 | General/User Commands |
| 2 | System Calls |
| 3 | Library Calls |
| 4 | Special Files |
| 5 | File Formats and Conventions |
| 6 | Games |
| 7 | Miscellaneous |
| 8 | System Administration Commands |
| 9 | Kernel Routines |

A compact representation is:

```text
Manual Sections
│
├── 1  User commands
├── 2  System calls
├── 3  Library calls
├── 4  Special files
├── 5  File formats
├── 6  Games
├── 7  Miscellaneous
├── 8  Administration
└── 9  Kernel
```

Exact section names can vary slightly between systems.

### Same Name, Different Sections

Different manual pages can have the same name.

A classic example is `passwd`:

```text
passwd(1)
    → passwd command

passwd(5)
    → /etc/passwd file format
```

Running:

```bash
man passwd
```

normally displays the first matching page according to the configured manual search order.

To explicitly request a section:

```bash
man 5 passwd
```

General syntax:

```bash
man SECTION PAGE
```

Therefore:

```text
passwd(5)
```

means:

```text
manual page "passwd"
in manual section 5
```

---

## Finding Man Pages by Name

Use:

```bash
man -f name
```

Example:

```bash
man -f passwd
```

This searches for manual pages associated with the specified page name.

On many Linux systems:

```bash
whatis passwd
```

provides equivalent functionality.

Remember:

```text
man -f NAME
      ≈
whatis NAME
```

This is useful when the **manual-page name is known**.

---

## Searching Man Pages by Keyword

If the exact command or manual-page name is unknown, search names and descriptions using:

```bash
man -k keyword
```

Example:

```bash
man -k copy
```

The equivalent command is:

```bash
apropos copy
```

Remember:

```text
man -k KEYWORD
       ≈
apropos KEYWORD
```

The distinction is:

```text
man -f NAME
│
└── search by manual-page name


man -k KEYWORD
│
└── search manual-page names and descriptions
```

A compact exam reference is:

```text
man -f  ≈  whatis
man -k  ≈  apropos
```

These searches commonly rely on an indexed manual-page database. On minimal or newly installed systems, the database may be missing or outdated.

---

## 6.3 Finding Commands and Documentation

Documentation searches and shell command resolution answer different questions.

For example:

```text
whatis ls
    → What manual-page entries describe ls?


type ls
    → How does the current shell resolve ls?


PATH
    → Where does the shell search for external commands?
```

Multiple documentation entries do not necessarily mean that multiple executable files with the same name are competing for execution.

Historical Unix traditions and standards can also result in multiple documentation entries describing related implementations or interfaces.

---

## 6.3.1 Where Are These Commands Located?

The `whereis` command searches standard locations for files associated with a command.

Syntax:

```bash
whereis command
```

Example:

```bash
whereis ls
```

A result may resemble:

```text
ls: /bin/ls /usr/share/man/man1/ls.1.gz
```

`whereis` can search for:

```text
whereis
│
├── binaries
├── source files
└── manual pages
```

It is not intended as a general-purpose search of every arbitrary file in the filesystem.

### Compressed Man Pages

Manual pages are frequently stored in compressed form.

For example:

```text
/usr/share/man/man1/ls.1.gz
```

can be interpreted as:

```text
ls.1.gz
│  │  │
│  │  └── gzip compressed
│  │
│  └── manual section 1
│
└── ls
```

The user normally does not need to decompress these files manually.

The `man` system handles the stored documentation automatically.

### `whereis`, `which`, and `type`

These commands answer different questions:

```text
type command
    → How does the current shell interpret the command name?


which command
    → Which executable is found through PATH?


whereis command
    → Where are associated binary/source/man files?
```

For shell command resolution, `type` is especially useful because it can identify constructs such as:

- aliases;
- functions;
- shell builtins;
- external commands.

### Modern `/bin` and `/usr/bin`

Older examples frequently show executables such as:

```text
/bin/ls
```

Modern distributions may use a merged `/usr` layout where `/bin` is linked to `/usr/bin`.

Therefore, the physical location should not be assumed to be identical on every Linux system.

The important concept is that `whereis` can identify command-related locations on the current system.

---

## 6.3.2 Find Any File or Directory

The `locate` command searches for file and directory names using an **indexed database**.

Example:

```bash
locate gshadow
```

Unlike `whereis`, `locate` is intended for general pathname searches.

Conceptually:

```text
Filesystem
    │
    ▼
 updatedb
    │
    ▼
Locate Database
    │
    ▼
 locate
    │
    ▼
Fast search results
```

Because `locate` searches an index instead of traversing the filesystem for every query, searches are usually very fast.

### Database Freshness

The main tradeoff is that the database may not exactly match the current filesystem.

For example:

```text
Create new file
      │
      ▼
Filesystem contains file
      │
      ├───────────────┐
      ▼               ▼
file exists       locate database
                  may still be old
```

Until the database is updated, `locate` may not find the new file.

Traditionally, the database is updated periodically. The exact update schedule depends on the distribution and configuration.

Modern systems may use implementations such as:

```text
locate
mlocate
plocate
```

The exam-relevant concept is:

```text
locate
    → searches an existing index

updatedb
    → updates/builds the index
```

Running `updatedb` normally requires administrative privileges, depending on system configuration.

### Permissions and Locate Results

Some `locate` implementations and configurations restrict results according to filesystem permissions.

This can prevent users from discovering filenames inside directories they are not permitted to inspect.

Exact behavior depends on the implementation and configuration.

### Counting Results

Use:

```bash
locate -c pattern
```

to count matching results rather than display every path.

Example:

```bash
locate -c passwd
```

Conceptually:

```text
locate passwd
    → display matches


locate -c passwd
    → count matches
```

### Searching Basenames

A pathname such as:

```text
/usr/bin/passwd
```

contains:

```text
/usr/bin/   → directory portion

passwd      → basename
```

Use:

```bash
locate -b passwd
```

to restrict matching to the basename portion of paths.

Conceptually:

```text
Full path:
    /usr/share/example/passwd.txt

Basename:
    passwd.txt
```

With `-b`, matching is performed against the basename rather than the complete pathname.

### Exact Basename Matching

The course demonstrates:

```bash
locate -b "\passwd"
```

to restrict results to basenames that exactly match `passwd` in the `locate` implementation used by the course.

Possible matching paths include:

```text
/etc/passwd
/usr/bin/passwd
/usr/share/doc/passwd
```

Each has:

```text
passwd
```

as its basename.

For the course and exam context, remember:

```bash
locate -b "\passwd"
```

### `locate` vs `find`

A useful conceptual distinction is:

```text
locate
│
├── searches an index
├── usually very fast
└── index can be stale


find
│
├── traverses a filesystem hierarchy
├── evaluates current filesystem entries
└── does not depend on the locate database
```

The two commands solve related but different problems.

---

## 6.4 Info Documentation

The GNU Info system provides another form of local documentation.

The general syntax is:

```bash
info command
```

Example:

```bash
info ls
```

The course describes Info conceptually as organizing available documentation into a **book-like documentation system**.

Unlike the primarily reference-oriented model of man pages, Info manuals are divided into connected sections called **nodes**, which can be explored through menus and hyperlinks.

Conceptually:

```text
Info Documentation
│
├── Manual / "Book"
│   ├── Node
│   │   ├── Sub-node
│   │   └── Sub-node
│   ├── Node
│   └── Node
│
├── Menus
└── Hyperlinks
```

Technically, GNU Info can contain multiple manuals rather than literally merging every document into one physical file.

For Linux Essentials, the important concept is that Info presents documentation as an interconnected, book-like system.

A useful comparison is:

| `man` | `info` |
| --- | --- |
| Reference-oriented | Structured/manual-oriented |
| Individual manual pages | Manuals divided into nodes |
| Excellent for quick lookup | Useful for exploring a topic |
| Related pages through references | Nodes connected through menus and links |

Info documentation is particularly associated with GNU software.

Not every Linux program provides a complete Info manual.

---

## 6.4.1 Viewing Info Documentation

Open documentation for a specific topic with:

```bash
info command
```

Example:

```bash
info ls
```

A status line may resemble:

```text
Info: (coreutils)ls invocation
```

This identifies:

```text
(coreutils)
    → manual

ls invocation
    → current node
```

### Info Nodes and Menus

Info documentation is divided into **nodes**.

For example:

```text
Coreutils Manual
│
└── Directory listing
    │
    └── ls invocation
        │
        ├── Which files are listed
        ├── What information is listed
        ├── Sorting the output
        └── General output formatting
```

A node may contain a menu:

```text
* Menu:

* Which files are listed::
* What information is listed::
* Sorting the output::
```

Menu entries act as hyperlinks to other nodes.

Typical navigation:

```text
Tab
    → move to next hyperlink

Enter
    → follow selected hyperlink
```

This interconnected structure is one of the main differences between Info documents and traditional man pages.

---

## 6.4.2 Navigating Info Documents

Important GNU Info navigation keys include:

| Key | Action |
| --- | --- |
| `H` | Display Info command help |
| `h` | Start the Info tutorial |
| `↑` / `↓` | Move one line |
| `PgUp` / `PgDn` | Move one screen |
| `Home` / `End` | Beginning/end of current node |
| `Tab` | Move to next hyperlink |
| `Enter` | Follow selected hyperlink |
| `l` | Return to last visited node |
| `[` | Previous node in the document |
| `]` | Next node in the document |
| `p` | Previous node on this level |
| `n` | Next node on this level |
| `u` | Move up one level |
| `q` | Quit Info |

A compact model is:

```text
GNU Info Navigation
│
├── Help
│   ├── H → command help
│   └── h → tutorial
│
├── Links
│   ├── Tab   → next link
│   └── Enter → follow link
│
├── Nodes
│   ├── p → previous
│   ├── n → next
│   ├── u → up
│   └── l → last visited
│
└── Exit
    └── q → quit
```

A particularly useful distinction is:

```text
u
    → hierarchy
    → move to parent node


l
    → history
    → return to last visited node
```

For the exam, remember:

```text
q → quit Info
```

---

## 6.4.3 Exploring Info Documentation

Running:

```bash
info
```

without an argument opens the top-level Info directory.

A typical status line is:

```text
Info: (dir)Top
```

This represents the Top node of the Info directory.

Conceptually:

```text
info
 │
 ▼
(dir)Top
 │
 ├── Coreutils
 │   ├── ls
 │   ├── cp
 │   ├── mv
 │   └── ...
 │
 ├── Finding files
 │
 ├── File permissions
 │
 └── Other installed manuals
```

This allows the user to explore available documentation without knowing a specific command in advance.

Compare:

```text
info ls
    → open documentation related to ls


info
    → start at the top-level documentation menu
```

Info can therefore be used both for targeted lookup and broader exploration.

---

## 6.5 Additional Sources of Help

Man pages and Info manuals are important, but they are not the only documentation sources available on Linux.

Other common sources include:

```text
Additional Help
│
├── command --help
├── shell builtin help
├── README files
├── examples
├── changelogs
└── /usr/share/doc/
```

Different documentation sources are useful for different situations.

---

## 6.5.1 Using the Help Option

Many command-line programs support:

```bash
command --help
```

Example:

```bash
cat --help
```

The output commonly contains:

```text
Usage
Short description
Options
Examples
Additional documentation references
```

For example:

```text
Usage: cat [OPTION]... [FILE]...
```

is similar to the `SYNOPSIS` found in a man page.

A useful comparison is:

```text
command --help
    → quick usage and option summary


man command
    → detailed reference


info command
    → structured documentation
```

For Linux Essentials, associate:

```text
--help
    → standard/common option for quick command documentation
```

Some programs also use:

```text
-h
```

but `--help` is the standard answer expected by the course.

### `--help` Is a Program Convention

The shell does not universally implement `--help`.

When executing:

```bash
program --help
```

the shell passes `--help` to the program:

```text
Shell
  │
  └── passes "--help"
             │
             ▼
          Program
             │
             └── decides how to handle it
```

Therefore, `--help` is a very common convention, particularly among GNU utilities, but individual programs define their own command-line options.

### Bash `help` vs `--help`

Do not confuse:

```bash
cat --help
```

with the Bash builtin:

```bash
help
```

For example:

```bash
help cd
```

asks Bash for documentation about its `cd` builtin.

The distinction is:

```text
cat --help
    → pass --help to cat


help cd
    → ask Bash about builtin cd
```

---

## 6.5.2 Additional System Documentation

Linux packages may install additional documentation that is not contained directly in man or Info pages.

The most important location for Linux Essentials is:

```text
/usr/share/doc/
```

Documentation is commonly organized by package:

```text
/usr/share/doc/
│
├── package-a/
│   ├── README
│   ├── changelog
│   └── examples/
│
├── package-b/
│   ├── README.gz
│   ├── copyright
│   └── examples/
│
└── ...
```

Files may include:

```text
README
README.txt
NEWS
CHANGELOG
COPYING
LICENSE
examples/
configuration notes
```

Exact contents vary between distributions and packages.

### README Files

README files provide package-specific information that the software author or distribution maintainer considers useful.

Typical names include:

```text
README
README.txt
README.gz
```

Explore package documentation with:

```bash
ls /usr/share/doc/
```

Then inspect a particular package:

```bash
ls /usr/share/doc/package-name/
```

A text README can be read with:

```bash
less /usr/share/doc/package-name/README
```

when such a file exists.

This documentation can be particularly useful when configuring complex software and system services.

### `/usr/share/doc/` vs `/usr/doc`

Some systems or historical documentation may refer to:

```text
/usr/doc
```

For modern Linux systems, `/usr/share/doc/` is the more important location to recognize and is directly relevant to the Linux Essentials objective.

The exact filesystem layout can still vary by distribution.

---

## Choosing a Help Source

A useful decision model is:

```text
Need help
   │
   ├── Need a quick syntax reminder?
   │       │
   │       └── command --help
   │
   ├── Know the command and need detailed reference?
   │       │
   │       └── man command
   │
   ├── Want structured GNU documentation?
   │       │
   │       └── info command
   │
   ├── Know the man-page name?
   │       │
   │       └── man -f / whatis
   │
   ├── Know the topic but not the command?
   │       │
   │       └── man -k / apropos
   │
   ├── Need binary/source/man locations?
   │       │
   │       └── whereis
   │
   ├── Need to search indexed filenames?
   │       │
   │       └── locate
   │
   └── Need package-specific documentation?
           │
           └── /usr/share/doc/
```

---

## Command Summary

| Command | Purpose |
| --- | --- |
| `man command` | Display a manual page |
| `man SECTION page` | Display a page from a specific manual section |
| `man -f name` | Search by manual-page name |
| `whatis name` | Equivalent/similar to `man -f` |
| `man -k keyword` | Search manual-page names and descriptions |
| `apropos keyword` | Equivalent/similar to `man -k` |
| `info command` | Open structured Info documentation |
| `info` | Open the top-level Info directory |
| `command --help` | Display quick usage information |
| `whereis command` | Locate binary/source/man files in standard locations |
| `locate pattern` | Search the filename database |
| `locate -c pattern` | Count `locate` matches |
| `locate -b pattern` | Match against basenames |
| `updatedb` | Update the `locate` database |

---

## Important Paths

```text
/usr/share/man/
    → stored manual pages


/usr/share/doc/
    → additional package documentation
```

Man pages may be compressed:

```text
/usr/share/man/man1/ls.1.gz
```

---

## Exam Focus

For LPI Linux Essentials Objective 2.2, be able to distinguish the purpose of each documentation mechanism.

```text
man
    → reference documentation


info
    → structured manuals and nodes


whatis / man -f
    → search by manual-page name


apropos / man -k
    → keyword search of manual-page names and descriptions


whereis
    → locate command-related binaries/source/man pages


locate
    → search indexed file and directory names


--help
    → quick command usage


/usr/share/doc/
    → additional installed package documentation
```

Remember the major manual sections:

```text
1 → commands
2 → system calls
3 → library calls
4 → special files
5 → file formats
6 → games
7 → miscellaneous
8 → administration
9 → kernel
```

Remember the essential man-page notation:

```text
[ITEM]      → optional

ITEM...     → may be repeated

A|B         → alternatives

/term       → start a forward search

n           → next search result

N           → previous search result

q           → quit
```

And the essential Info navigation model:

```text
Info
│
├── nodes
├── menus
├── hyperlinks
│
├── Tab   → next link
├── Enter → follow link
├── p     → previous
├── n     → next
├── u     → up
├── l     → last visited
└── q     → quit
```

---

## Quick Review

```text
Question:
How do I read the manual for ls?

Answer:
man ls
```

```text
Question:
How do I read section 5 documentation for passwd?

Answer:
man 5 passwd
```

```text
Question:
How do I find manual pages named passwd?

Answer:
man -f passwd
or
whatis passwd
```

```text
Question:
How do I search manual-page names and descriptions
for the keyword "copy"?

Answer:
man -k copy
or
apropos copy
```

```text
Question:
What is the standard option commonly used to request
quick documentation from a command-line program?

Answer:
--help
```

```text
Question:
Where is additional software package documentation
commonly found?

Answer:
/usr/share/doc/
```

```text
Question:
Which two pager programs are commonly associated
with man pages?

Answer:
less
more
```

```text
Question:
What do square brackets mean in a man-page SYNOPSIS?

Answer:
The enclosed item is optional.
```

```text
Question:
Which key starts a forward search while reading
a man page?

Answer:
/
```

```text
Question:
What does A|B mean in a man-page SYNOPSIS?

Answer:
A and B are alternatives.
```

```text
Question:
How do I locate the binary and man pages associated
with ls?

Answer:
whereis ls
```

```text
Question:
How do I search the locate database for passwd?

Answer:
locate passwd
```

```text
Question:
Why might locate fail to find a newly created file?

Answer:
The locate database may not have been updated yet.
```

```text
Question:
Which command updates the locate database?

Answer:
updatedb
```

```text
Question:
How do I open the top level of GNU Info?

Answer:
info
```

```text
Question:
Which key exits GNU Info?

Answer:
q
```

```text
Question:
What is the main conceptual difference between
man and info?

Answer:
man is primarily reference-oriented, while Info
provides structured manuals organized into
interconnected nodes.
```

```text
Question:
How does the course conceptually describe Info
documentation?

Answer:
As a book-like documentation system divided into
interconnected nodes.
```

---

## Module Summary

Linux provides several complementary mechanisms for obtaining help directly from the system.

```text
                    Linux Help
                        │
       ┌────────────────┼────────────────┐
       │                │                │
       ▼                ▼                ▼
     Quick           Reference       Structured
      Help              Help             Help
       │                │                │
   --help              man              info
                        │                │
                 ┌──────┴──────┐       nodes
                 │             │       menus
              whatis        apropos     links
              man -f        man -k
```

Commands, documentation, and files can also be located through specialized tools:

```text
Finding Things
│
├── whereis
│   └── binary/source/man locations
│
└── locate
    └── indexed pathname searches
```

Additional documentation installed by software packages is commonly available under:

```text
/usr/share/doc/
```

The essential skill is not memorizing every Linux command or option. It is knowing **which documentation source to use, how to search it, and how to navigate the results efficiently**.