# Module 3 — Working in Linux

This module introduces everyday Linux usage, major open source applications,
package management, development languages, security and privacy concepts,
cloud computing, virtualization, and containers.

## Exam Objectives

### 1.1 Linux Evolution and Popular Operating Systems

- Linux in the cloud

### 1.2 Major Open Source Applications

- Desktop applications
- Server applications
- Development languages
- Package management tools and repositories

### 1.4 ICT Skills and Working in Linux

- Desktop skills
- Getting to the command line
- Industry uses of Linux
- Cloud computing
- Virtualization

---

# 3.1 Navigating the Linux Desktop

Linux systems can provide graphical desktop environments similar to those
found on other operating systems.

Common Linux desktop environments include:

- GNOME
- KDE Plasma
- Xfce

A Linux system administrator may work with both graphical and command-line
interfaces.

```text
Linux System Administrator
│
├── Server Administration
├── System Configuration
├── Troubleshooting
├── User Support
├── Software Recommendations
└── Documentation
```

Regular desktop use is useful for learning Linux, but administration
increasingly relies on command-line tools.

## 3.1.1 Getting to the Command Line

The command-line interface (CLI) allows users to interact with the system
using textual commands.

Linux provides several ways to access a command line:

- Terminal emulator inside a graphical desktop
- Virtual terminal
- Remote shell, such as SSH
- Local system console

A terminal and a shell are different concepts.

```text
Console
   └── Traditionally a local/physical system terminal

Terminal / Terminal Emulator
   └── Provides textual input and output

Shell
   └── Interprets commands and provides a command environment

CLI
   └── Text-based method of interacting with the system
```

Common shells include:

- Bash
- Zsh
- Dash
- Korn shell
- C shell and tcsh

Servers often operate without a graphical environment, reducing unnecessary
resource consumption and making remote command-line administration important.

---

# 3.2 Applications

The Linux kernel manages system resources and provides interfaces used by
applications.

Its responsibilities include:

- CPU scheduling
- Memory management
- Device management
- Storage access
- Process management

```text
                Applications
              /      |       \
             v       v        v
       Browser    Editor    Web Server
             \       |        /
              v      v       v
              +--------------+
              |    Kernel    |
              +------+-------+
                     |
          +----------+----------+
          v          v          v
         CPU       Memory     Storage
```

A **process** is a running instance of a program. A single application may
create multiple processes.

Linux also provides virtual memory, allowing the operating system to manage
memory beyond the immediately available physical RAM, including the use of
swap when appropriate.

## 3.2.1 Major Application Categories

Linux applications can broadly be divided into:

1. Server applications
2. Desktop applications
3. System and development tools

Software selection may depend on:

- Functionality
- Performance
- Stability
- Compatibility
- Support
- Cost

---

# 3.2.2 Server Applications

Linux is widely used as a server operating system.

Important server application categories include:

```text
Server Applications
│
├── Web
│   ├── Apache HTTPD
│   └── NGINX
│
├── Database
│   ├── MySQL
│   ├── MariaDB
│   └── PostgreSQL
│
├── File Sharing
│   ├── NFS
│   ├── Samba
│   └── Netatalk
│
├── Email
│   ├── Postfix
│   ├── Sendmail
│   └── Dovecot
│
└── Private Cloud
    ├── ownCloud
    └── Nextcloud
```

## Web Servers

**HTTP** stands for Hypertext Transfer Protocol.

**HTTPS** is HTTP protected by TLS.

A static web server returns stored content directly.

```text
Browser
   |
   | HTTP/HTTPS request
   v
Web Server
   |
   v
Static File
```

Dynamic applications generate content in response to requests and often
communicate with databases.

```text
Browser
   |
   v
Web Server / Application
   |
   v
Database Server
```

Important web servers include:

- **Apache HTTPD** — general-purpose open source web server
- **NGINX** — web server also commonly used as a reverse proxy and load
  balancer

## Private Cloud Servers

Private cloud software can provide file synchronization, sharing, and related
services under organizational control.

Important examples include:

- ownCloud
- Nextcloud

Nextcloud originated as a fork of ownCloud.

Other notable open source forks include:

