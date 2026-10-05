# Module 4 — Open Source Software and Licensing

Study notes for the Cisco Networking Academy **Linux Essentials** course, with additional context for the **LPI Linux Essentials** certification.

## Exam Objective

### 1.3 Open Source Software and Licensing

**Weight:** 1

Key knowledge areas:

- Open source philosophy
- Open source licensing
- Free Software Foundation (FSF)
- Open Source Initiative (OSI)
- Open source software in business

---

## 1. Open Source Philosophy

Software is written as **source code**, which contains human-readable instructions written in a programming language.

For a traditionally compiled program:

```text
Source Code
    |
    | Compiler
    v
Machine Code / Binary
    |
    v
Execution
```

For interpreted languages, a simplified model is:

```text
Source / Script
      |
      v
Interpreter / Runtime
      |
      v
Execution
```

Examples of languages commonly associated with interpreted execution include Python, Perl, and shell scripting languages.

Modern language implementations may combine interpretation, bytecode compilation, Just-In-Time (JIT) compilation, and other techniques.

### Open Source vs. Closed Source

Closed-source software generally distributes executable binaries while keeping the source code unavailable to users.

```text
Closed Source
|
+-- Binary distributed
+-- Source generally unavailable
+-- Modification generally restricted
`-- Rights defined by proprietary license
```

Open source software makes source code available under a license that grants rights to use, study, modify, and redistribute the software subject to the license conditions.

```text
Open Source
|
+-- Source code available
+-- Code can be studied
+-- Code can be modified
`-- Redistribution permitted under license terms
```

Having access to source code alone does **not** necessarily make software open source. The license must grant the required rights.

### Price Is Not the Definition

Several concepts must not be confused:

```text
Free of charge != Free Software != Open Source
```

**Shareware**, for example, may be distributed at no cost or for evaluation while remaining closed source.

Similarly, open source software may be sold commercially.

### Open Source and Security

Source availability makes independent inspection possible.

```text
Open Source
     |
     v
Enables Inspection
     |
     X
Does Not Guarantee Security
```

Open source software is not automatically secure. Security still depends on implementation quality, maintenance, auditing, deployment, configuration, and other factors.

---

## 2. UNIX, BSD, Linux, and Portability

Linux belongs to a broader Unix-like computing tradition.

A simplified historical timeline is:

```text
1969
 |
 +-- UNIX created
 |
1973
 +-- UNIX rewritten largely in C
 |
1980s
 +-- BSD and Unix development
 |    `-- Important TCP/IP development and adoption
 |
1991
 +-- Linux development begins
 |
Today
 `-- Large Unix-like ecosystem
```

### BSD

**BSD** stands for **Berkeley Software Distribution**.

BSD is important in two related contexts:

1. Unix operating system history
2. The BSD family of permissive software licenses

These concepts are related historically but should not be treated as identical.

### Portability

**Porting** means adapting software so that it can run on another operating system or platform.

Standard interfaces reduce the work required to port applications.

```text
Application
     |
     v
Standardized API
     |
     v
Operating System
```

### POSIX

**POSIX** stands for **Portable Operating System Interface**.

POSIX is a family of standards describing interfaces and behavior intended to improve compatibility among Unix-like operating systems.

```text
IEEE
 |
 `-- Standards organization
       |
       `-- POSIX / IEEE 1003 family
              |
              `-- Portability and interoperability
```

IEEE is an organization; POSIX is a family of standards.

---

## 3. Ownership, Price, and Licensing

When software is distributed, three separate concepts should be considered:

```text
Software
|
+-- Ownership
|   `-- Who owns the copyright?
|
+-- Money Transfer
|   `-- How does payment work?
|
`-- Licensing
    `-- What is the recipient allowed to do?
```

Buying a software license normally does not mean acquiring ownership of the software copyright.

```text
Buying a License
       !=
Owning the Copyright
```

A license defines permissions and obligations involving activities such as:

- Running the software
- Copying it
- Modifying it
- Redistributing it
- Redistributing modified versions
- Providing source code
- Preserving copyright and license notices

### Copyright and Open Source

Open source generally does not mean abandoning copyright.

Instead:

```text
Copyright Holder
       |
       | grants permissions
       v
     License
       |
       +-- Use
       +-- Copy
       +-- Modify
       `-- Redistribute
```

Therefore:

```text
Open Source != Public Domain
GPL         != Public Domain
```

---

## 4. Free and Open Source Software

**FOSS** commonly stands for:

> Free and Open Source Software

The word **free** refers primarily to freedom rather than price.

Another term is **FLOSS**:

> Free/Libre and Open Source Software

The word **Libre** helps remove the ambiguity of the English word "free."

```text
"Free"
|
+-- Free of charge
|   `-- Price
|
`-- Freedom
    `-- Libre
```

FOSS and FLOSS are umbrella terms covering the highly overlapping Free Software and Open Source communities.

---

## 5. Free Software Foundation

The **Free Software Foundation (FSF)** was founded by **Richard Stallman in 1985**.

Richard Stallman is also closely associated with the **GNU Project**, started in 1983.

```text
Richard Stallman
      |
      +-- GNU Project (1983)
      |
      `-- Free Software Foundation (1985)
                    |
                    +-- Free Software
                    +-- Copyleft
                    `-- GNU licenses
```

### Free Software

For the FSF, "free" refers to user freedom rather than zero price.

The four essential software freedoms are conventionally numbered from 0 through 3:

```text
Freedom 0
`-- Run the program for any purpose

Freedom 1
`-- Study and modify the program

Freedom 2
`-- Redistribute copies

Freedom 3
`-- Distribute modified versions
```

Access to source code is necessary for the freedoms involving studying and modifying the program.

### Free Software Can Be Commercial

Free Software does not mean that software cannot be sold.

```text
Free Software
     |
     `-- Freedom
           !=
        Zero Price
```

Commercial use and selling copies can be compatible with Free Software licenses.

---

## 6. Copyleft

**Copyleft** is a licensing strategy that uses copyright to preserve software freedoms when covered software is redistributed.

```text
Copyright
    |
    v
Copyright Holder
    |
    | grants freedoms
    v
Copyleft License
    |
    v
Recipients Receive Freedoms
    |
    v
Redistributed Covered Works
Preserve Applicable Freedoms
```

Copyleft does not eliminate copyright.

```text
Copyright
    +
License Conditions
    =
Copyleft
```

### Modification vs. Distribution

A common misconception is that every modification to GPL software must immediately be published.

Private modification does not normally create an automatic obligation to publish the changes.

```text
GPL Software
     |
     v
   Modify
     |
     v
Private/Internal Use
     |
     `-- No automatic publication requirement
```

Distribution is where important GPL obligations normally arise:

```text
GPL Software
     |
     v
   Modify
     |
     v
Redistribute
     |
     v
Copyleft Obligations Apply
```

---

## 7. GNU General Public License

The **GNU General Public License (GPL)** is a major family of copyleft licenses associated with GNU and the FSF.

Important versions include:

- GPLv2
- GPLv3

```text
FSF
 |
 `-- GNU
      |
      `-- GPL
           |
           `-- Copyleft
```

### Linux Kernel

The Linux kernel is primarily distributed under **GPLv2-only**.

```text
Linux Kernel
     |
     `-- GPLv2
          |
          `-- Copyleft
```

The kernel did not migrate to GPLv3 when GPLv3 was introduced.

### LGPL

**LGPL** stands for **GNU Lesser General Public License**.

It is commonly associated with software libraries and applies a more limited form of copyleft than the GPL in important linking scenarios.

```text
GNU Licenses
|
+-- GPL
|   `-- Strong copyleft
|
`-- LGPL
    `-- More limited copyleft
        for common library/linking scenarios
```

The LGPL can allow proprietary applications to link to an LGPL library under specified conditions without requiring the entire application to become GPL software.

The LGPL still has source-code and redistribution obligations for covered LGPL components.

---

## 8. Tivoization and GPLv3

**Tivoization** describes a situation where GPL software can be modified at the source level, but hardware restrictions prevent users from running their modified versions on a device.

The historical TiVo example can be represented as:

```text
Linux / GPLv2
      |
      v
Modified for Device
      |
      +-- Required source provided
      |
      `-- Hardware rejects user-modified binaries
```

GPLv3 introduced provisions intended to address this type of restriction for certain devices.

The Linux kernel remains under GPLv2 rather than GPLv3.

---

## 9. Free Software Foundation Activities

In addition to maintaining GNU licenses and promoting Free Software, the FSF has historically advocated on issues including:

- Software patents
- Digital Rights Management (DRM)
- Software standards
- User control over computing

**DRM** stands for **Digital Rights Management**.

```text
Digital Content
      |
      v
     DRM
      |
      +-- Control copying
      +-- Control playback
      +-- Restrict devices
      `-- Enforce usage rules
```

---

## 10. Open Source Initiative

The **Open Source Initiative (OSI)** was founded in **1998**.

Bruce Perens and Eric S. Raymond were major figures in its creation.

```text
Open Source Initiative
        |
        +-- Founded: 1998
        +-- Bruce Perens
        +-- Eric S. Raymond
        |
        `-- Open Source Definition
```

