# Module 2 — Operating Systems

This module covers the main criteria for choosing an operating system, compares Windows, macOS, and Linux, and introduces Linux distributions, release models, embedded systems, and the role of the command-line interface.

## Exam Objectives

### 1.1 — Linux Evolution and Popular Operating Systems

**Weight:** 2

Key knowledge areas:

- Linux distributions
- Embedded systems

### 4.1 — Choosing an Operating System

**Weight:** 1

Key knowledge areas:

- Differences between Windows, macOS, and Linux
- GUI versus command line
- Distribution life cycle management

---

## 2.1 Operating Systems

An **operating system (OS)** is the software layer responsible for managing the hardware and software resources of a computer.

Among its responsibilities are:

- hardware resource management;
- process and program execution;
- multitasking;
- memory management;
- device management;
- providing services to applications;
- providing interfaces through which users interact with the system.

A simplified view of a computer system is:

```text
                         ┌─────────────────────────┐
                         │          Users          │
                         └────────────┬────────────┘
                                      │
                                      ▼
              ┌───────────────────────────────────────┐
              │               Software                │
              │                                       │
              │  ┌──────────────┐  ┌───────────────┐ │
              │  │    System    │  │ Applications  │ │
              │  │   Software   │  │               │ │
              │  └──────────────┘  └───────────────┘ │
              │                                       │
              │  ┌─────────────────────────────────┐  │
              │  │        Operating System         │  │
              │  └─────────────────────────────────┘  │
              └───────────────────┬───────────────────┘
                                  │
                                  ▼
                         ┌─────────────────────────┐
                         │        Hardware         │
                         └─────────────────────────┘
```

Operating systems can be designed for many different purposes, including:

- desktops;
- servers;
- mobile devices;
- embedded systems;
- network appliances;
- supercomputers;
- computing clusters.

Three major operating system families commonly encountered on personal computers and workstations are:

- Microsoft Windows
- Apple macOS
- Linux

Linux and macOS have strong UNIX or Unix-like foundations, while Windows has its own proprietary architecture.

---

## 2.1.1 Choosing an Operating System

Choosing an operating system requires more than comparing features. The intended role, software requirements, support period, stability, compatibility, cost, and interface should all be considered.

### Role

The first consideration is the intended purpose of the machine.

```text
Intended Use
│
├── Desktop
│   ├── Direct user interaction
│   ├── Productivity applications
│   └── GUI commonly used
│
├── Server
│   ├── Provides remote services
│   ├── Often administered remotely
│   └── CLI commonly preferred
│
└── Specialized System
    ├── Firewall
    ├── Embedded device
    ├── Scientific computing
    └── IoT device
```

Servers commonly avoid unnecessary graphical environments because the resources consumed by a GUI can instead be used for providing services.

### Function

The required functions of the machine should also be determined.

Important questions include:

- What applications must run?
- What services must the system provide?
- How many systems will be deployed?
- What skills does the administration team have?
- Does the required software support the selected operating system?

### Life Cycle

Operating systems and applications follow release and maintenance cycles.

**Release cycle** refers to how frequently new software versions are released.

**Maintenance cycle** refers to how long a release continues receiving fixes, security updates, and support.

Enterprise environments often favor longer support periods because major upgrades can require significant testing, configuration, and operational effort.

Some releases provide **Long-Term Support (LTS)** to reduce the frequency of major migrations.

### Virtualization

Virtualization allows multiple virtual machines to run on one physical system.

```text
┌─────────────────────────────────────┐
│          Physical Server            │
│                                     │
│   ┌────────┐ ┌────────┐ ┌────────┐  │
│   │  VM 1  │ │  VM 2  │ │  VM 3  │  │
│   └────────┘ └────────┘ └────────┘  │
│                                     │
└─────────────────────────────────────┘
```

Virtualization can:

- reduce physical hardware requirements;
- reduce power and space consumption;
- simplify deployment;
- improve resource utilization;
- enable automation.

Cloud computing extends this model by allowing computing resources to be provisioned from providers such as AWS and Microsoft Azure.

### Stability

Software releases may have different stability levels.

A simplified development progression is:

```text
Development
     │
     ▼
   Beta
     │
     ▼
 Testing
     │
     ▼
  Stable
```

**Beta software** may contain new features that have not yet received extensive testing.

**Stable software** has undergone significantly more testing and is generally preferred for production systems.