```text
MySQL ---------> MariaDB
ownCloud ------> Nextcloud
OpenOffice.org -> LibreOffice
```

A private cloud is dedicated to an organization but does not necessarily
have to run on hardware physically located on the organization's premises.

## Database Servers

A relational database management system (RDBMS) organizes data primarily
into related tables containing rows and columns.

**SQL** stands for Structured Query Language.

SQL is used to:

- Query data
- Insert data
- Update data
- Delete data
- Aggregate and analyze data

Important database systems include:

- MySQL
- MariaDB
- PostgreSQL

MariaDB originated as a fork of MySQL.

## Email Servers

Several components participate in email delivery.

```text
Sender Client
     |
     | SMTP
     v
Sender MTA
     |
     | SMTP
     v
Recipient MTA
     |
     v
MDA / LDA
     |
     v
Mailbox
     |
     | POP / IMAP
     v
Recipient Client
```

Important terms:

- **MTA** — Mail Transfer Agent
- **MDA/LDA** — Mail/Local Delivery Agent
- **SMTP** — protocol used to send and transfer email
- **POP/IMAP** — protocols used by clients to access mailboxes

Examples:

- Sendmail
- Postfix
- Dovecot
- Cyrus IMAP

## File Sharing and Network Services

### NFS

**NFS (Network File System)** is traditionally used for file sharing between
Unix and Linux systems.

Remote filesystems can be mounted and accessed similarly to local
filesystems.

### Samba

Samba implements SMB-based services and is commonly used for interoperability
between Linux and Windows systems.

It can provide:

- File sharing
- Printer sharing
- Windows network interoperability
- Domain-related services

### Netatalk

Netatalk historically provides Apple-compatible network file services.
Modern macOS environments commonly use SMB instead.

Other important network services include:

- **DNS** — name resolution
- **BIND** — DNS server implementation
- **LDAP** — directory access protocol
- **OpenLDAP** — LDAP implementation
- **DHCP** — automatic network configuration

The classic DHCP exchange can be remembered as DORA:

```text
Client                    DHCP Server
  |                            |
  |------ Discover ----------->|
  |<------- Offer -------------|
  |------ Request ------------>|
  |<---- Acknowledge ----------|
```

---

# 3.2.3 Desktop Applications

Desktop applications interact directly with users.

Important categories include:

- Productivity
- Internet
- Creative applications
- Multimedia
- Games

Important open source desktop applications include:

```text
Desktop Applications
│
├── Firefox     -> Web browser
├── Thunderbird -> Email client
├── LibreOffice -> Office suite
├── GIMP        -> Image editing
├── Audacity    -> Audio editing
└── Blender     -> 3D graphics
```

## Email

Thunderbird is an open source desktop email client.

Email clients commonly use:

- SMTP for sending mail
- IMAP or POP for accessing mail

Other Linux email clients include Evolution and KMail.

## Creative Applications

- **GIMP** — image editing
- **Blender** — 3D graphics and animation
- **Audacity** — audio recording and editing

Audacity, for example, can be used to edit and combine audio files for a
podcast.

## Productivity

LibreOffice is an open source office suite originating as a fork of
OpenOffice.org.

Important components include:

- Writer — word processing
- Calc — spreadsheets
- Impress — presentations

LibreOffice can work with several Microsoft Office file formats and export
documents to PDF.

## Web Browsers

Firefox is Mozilla's open source, cross-platform web browser.

Chromium is an open source browser project forming much of the technical
basis of Google Chrome. Chrome itself includes additional proprietary
components.

Browser configuration can control:

- Cookies
- History
- Site permissions
- Stored site data
- Tracking protection

Private or incognito browsing reduces persistence of local browsing data but
does not provide anonymity on the Internet.

---

# 3.3 Console Tools

Linux and Unix administration has historically been closely connected to
command-line tools and scripting.

Scripts can automate repetitive administrative tasks.

Typical scripting features include:

- Variables
- Conditions
- Loops
- Functions
- Input and output
- Command composition

## 3.3.1 Shells

A shell provides a command execution and scripting environment.

Important historical shell families include:

```text
Linux Shells
│
├── Bourne family
│   ├── sh
│   ├── bash
│   └── ksh
│
├── C shell family
│   ├── csh
│   └── tcsh
│
└── Other modern shells
    └── zsh
```