The FSF and OSI overlap significantly but emphasize different aspects of software licensing.

```text
FSF                         OSI
 |                           |
 `-- Free Software           `-- Open Source
      |                           |
      `-- User freedom            `-- Open Source Definition
          as central principle        and license criteria
```

---

## 11. Open Source Definition

The OSI maintains the **Open Source Definition (OSD)** and evaluates licenses against its requirements.

```text
OSI
 |
 v
Open Source Definition
 |
 v
License Evaluation
 |
 +-- Meets requirements --> OSI-approved
 |
 `-- Does not meet them --> Not OSI-approved
```

Important principles include:

- Free redistribution
- Availability of source code
- Permission for derived works
- No discrimination against persons or groups
- No discrimination against fields of endeavor

For example, a software license that prohibits commercial use does not satisfy the OSI Open Source Definition.

```text
Open Source
|
+-- Commercial use permitted
+-- Modification permitted
+-- Redistribution permitted
`-- No discrimination by field of endeavor
```

---

## 12. Copyleft vs. Permissive Licenses

Open source licenses can use different approaches.

Two important categories are:

```text
              Open Source Licenses
                      |
          +-----------+-----------+
          |                       |
          v                       v
       Copyleft                Permissive
          |                       |
          v                       v
         GPL                 BSD / MIT
```

### Copyleft

Copyleft licenses impose conditions intended to preserve specified freedoms when covered derivative software is redistributed.

Example:

- GPL

### Permissive

Permissive licenses generally impose fewer downstream licensing restrictions.

Examples:

- BSD
- MIT

Permissively licensed code can generally be incorporated into proprietary products as long as the license conditions are followed.

```text
Permissive Source Code
        |
        v
Modification / Integration
        |
        v
Proprietary Product
        |
        `-- Possible while respecting
            original license conditions
```

Permissive does **not** mean "no conditions."

---

## 13. BSD Licenses

**BSD** stands for **Berkeley Software Distribution**.

Modern BSD licenses are well-known examples of permissive licenses.

Important variants include:

- BSD 2-Clause
- BSD 3-Clause

Typical requirements include preserving copyright and license notices.

The BSD 3-Clause license also includes a non-endorsement condition.

```text
BSD
|
+-- Use
+-- Modify
+-- Redistribute source
+-- Redistribute binaries
|
`-- Follow license conditions
```

### Historical Advertising Clause

An older BSD license contained an advertising acknowledgment requirement.

As other projects reused the license and added their own acknowledgments, the requirement became increasingly cumbersome.

Modern BSD 2-Clause and BSD 3-Clause licenses do not contain this historical advertising clause.

---

## 14. GPL and BSD Are Both Open Source

Copyleft and Open Source are not opposites.

```text
               Open Source
                    |
          +---------+---------+
          |                   |
          v                   v
       Copyleft            Permissive
          |                   |
         GPL              BSD / MIT
```

GPL software is both Free Software and Open Source.

Many permissive licenses, including modern BSD and MIT licenses, are also recognized as Free Software licenses.

The main distinction is the presence or absence of copyleft requirements.

---

## 15. Creative Commons

Software licenses such as GPL, BSD, MIT, and Apache are designed primarily for software.

**Creative Commons (CC)** provides standardized licensing tools primarily for creative works such as:

- Text
- Images
- Music
- Video
- Educational materials

```text
Software                     Creative Works
   |                               |
   +-- GPL                         +-- Text
   +-- BSD                         +-- Images
   +-- MIT                         +-- Music
   `-- Apache                      +-- Video
                                   |
                                   `-- Creative Commons
```

Creative Commons generally recommends using software-specific licenses for software.

---

## 16. Creative Commons Conditions

Four abbreviations are particularly important:

```text
BY = Attribution
SA = ShareAlike
NC = NonCommercial
ND = NoDerivatives
```

### Attribution — BY

Credit must be given according to the license terms.

```text
BY
`-- Give appropriate credit
```

### ShareAlike — SA

Adapted works that are shared must use the required same or compatible licensing terms.

```text
Original
   |
   v
Adapt
   |
   v
Redistribute
   |
   v
ShareAlike Terms
```

ShareAlike is conceptually similar to copyleft.

### NonCommercial — NC

The license does not grant permission for commercial use.

```text
NC
|
+-- Non-commercial use --> Permitted
`-- Commercial use     --> Not granted
```

A software license prohibiting commercial use would not satisfy the OSI Open Source Definition.