Production environments normally prioritize stability unless a required feature is only available in a newer development release.

### Backward Compatibility

**Backward compatibility** means that a newer system remains capable of working with software, formats, or interfaces designed for older versions.

```text
Old Application
      │
      ▼
Newer Operating System
      │
      ▼
 Still Works
```

Backward compatibility can be especially important when an operating system must be upgraded but an important application cannot be replaced or upgraded.

### Cost

The purchase price of an operating system is only one part of its cost.

Organizations should also consider:

- licensing;
- commercial support;
- administration;
- training;
- hardware;
- maintenance;
- upgrades;
- downtime;
- future requirements.

Therefore:

```text
Software Price ≠ Total Cost of Ownership
```

### Interface

Modern operating systems commonly provide two interaction models:

```text
User Interface
│
├── GUI
│   ├── Windows
│   ├── Icons
│   ├── Menus
│   └── Pointer
│
└── CLI
    ├── Commands
    ├── Text input
    ├── Text output
    └── Shell
```

Desktop systems commonly emphasize the GUI, while servers are frequently administered through the CLI.

---

## 2.2 Microsoft Windows

Microsoft provides Windows editions for different roles, particularly desktops and servers.

Windows desktop systems emphasize graphical interaction and backward compatibility with existing Windows applications.

Windows Server provides capabilities intended for server workloads and enterprise administration.

Important Microsoft technologies include:

- **PowerShell** — command-line shell and scripting environment;
- **Windows Subsystem for Linux (WSL)** — provides a Linux environment within Windows;
- **Microsoft Azure** — Microsoft's cloud computing platform.

Windows administration can use both graphical tools and command-line automation.

---

## 2.3 Apple macOS

**macOS** is Apple's desktop operating system.

It has UNIX foundations and incorporates technology originating from projects including FreeBSD. Modern macOS releases are tightly integrated with Apple hardware.

Important characteristics include:

- UNIX-based environment;
- graphical desktop;
- strong command-line capabilities;
- integration with Apple hardware and services;
- widespread commercial application support.

Its UNIX environment also makes macOS familiar to many developers and administrators who work with Unix-like systems.

---

## 2.4 Linux

Linux systems are normally obtained as a **Linux distribution**.

A distribution combines the Linux kernel with the software required to create a usable operating system.

```text
Linux Distribution
│
├── Linux Kernel
├── System Utilities
├── Libraries
├── Hardware Support
├── Management Tools
├── Package Manager
└── Applications
```

Distributions usually provide mechanisms for:

- installing the operating system;
- configuring storage;
- supporting hardware;
- installing applications;
- installing and removing packages;
- applying security updates;
- maintaining the system.

There are hundreds of Linux distributions because Linux can be adapted for many different purposes.

### Linux Roles

Linux can be used for:

- desktop systems;
- web servers;
- application servers;
- cloud infrastructure;
- firewalls;
- scientific computing;
- supercomputers;
- embedded systems;
- IoT devices.

### Application Support

Software availability is an important consideration when selecting a distribution.

Commercial software vendors may officially support only specific distributions or releases because different distributions can contain different versions of libraries and other dependencies.

Applications such as Firefox and LibreOffice, however, are widely available across major Linux distributions.

### Distribution Life Cycle

Linux distributions can follow very different release models.

Some prioritize rapid delivery of new software, while enterprise distributions generally prioritize:

- stability;
- compatibility;
- predictable maintenance;
- long support periods.

A fast-moving distribution may provide newer software sooner but require more frequent updates.

An enterprise distribution generally changes more conservatively and may provide commercial support.

### Stable, Testing, and Unstable

Some distributions organize software into different development stages:

```text
Unstable
   │
   ▼
Testing
   │
   ▼
Stable
```

An unstable release provides access to newer software but may experience dependency problems, regressions, or major changes.

Stable releases prioritize reliability and are generally more appropriate for production environments.

---

## Linux CLI

Linux can be operated through both graphical and command-line interfaces.

The CLI involves several distinct components.

```text
┌──────────┐
│   User   │
└────┬─────┘
     │ types command
     ▼
┌──────────┐
│ Terminal │
└────┬─────┘
     │ passes input
     ▼
┌──────────┐
│  Shell   │
└────┬─────┘
     │ interprets command
     ▼
┌──────────────────┐
│ Operating System │
└──────────────────┘
```

The **terminal** provides the text interface.

The **shell** interprets commands and provides the command-line environment.