**Bash** means **Bourne Again Shell** and remains one of the most important
shells to recognize in Linux environments.

The shell:

- Executes commands and programs
- Supports scripting
- Can be customized

A shell is not the same thing as a terminal.

## 3.3.2 Text Editors

Important console-oriented editors include:

- Vi
- Vim
- Emacs
- Pico
- Nano

### Vi and Vim

Vi is the classic Unix text editor.

Vim means **Vi IMproved** and extends Vi with many additional features.

Some basic Vim commands are:

```text
i     Enter insert mode
Esc   Return to normal mode
:w    Write/save
:q    Quit
:wq   Save and quit
:q!   Quit without saving
```

### Nano

Nano provides a simpler terminal editing experience.

Common shortcuts include:

```text
Ctrl+O   Write/save
Ctrl+X   Exit
Ctrl+W   Search
```

Vi/Vim familiarity is useful because a Vi-compatible editor is frequently
available in minimal and recovery environments.

---

# 3.4 Package Management

Linux distributions normally distribute software through packages and
repositories.

A **package** is a software distribution unit containing files and metadata,
including dependency information.

A **package manager** can:

- Install software
- Remove software
- Update software
- Track installed packages and their files
- Resolve dependencies
- Download packages from repositories

A **repository** is an organized source of packages and package metadata.

Two important package-management families are:

```text
Debian family               Red Hat family
-------------               --------------
.deb                        .rpm
dpkg                        rpm
APT / apt-get               YUM
```

Modern systems also commonly use:

- `apt` in Debian-family distributions
- DNF in modern Fedora/RHEL-family distributions

The Linux Essentials objectives, however, specifically emphasize
`dpkg`, `apt-get`, `rpm`, and `yum`.

---

# 3.4.1 Debian Package Management

Debian, Ubuntu, Linux Mint, and related distributions use `.deb` packages.

## dpkg

`dpkg` is a lower-level Debian package management tool.

Examples:

```bash
dpkg -i package.deb
dpkg -r package-name
dpkg -l
```

## APT and apt-get

APT stands for **Advanced Package Tool**.

`apt-get` provides higher-level repository and dependency management.

Examples:

```bash
apt-get update
apt-get install package-name
apt-get upgrade
```

`apt-get update` updates local package metadata. It does not itself upgrade
installed applications.

Conceptually:

```text
User
├── apt-get
├── aptitude
└── GUI tools
       |
       v
      APT
       |
       v
     dpkg
       |
       v
 .deb packages
```

This diagram represents conceptual layers rather than a strict internal
implementation path.

---

# 3.4.2 RPM Package Management

RPM-based distributions use `.rpm` packages.

The `rpm` utility provides lower-level package operations.

For example:

```bash
rpm -qa
```

lists installed RPM packages.

**YUM** provides higher-level repository and dependency management for
RPM-based systems.

Historically, YUM means **Yellowdog Updater, Modified**.

Modern Fedora and Red Hat Enterprise Linux systems primarily use **DNF**,
with `yum` often retained as a compatibility interface.

SUSE and openSUSE also use RPM packages but commonly use the ZYpp stack and
the `zypper` command:

```bash
zypper install package-name
```

A useful modern overview is:

```text
Linux Package Management
│
├── Debian family
│   ├── .deb
│   ├── dpkg
│   └── APT / apt-get
│
├── Red Hat / RPM family
│   ├── .rpm
│   ├── rpm
│   └── YUM / DNF
│
├── SUSE / openSUSE
│   ├── .rpm
│   ├── ZYpp
│   └── zypper
│
└── Arch Linux
    └── pacman
```

Arch Linux does **not** use RPM as its native package-management system.

Installing, updating, or removing system packages normally requires
administrative privileges.

---

# 3.5 Development Languages

Linux provides a rich development environment containing:

- Editors
- Compilers
- Interpreters
- Libraries
- Shells
- Development tools

A simplified distinction used in introductory material is:

```text
Compiled
   -> translated before execution

Interpreted
   -> handled by a runtime/interpreter during execution
```