### NoDerivatives — ND

The license permits sharing the work under its terms but restricts distribution of adaptations.

```text
ND
|
+-- Share original work --> Permitted
`-- Share adaptation    --> Restricted
```

---

## 17. Main Creative Commons Licenses

The six main Creative Commons licenses are:

| License | Conditions |
|---|---|
| CC BY | Attribution |
| CC BY-SA | Attribution + ShareAlike |
| CC BY-ND | Attribution + NoDerivatives |
| CC BY-NC | Attribution + NonCommercial |
| CC BY-NC-SA | Attribution + NonCommercial + ShareAlike |
| CC BY-NC-ND | Attribution + NonCommercial + NoDerivatives |

A useful map is:

```text
Creative Commons
|
`-- BY
    |
    +-- CC BY
    +-- CC BY-SA
    +-- CC BY-ND
    |
    `-- NC
        +-- CC BY-NC
        +-- CC BY-NC-SA
        `-- CC BY-NC-ND
```

---

## 18. CC0 and Public Domain

**CC0** is a Creative Commons public-domain dedication tool.

It allows copyright holders to waive copyright and related rights to the greatest extent legally possible.

```text
Copyrighted Work
      |
      v
     CC0
      |
      v
As Close to Public Domain
as Legally Possible
```

CC0 is separate from the six main Creative Commons licenses.

### Public Domain

A work may enter the public domain for different reasons depending on the applicable jurisdiction, including expiration of copyright protection.

Public domain should not be confused with open licensing:

```text
Open License                    Public Domain
     |                               |
Copyright remains               No applicable
     |                          exclusive copyright
     v                            restrictions
Permissions granted
through license
```

---

## 19. Open Source Business Models

Open source software can be used commercially.

```text
Open Source != Non-commercial
Open Source != No revenue
Open Source != Zero price
```

Companies can build businesses around open source software in many ways.

```text
Open Source Business Models
|
+-- Support
+-- Consulting
+-- Training and certification
+-- Maintenance
+-- Enterprise services
+-- Hosted services
+-- Hardware
+-- Mixed open/proprietary products
`-- Sponsored development
```

### Support and Services

A company can provide software under an open source license while charging for services such as:

- Technical support
- Bug fixing
- Deployment
- Integration
- Consulting
- Training
- Maintenance
- Enterprise service agreements

```text
Open Source Software
        |
        +-- Support
        +-- Maintenance
        +-- Consulting
        `-- Training
              |
              v
            Revenue
```

### Red Hat

Red Hat is a major example of a commercial business built around Linux and open source enterprise technologies.

Its business has included enterprise software, support, maintenance, certification, and related services.

Red Hat has been part of IBM since 2019.

### Canonical

Canonical develops Ubuntu and provides commercial products and services around Ubuntu and related infrastructure technologies.

This demonstrates that freely available source code and commercial services can coexist.

---

## 20. Hardware and Embedded Systems

Companies may sell hardware that incorporates open source software.

```text
Commercial Device
       |
       +-- Hardware
       |
       `-- Software
            |
            +-- Open Source Components
            `-- Proprietary Components
```

Linux is widely used in embedded systems and appliances.

Examples include:

- Network appliances
- Routers
- Cameras
- Entertainment devices
- Industrial systems
- Consumer electronics

Using GPL software in a commercial product is permitted as long as the applicable license obligations are followed.

---

## 21. Commercial Development of Open Source

Open source development is not limited to unpaid volunteers.

Companies frequently employ developers specifically to work on open source projects.

```text
Company
   |
   v
Paid Developers
   |
   v
Open Source Project
   |
   v
Improved Technology
   |
   v
Company Benefits
```

A company may fund a project because the technology is strategically important to its products or infrastructure.

```text
Company Uses Project
       |
       v
Project Is Important
       |
       v
Company Funds Development
       |
       v
Project Improves
       |
       `----------------+
                        |
                        v
                 Company Benefits
```

---

## 22. Open Source and Cloud Computing

Open source software is widely used in cloud infrastructure.

Examples of important open source technologies in modern infrastructure include Linux, container technologies, orchestration systems, databases, and infrastructure tools.

Another commercial model is providing hosted or managed services:

```text
Open Source Software
        |
        v
Company Operates It
        |
        v
Hosted / Managed Service
        |
        v