This distinction is important:

```text
Terminal ≠ Shell
```

A terminal may also maintain a visual scrollback buffer, while the shell can maintain a separate history of commands entered by the user.

### CLI Login

A text-based login can lead directly to a user's shell:

```text
login: user
password: ********
        │
        ▼
 Authentication
        │
        ▼
   User Shell
        │
        ▼
 Command Prompt
```

After login, the system may display a **Message of the Day (MOTD)** containing information provided by the system administrator.

One command introduced in this module is:

```bash
w
```

The `w` command displays information about users currently logged into the system and what they are doing.

---

## 2.4.1 Linux Distributions

Linux distributions can be grouped into several major historical families.

```text
Linux Distribution Families
│
├── Debian
│   ├── Ubuntu
│   │   └── Linux Mint
│   └── Raspberry Pi OS
│       (formerly Raspbian)
│
├── Red Hat ecosystem
│   ├── Fedora
│   ├── RHEL
│   └── CentOS
│       (relationship changed over time)
│
├── Slackware
│   └── SUSE
│       ├── openSUSE
│       └── SUSE Linux Enterprise
│
├── Android
│   └── Linux kernel-based mobile platform
│
└── Linux From Scratch
    └── Build a Linux system from source
```

### Red Hat

The Red Hat ecosystem includes **Red Hat Enterprise Linux (RHEL)** and the community **Fedora Project**.

RHEL focuses on enterprise workloads, stability, long maintenance periods, and commercial support.

Fedora generally introduces newer technologies more rapidly and serves as an important upstream source for technologies that may later appear in Red Hat enterprise products.

Red Hat also introduced the **RPM** package format and associated package-management ecosystem.

### CentOS

Historically, **CentOS Linux** provided a freely available rebuild closely compatible with RHEL.

The CentOS project has changed significantly since the course material was originally written. Modern **CentOS Stream** occupies a different position in the Red Hat development process and should not be treated as identical to the historical CentOS Linux model.

### Scientific Linux

**Scientific Linux** was a RHEL-derived distribution designed for scientific computing and was sponsored by Fermilab.

It is historically relevant to Linux Essentials material but has since been discontinued.

### SUSE

SUSE historically originated from Slackware and developed into its own major Linux ecosystem.

Important projects and products include:

- openSUSE;
- SUSE Linux Enterprise;
- SUSE Linux Enterprise Server (SLES).

### Debian

**Debian** is a community-driven distribution emphasizing free and open source software, standards, and support for multiple hardware architectures.

Debian uses packages with the:

```text
.deb
```

format.

### Ubuntu

**Ubuntu** is derived from Debian and developed by Canonical.

It provides editions for different workloads and offers **Long-Term Support (LTS)** releases intended for longer maintenance periods.

### Linux Mint

**Linux Mint** is primarily derived from Ubuntu and uses much of the Ubuntu package ecosystem.

### Android

Android uses the **Linux kernel**, but it differs substantially from a conventional GNU/Linux desktop distribution.

Traditional Linux distributions commonly combine:

```text
Linux Kernel
     +
GNU Utilities
     +
System Libraries
     +
Desktop / Server Software
```

Android uses a different user-space environment designed primarily for mobile and embedded devices.

Older Android versions used the **Dalvik** runtime. Modern Android uses **ART (Android Runtime)**.

### Raspberry Pi OS

The distribution historically known as **Raspbian** is now known as **Raspberry Pi OS**.

It is designed for Raspberry Pi hardware and is widely used for:

- education;
- programming;
- electronics;
- automation;
- robotics;
- embedded projects.

### Linux From Scratch

**Linux From Scratch (LFS)** is primarily an educational project that teaches how to construct a Linux system from source code.

It provides insight into how components such as the kernel, libraries, toolchain, utilities, and configuration combine to form a complete Linux system.

---

## 2.4.2 Embedded Systems

An **embedded system** is a computing system designed to perform a specific function, usually using hardware optimized for that purpose.

Linux's portability and flexibility have allowed it to run on many processor architectures beyond the desktop computers for which it was originally developed.

Embedded Linux can be found in:

```text
                     Embedded Linux
                           │
          ┌────────────────┼────────────────┐
          │                │                │
          ▼                ▼                ▼
     Consumer          Industrial           IoT
      Devices            Systems           Devices
          │                │                │
     Smart TVs         Factories         Sensors
       DVRs            Pipelines        Controllers
    Appliances         Monitoring       Automation
```