Modern language implementations can combine compilation, bytecode,
interpretation, virtual machines, and just-in-time compilation, so this
distinction is not always absolute.

## C

C is a compiled systems programming language.

The Linux kernel is predominantly written in C, although modern kernel
development also permits Rust in some components.

C provides efficient execution and relatively low-level control of system
resources.

## Java

Java source code is normally compiled into bytecode that executes in a
**JVM — Java Virtual Machine**.

```text
Java Source
    |
    v
Compiler
    |
    v
Bytecode
    |
    v
JVM
    |
    v
Operating System
```

This architecture enables Java applications to run on different platforms
that provide compatible JVM implementations.

## JavaScript

JavaScript is a high-level programming language central to modern web
development.

A simple web model is:

```text
HTML       -> Structure
CSS        -> Presentation
JavaScript -> Behavior
```

JavaScript can also execute outside browsers, including on servers.

Java and JavaScript are separate programming languages.

## Perl

Perl has historically been widely used for:

- Text processing
- Scripting
- System administration
- Automation
- Web development

## PHP

PHP is commonly used for server-side web development.

```text
Browser
   |
   v
Web Server
   |
   v
PHP Application
   |
   v
Database
```

WordPress is a major example of software written primarily in PHP.

## Ruby

Ruby is a high-level programming language.

Ruby on Rails is a well-known web application framework.

## Python

Python is a high-level, general-purpose programming language commonly used
for:

- Automation
- System administration
- Web development
- Data processing
- Scientific computing
- Education

Django is a well-known Python web framework.

## Libraries and Toolkits

A library provides reusable functionality for software.

Examples include:

- ImageMagick — image processing tools and libraries
- OpenSSL — cryptography and TLS toolkit
- glibc — common GNU C library implementation on Linux

Important languages for the Linux Essentials objectives include:

```text
C
Java
JavaScript
PHP
Perl
Python
```

---

# 3.6 Security and Privacy

Security includes both technical controls and human behavior.

Common risks include:

- Phishing
- Malicious attachments
- Fake login pages
- Weak passwords
- Reused passwords
- Unpatched software

**Phishing** attempts to trick users into revealing credentials or other
sensitive information.

## Browser Privacy

Websites can use cookies for legitimate purposes such as:

- Maintaining sessions
- Login state
- Shopping carts
- Preferences

Cookies and other browser technologies can also be used for tracking.

```text
Browser
│
├── First-party site data
├── Third-party resources
├── Cookies
├── Local storage
└── Other identifiers
```

A cookie is not inherently malware.

Third-party resources embedded across many sites may be able to correlate
user activity.

Browser privacy controls can restrict:

- Cookies
- Third-party cookies
- Site permissions
- History
- Stored data
- Tracking mechanisms

Increasing privacy restrictions can cause some websites to stop working
correctly and may require explicitly allowing certain cookies.

**Do Not Track (DNT)** is a browser preference signal, not a technical
enforcement mechanism.

Private/incognito mode mainly limits local persistence of browsing data.
It does not make the user anonymous to websites, network administrators,
Internet providers, or other external parties.

---

# 3.6.1 Password Issues

The traditional Linux superuser is **root**, identified by UID 0.

Root can perform privileged administrative operations such as:

- Managing users
- Installing software
- Changing protected configuration
- Managing services
- Modifying permissions

Modern administration commonly restricts direct root login and uses tools
such as `sudo` for controlled privilege elevation.

## Users and Groups

Groups help organize access to system resources.

Permissions, groups, sudo policies, PAM configuration, and other mechanisms
can all participate in authorization.

## Service Accounts

Network services commonly execute under dedicated restricted accounts.

```text
Service
   |
   v
Restricted Service Account
   |
   v
Only Required Resources
```

This follows the **principle of least privilege**.

Service accounts often do not require an interactive login or usable
password.

## Strong Passwords

The course describes strong passwords as:

- At least 10 characters long
- A mixture of upper- and lowercase letters
- Numbers
- Symbols

Modern password guidance places particular emphasis on:

- Length
- Uniqueness
- Resistance to guessing
- Avoiding password reuse

Password managers make long, unique credentials practical.

## Password Managers

A password manager stores credentials in a protected vault.