Customer Pays for Service
```

The customer may be paying for infrastructure, administration, availability, backups, security operations, support, and other services rather than simply paying for access to source code.

---

## 23. Key Organizations and Terms

```text
Open Source / Free Software Ecosystem
|
+-- FSF
|   |
|   +-- Free Software
|   +-- Richard Stallman
|   +-- Copyleft
|   +-- GPL
|   `-- LGPL
|
+-- OSI
|   |
|   +-- Open Source
|   +-- Open Source Definition
|   `-- OSI-approved licenses
|
+-- Licensing
|   |
|   +-- Copyleft
|   |   `-- GPL
|   |
|   `-- Permissive
|       +-- BSD
|       `-- MIT
|
+-- Creative Commons
|   |
|   +-- BY
|   +-- SA
|   +-- NC
|   +-- ND
|   `-- CC0
|
`-- Business
    |
    +-- Support
    +-- Services
    +-- Hardware
    +-- Hosted services
    `-- Sponsored development
```

---

## 24. Important Distinctions

### Free Software vs. Free of Charge

```text
Free Software
     =
Freedom
     !=
Zero Price
```

### Open Source vs. Source Available

```text
Source Visible
     !=
Automatically Open Source
```

The license must provide the required freedoms.

### Open Source vs. Public Domain

```text
Open Source
|
`-- Copyright generally remains
    and permissions come from license

Public Domain
|
`-- No applicable exclusive copyright
    restrictions in the usual sense
```

### Copyleft vs. Permissive

```text
Copyleft                    Permissive
   |                            |
   +-- GPL                      +-- BSD
   |                            +-- MIT
   |                            |
   `-- Downstream               `-- Fewer downstream
       copyleft obligations         licensing restrictions
```

### FSF vs. OSI

```text
FSF
`-- Emphasizes software freedom

OSI
`-- Defines Open Source criteria
```

The categories overlap substantially.

---

## 25. Exam Quick Reference

```text
Richard Stallman
`-- Free Software Foundation

FSF
`-- Free Software / GNU licenses

OSI
`-- Open Source Definition

Linux Kernel
`-- GPLv2

GPL
`-- Copyleft

LGPL
`-- Lesser / more limited copyleft,
    commonly associated with libraries

BSD / MIT
`-- Permissive licenses

FOSS
`-- Free and Open Source Software

FLOSS
`-- Free/Libre and Open Source Software

BY
`-- Attribution

SA
`-- ShareAlike

NC
`-- NonCommercial

ND
`-- NoDerivatives

CC0
`-- Public-domain dedication tool
```

---

## 26. Module Review Questions

### Linux Source Code

Linux source code is publicly available rather than restricted to a specific organization or class of researchers.

### Richard Stallman

Richard Stallman is associated with:

```text
GNU Project
     +
Free Software Foundation
```

### Copyleft

When covered software is modified and redistributed, copyleft licenses impose conditions intended to preserve the applicable software freedoms and source-code rights.

### FSF License

GPLv3 is part of the GNU GPL family associated with the FSF.

### Linux License

```text
Linux Kernel -> GPLv2
```

### Public Domain

Public-domain works are not subject to the usual exclusive copyright restrictions. The exact legal mechanisms vary by jurisdiction.

### CC BY-ND

```text
BY -> Attribution required
ND -> Distribution of adaptations restricted
```

The absence of `NC` means commercial use is not automatically prohibited by this license.

### Open Source Business

Revenue can come from activities such as:

```text
Open Source
|
+-- Hardware
+-- Bug fixing / support
+-- Consulting
`-- Other commercial services
```

### GPL vs. LGPL

GPL generally applies stronger copyleft requirements, while LGPL provides more limited copyleft rules useful for libraries and linking scenarios.

### Permissive Licenses

```text
Permissive
|
+-- No copyleft provision
+-- Examples: BSD, MIT
`-- Can generally be incorporated into
    proprietary software under license terms
```

---

## 27. Final Summary

Open source is fundamentally a **licensing model**, not a pricing model.

```text
                    Software
                       |
             +---------+---------+
             |                   |
             v                   v
        Proprietary          Open Source
                                 |
                    +------------+------------+
                    |                         |
                    v                         v
                 Copyleft                 Permissive
                    |                         |
                   GPL                    BSD / MIT
                    |
                    v
            Preserve Freedoms
            on Redistribution
```

The Free Software Foundation emphasizes user freedom and promotes licenses such as the GPL. The Open Source Initiative maintains the Open Source Definition and approves licenses that meet its criteria.

Creative Commons provides licensing tools primarily for creative works rather than software.

Open source software can be sold, supported commercially, incorporated into hardware, operated as a service, and developed by paid employees.

The central principle to remember is:

```text
Open Source
     |
     +-- Source Code
     +-- License
     +-- Rights
     +-- Obligations
     |
     `-- Commercial Use Is Possible
```