Single-board computers such as the **Raspberry Pi** have made Linux-based embedded development inexpensive and accessible.

### Internet of Things

The **Internet of Things (IoT)** connects sensors, controllers, and other embedded devices through networks.

A simplified architecture is:

```text
┌─────────────┐
│   Sensors   │
└──────┬──────┘
       │ measurements
       ▼
┌─────────────┐
│ Controllers │
└──────┬──────┘
       │ network
       ▼
┌─────────────────┐
│ Central Systems │
└──────┬──────────┘
       │ decisions
       ▼
┌─────────────────┐
│ Process Control │
└─────────────────┘
```

Data collected by these systems can also be processed using machine learning and artificial intelligence:

```text
Physical Environment
        │
        ▼
     Sensors
        │
        ▼
  Data Collection
        │
        ▼
   ML / AI Analysis
        │
        ▼
     Decisions
        │
        ▼
    Controllers
        │
        ▼
Physical Environment
```

This enables monitoring, automation, optimization, and real-time control of physical processes.

---

## Key Concepts

| Concept | Description |
| --- | --- |
| Operating System | Software responsible for managing hardware and software resources |
| Desktop | System intended primarily for direct user interaction |
| Server | System primarily intended to provide services to other systems or users |
| GUI | Graphical User Interface |
| CLI | Command Line Interface |
| Terminal | Interface/application through which textual input and output are presented |
| Shell | Program that provides and interprets the command-line environment |
| Distribution | Linux kernel combined with utilities, libraries, management tools, and applications |
| Package Manager | Software used to install, update, and remove packages |
| Release Cycle | Frequency at which new software releases are produced |
| Maintenance Cycle | Period during which a release receives maintenance and updates |
| LTS | Long-Term Support |
| Beta | Release containing newer functionality that has not yet received full production-level testing |
| Stable | Release intended to provide tested and reliable software |
| Backward Compatibility | Ability of newer systems to remain compatible with older software or formats |
| Virtualization | Running virtual computing environments on physical hardware |
| Embedded System | Computer designed for a specific function |
| IoT | Network of connected sensors, controllers, and other devices |

---

## Exam Review

Before moving to the next module, I should be able to answer:

- What does an operating system do?
- What is the difference between a desktop and a server?
- What factors should be considered when choosing an operating system?
- What is a release cycle?
- What is a maintenance cycle?
- What is the difference between beta and stable software?
- What is backward compatibility?
- What is virtualization?
- What are the main differences between Windows, macOS, and Linux?
- What is a Linux distribution?
- What does a package manager do?
- Why might an organization require commercial Linux support?
- Why is application compatibility important when selecting a distribution?
- What is an LTS release?
- What is the relationship between Fedora and Red Hat?
- Which distribution did SUSE historically derive from?
- What is the relationship between Debian and Ubuntu?
- What is the difference between a terminal and a shell?
- Why are Linux servers commonly administered through the CLI?
- What is an embedded system?
- Why is Linux well suited to embedded systems?
- How is Linux used in IoT environments?

---

## Quick Exam Facts

```text
Fedora       → Red Hat ecosystem
SUSE         → historically derived from Slackware
Ubuntu       → derived from Debian
Linux Mint   → primarily derived from Ubuntu
Raspberry Pi OS → formerly Raspbian
RPM          → Red Hat package ecosystem
.deb         → Debian package format

Beta         → newer, less-tested software
Stable       → tested, reliability-oriented software
LTS          → extended maintenance/support period

GUI          → graphical interaction
CLI          → text/command-based interaction

Terminal     → handles textual interaction
Shell        → interprets the command environment

Kernel + utilities + tools + applications
             → Linux distribution

Install/remove/update software
             → Package manager

Most important OS selection question
             → What is the intended use of the system?
```

---

## References

- [Cisco Networking Academy](https://www.netacad.com/)
- [Linux Professional Institute](https://www.lpi.org/)
- [The Linux Kernel Archives](https://www.kernel.org/)
- [Debian](https://www.debian.org/)
- [Fedora](https://fedoraproject.org/)
- [Red Hat](https://www.redhat.com/)
- [Ubuntu](https://ubuntu.com/)
- [openSUSE](https://www.opensuse.org/)
- [Linux From Scratch](https://www.linuxfromscratch.org/)

---

[← Back to main README](../../README.md)