```text
                Master Password
                      |
                      v
               Password Manager
                      |
                Encrypted Vault
              /       |       \
             v        v        v
          Site A   Site B   Site C
          unique   unique   unique
```

KeePassX is the password manager referenced by the course, although that
specific project has been discontinued.

## Two-Factor Authentication

Two-factor authentication (2FA) combines authentication factors from
different categories.

```text
Something you know
    -> Password / PIN

Something you have
    -> Security key / authenticator device

Something you are
    -> Biometrics
```

Using a password together with another password does not constitute classic
two-factor authentication because both use the same factor category.

## SSH

SSH stands for **Secure Shell** and provides secure remote access.

SSH can authenticate users with mechanisms including:

- Passwords
- Public/private key pairs

---

# 3.6.2 Protecting Yourself

Online activity creates a **digital footprint**.

Security and privacy can be improved through several complementary controls:

```text
Protecting Yourself
│
├── Strong authentication
├── Limit personal information
├── Keep software updated
└── Control network access
    └── Firewall
```

Users should avoid providing unnecessary personal information because such
information can assist impersonation and social-engineering attacks.

Keeping software updated reduces exposure to known vulnerabilities.

```text
Known Vulnerability
       |
       v
Security Fix
       |
       v
Repository
       |
       v
Package Update
       |
       v
Updated System
```

## Firewalls

A firewall filters network traffic according to configured rules.

Rules may consider:

- Source
- Destination
- Protocol
- Port
- Connection state

```text
Internet
   |
   v
+----------+
| Firewall |
+----+-----+
     |
     v
Linux System
```

Ubuntu provides **UFW — Uncomplicated Firewall** as a simplified firewall
configuration interface.

**Gufw** provides a graphical interface for UFW.

Historically, introductory Linux material commonly describes `iptables` as
the Linux firewall management tool. Modern Linux distributions increasingly
use **nftables** as the underlying packet-filtering framework, although
iptables-compatible interfaces remain relevant.

---

# 3.6.3 Privacy Tools

Important privacy technologies include:

```text
Privacy Tools
│
├── Encryption
├── HTTPS / TLS
├── VPN
└── Tor
```

## Encryption

Encryption converts readable plaintext into protected ciphertext.

```text
Plaintext
   |
   | Encryption
   v
Ciphertext
   |
   | Decryption
   v
Plaintext
```

Encryption can protect:

- Data in transit
- Data at rest

## HTTPS and TLS

HTTPS is HTTP protected by TLS.

TLS provides important security properties including:

- Confidentiality
- Integrity
- Authentication

```text
Browser
   |
   | HTTPS / TLS
   v
Web Server
```

HTTPS protects the communication channel but does not guarantee that the
website itself is trustworthy.

## VPN

A **VPN — Virtual Private Network** creates a protected network tunnel.

```text
Remote System
      ||
      || Encrypted VPN Tunnel
      ||
      v
VPN Gateway
      |
      v
Remote Network
```

VPNs are commonly used to connect:

- Remote employees to corporate networks
- Separate organizational networks
- Users to remote VPN gateways

A VPN does not automatically provide complete Internet anonymity.

## Tor

Tor routes traffic through multiple relays to make it more difficult to
associate traffic origin with destination.

```text
User
 |
 v
Guard Relay
 |
 v
Middle Relay
 |
 v
Exit Relay
 |
 v
Destination
```

Tor uses an approach known as **onion routing**.

Tor Browser is configured to use the Tor network and includes additional
privacy protections.

A useful distinction is:

```text
HTTPS -> protects communication with a website

VPN   -> creates a protected network tunnel

Tor   -> routes traffic through multiple relays
         to improve privacy/anonymity
```

---

# 3.7 The Cloud

Cloud computing provides computing resources and services over a network,
usually the Internet.

Cloud resources may include:

- Compute
- Storage
- Databases
- Application hosting
- Networking
- Analytics

```text
User
 |
 | Internet
 v
Cloud Infrastructure
│
├── Compute
├── Storage
├── Databases
├── Networking
└── Applications
```

Cloud services ultimately run on physical infrastructure located in data
centers, but cloud computing adds service models, automation, resource
pooling, and on-demand provisioning.

## Cloud Adoption

**Cloud adoption** refers to adopting or migrating IT applications,
processes, and resources to cloud services.

Cloud computing can allow organizations to delegate parts of physical
infrastructure management to cloud providers.

---

# Cloud Deployment Models

Four major deployment models are important for Linux Essentials:

```text
Cloud Deployment Models
│
├── Public
├── Private
├── Community
└── Hybrid
```

## Public Cloud

A public cloud provider offers infrastructure and services to multiple
customers.

```text
             Public Cloud
                  |
        +---------+---------+
        v         v         v
     Tenant A  Tenant B  Tenant C
```

A **tenant** is a consumer of cloud resources.

**Multi-tenancy** allows multiple tenants to use logically separated
resources on shared provider infrastructure.

## Private Cloud

A private cloud is dedicated to one organization.

```text
Organization
     |
     v
Private Cloud
```

A private cloud does not necessarily have to be hosted on the organization's
own premises.

## Community Cloud

A community cloud serves a group of organizations with common requirements
or objectives.

```text
Organization A --+
Organization B --+--> Community Cloud
Organization C --+
```

## Hybrid Cloud

A hybrid cloud combines multiple distinct cloud environments.

```text
        Organization
             |
      +------+------+
      v             v
Private Cloud   Public Cloud
      \             /
       +-----+-----+
             |
             v
        Hybrid Cloud
```

The essential distinction is:

```text
PUBLIC    -> multiple customers
PRIVATE   -> one organization
COMMUNITY -> organizations with common requirements
HYBRID    -> combination of cloud environments
```

---

# 3.7.1 Linux in the Cloud

Linux is widely used throughout cloud infrastructure.

Characteristics that make Linux useful in cloud environments include:

- Flexibility
- Broad hardware support
- Large open source ecosystem
- Automation capabilities
- Cost flexibility
- Strong server ecosystem

Linux systems can be deployed across a wide range of environments, from
embedded devices to large data centers.

Cloud infrastructure also relies heavily on automated system management.

```text
Linux
  +
Scripting
  +
Automation
     |
     v
Cloud Administration
```

## Virtualization

Virtualization allows one physical computer to run multiple isolated virtual
machines.

Important terminology:

- **Host** — base/physical system providing resources
- **Guest** — operating system instance running in a virtual machine
- **Hypervisor** — software layer that manages virtual machines

```text
Physical Hardware
       |
       v
   Hypervisor
       |
 +-----+-----+
 v     v     v
VM 1  VM 2  VM 3
 |     |     |
Guest Guest Guest
 OS    OS    OS
```

Each virtual machine receives virtual resources such as:

- Virtual CPU
- Virtual RAM
- Virtual disk
- Virtual network interfaces

Different guest operating systems can run on the same physical host.

## Bare-Metal Hypervisors

A bare-metal, or Type 1, hypervisor runs directly on physical hardware.

```text
VMs
 |
 v
Hypervisor
 |
 v
Hardware
```

A hosted, or Type 2, hypervisor runs on top of a host operating system.

```text
Virtual Machines
       |
       v
   Hypervisor
       |
       v
    Host OS
       |
       v
    Hardware
```

Virtualization enables server consolidation and can reduce:

- Number of physical machines
- Data-center space
- Power consumption
- Cooling requirements

It also makes systems easier to provision and remove programmatically.

```text
Need Environment
       |
       v
Create VM
       |
       v
Use VM
       |
       v
Destroy VM
```

This ability is fundamental to cloud computing.

---

# Containers

Containers provide application isolation while sharing the host operating
system kernel.

This differs from traditional virtual machines.

## Virtual Machines

```text
+---------+ +---------+
|  App A  | |  App B  |
+---------+ +---------+
|Guest OS | |Guest OS |
+----+----+ +----+----+
     |           |
     +-----+-----+
           |
           v
       Hypervisor
           |
           v
        Hardware
```

## Containers

```text
+---------+ +---------+
|  App A  | |  App B  |
+---------+ +---------+
|Libraries| |Libraries|
+----+----+ +----+----+
     |           |
     +-----+-----+
           |
           v
    Container Runtime
           |
           v
      Linux Kernel
           |
           v
        Hardware
```

Containers are generally lighter than full virtual machines because they
share the host kernel rather than running a separate guest kernel for every
application environment.

## Docker

Docker is a widely used container platform and ecosystem.

A container image packages an application and the dependencies required for
its execution.

```text
Application
    +
Dependencies
    +
Configuration
      |
      v
Container Image
      |
      v
Running Container
```

## Kubernetes

Kubernetes is a container orchestration platform.

It manages containerized workloads across clusters of machines.

```text
Kubernetes Cluster
│
├── Control Plane
│
└── Worker Nodes
    │
    ├── Node A
    │   ├── Pod
    │   │   └── Container
    │   └── Pod
    │       └── Container
    │
    └── Node B
        └── Pod
            └── Container
```

Important terminology:

- **Container** — isolated application workload
- **Pod** — smallest deployable Kubernetes unit, containing one or more
  containers
- **Node** — machine participating in a Kubernetes cluster
- **Cluster** — collection of Kubernetes nodes
- **Control plane** — components responsible for managing cluster state

Older material may use the term **master node** where modern Kubernetes
documentation generally uses **control plane**.

Containers and serverless computing are not the same concept. Containers
may be used underneath serverless platforms, but serverless is a service
model that abstracts infrastructure management from application developers.

---

# Key Exam Associations

```text
Apache HTTPD   -> Web server
NGINX          -> Web server / reverse proxy

MySQL          -> Relational database
MariaDB        -> MySQL fork
PostgreSQL     -> Relational database

NFS            -> Unix/Linux file sharing
Samba          -> SMB / Windows interoperability
Netatalk       -> Apple file services

Thunderbird    -> Email client
Firefox        -> Web browser
GIMP           -> Image editing
Audacity       -> Audio editing
Blender        -> 3D graphics
LibreOffice    -> Office suite

dpkg           -> Low-level Debian package tool
apt-get        -> Debian/APT package management
rpm            -> Low-level RPM package tool
yum            -> Higher-level RPM package management
DNF            -> Modern Fedora/RHEL package manager

C              -> Systems programming / Linux kernel
Java           -> Bytecode / JVM
JavaScript     -> Web programming
PHP            -> Server-side web development
Perl           -> Scripting / text processing
Python         -> General-purpose programming / automation

root           -> Superuser / UID 0
SSH            -> Secure remote access
2FA            -> Two different authentication factors
Firewall       -> Network traffic filtering
UFW            -> Uncomplicated Firewall
Gufw           -> Graphical interface for UFW

HTTPS          -> HTTP protected by TLS
VPN            -> Protected network tunnel
Tor            -> Multi-relay privacy network

Public Cloud   -> Multiple customers
Private Cloud  -> One organization
Community      -> Organizations with common requirements
Hybrid Cloud   -> Combination of cloud environments

Host           -> Base system
Guest          -> Virtualized OS instance
Hypervisor     -> Manages virtual machines

Docker         -> Containers
Kubernetes     -> Container orchestration
Pod            -> Kubernetes deployable unit
```

---

# Module Summary

The Linux ecosystem extends far beyond the kernel itself.

Linux can provide desktop environments, servers, development platforms,
network services, cloud infrastructure, virtual machines, and container
platforms.

Important relationships from this module include:

```text
Linux
│
├── User Environment
│   ├── Desktop
│   ├── Terminal
│   └── Shell
│
├── Applications
│   ├── Desktop
│   └── Server
│
├── Software Management
│   ├── Packages
│   └── Repositories
│
├── Development
│   ├── Shell scripting
│   └── Programming languages
│
├── Security
│   ├── Authentication
│   ├── Updates
│   ├── Firewalls
│   └── Encryption
│
└── Infrastructure
    ├── Cloud Computing
    ├── Virtualization
    └── Containers
```

The most important practical distinction is that these layers solve
different problems:

```text
Shell
  -> command execution and automation

Package Manager
  -> software installation and maintenance

Firewall
  -> network traffic control

Encryption
  -> protection of data

Virtualization
  -> multiple virtual machines on physical resources

Containers
  -> isolated application environments sharing a kernel

Cloud Computing
  -> computing resources delivered as network-accessible services
```
