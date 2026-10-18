# Module 12 — Understanding Computer Hardware

Personal study notes for **Cisco Networking Academy / NDG Linux Essentials**, Chapter 12. These are original summaries, not a reproduction of the course material.

## 1. Exam Objectives

**LPI Linux Essentials — Objective 4.2: Understanding Computer Hardware**  
**Weight:** 2  
**Key knowledge area:** Familiarity with components used in desktop and server computers.

| Component or command | Purpose |
|---|---|
| Motherboard | Connects CPU, RAM, buses, and other components |
| CPU | Executes instructions and performs calculations |
| RAM / swap | Physical working memory / disk-backed swap space |
| PCI / USB | Buses used to connect devices |
| HDD / SSD | Persistent storage |
| MBR / GPT | Partition table formats |
| `/dev/sd*` | Linux block-device naming pattern for many disks |
| Drivers | Software enabling operating-system access to hardware |
| `arch`, `lscpu` | Identify architecture and CPU characteristics |
| `free` | Display memory and swap usage |
| `lspci`, `lsusb` | Inspect PCI and USB devices |
| `fdisk -l` | Inspect disk partition information |

## 2. Physical Computers and Virtual Machines (12.1)

Physical computers consist of interconnected hardware. Virtual machines expose simulated hardware to a guest operating system while ultimately relying on physical resources. Understanding components and their relationships supports installation, administration, security, and troubleshooting.

## 3. Motherboards and Processors (12.2–12.3)

A **motherboard** is the main system board, connecting the processor, RAM, expansion interfaces, and other devices. Some components use replaceable sockets or expansion slots; others are soldered in place.

The **CPU** executes code. A **multiprocessor** system has more than one physical processor, whereas a **multi-core** CPU has multiple processing cores on one processor chip. Logical CPUs may also reflect simultaneous multithreading.

| Architecture | Course-level distinction |
|---|---|
| `x86` | 32-bit processor architecture |
| `x86_64` | 64-bit architecture; can address more memory |
| `i386`, `i486`, `i586`, `i686` | Historical x86 generation names |

```bash
arch
lscpu
```

`arch` displays the machine architecture, such as `x86_64`. `lscpu` provides details such as `Architecture`, `CPU op-mode(s)`, `CPU(s)`, `Thread(s) per core`, `Core(s) per socket`, and `Socket(s)`. The number of logical CPUs is not necessarily the number of physical processors.

**Exam tip:** Distinguish 32-bit from 64-bit architectures and physical processors from processor cores.

## 4. RAM and Swap (12.4)

**RAM** temporarily holds running programs and data. **Swap space** uses persistent storage to hold memory pages when the operating system needs to free physical memory. Swap is generally slower than RAM.

```bash
free -m   # memory in MiB
free -g   # memory in GiB
free -h   # human-readable units
```

The course's example uses an older `free` output layout. Modern versions often include an `available` column and omit the historical `-/+ buffers/cache` line.

**Exam tip:** Swap is disk-backed, not stored inside the CPU.

## 5. Buses and Peripherals (12.5)

A **bus** connects computer components and enables communication. **PCI** is commonly used for internal controllers and expansion devices; **USB** commonly connects external peripherals.

```bash
lspci  # list PCI devices, such as video or network controllers
lsusb  # list USB devices, such as hubs or mice
```

A **hot-plug** device can be connected or disconnected while the computer is powered on; USB commonly supports this. **Cold-plug** describes connections that require the system to be powered off. Before physically removing USB storage, properly unmount its filesystem.

The course's virtual lab may not provide `lspci` or `lsusb`.

## 6. Hard Drives, Partitions, and Device Files (12.6)

A **disk** is a storage device; a **partition** is a logical division of that disk. A single disk can contain multiple partitions.

| Partition table | Main characteristics |
|---|---|
| MBR (Master Boot Record) | Older scheme with more restrictive size and partition-count limits |
| GPT (GUID Partition Table) | Newer scheme supporting larger disks and more partitions |

| Traditional MBR tools | GPT-oriented tools | Tools supporting both |
|---|---|---|
| `fdisk` | `gdisk` | `parted` |
| `cfdisk` | `cgdisk` | `gparted` |
| `sfdisk` | `sgdisk` | |

Modern versions of `fdisk`, `cfdisk`, and `sfdisk` can also work with GPT. The table above reflects the associations emphasized by the course.

### Linux device names

```text
/dev/sda    # disk
/dev/sda1   # first partition of that disk
/dev/sda2   # second partition
/dev/sdb    # another disk
/dev/hda    # historical naming for the first IDE disk
```

Not all modern drives use `/dev/sd*`: NVMe devices, for example, commonly use `/dev/nvme*` names.

### Safe inspection

```bash
ls /dev/sd*
sudo fdisk -l /dev/sda   # inspection only; may require privileges
lsblk                    # useful modern overview of disks and partitions
```

**Safety:** Partition creation, deletion, and resizing can destroy data. Do not use interactive partitioning tools to modify a disk unless you understand the consequences and have backups.

## 7. Solid State Disks (12.7)

A traditional **HDD** uses spinning platters and moving read/write heads. An **SSD** uses electronic memory and a controller, with no spinning disks. Compared with HDDs, SSDs generally offer faster access and boot times, lower power use, and less heat and vibration. Their cost per unit of capacity is often higher.

## 8. Optical Drives and Mounting (12.8)

Optical media include **CD**, **DVD**, and **Blu-ray**. Some media are read-only, while others support writing or rewriting. Removable filesystems may be mounted under `/media` or `/mnt`.

```bash
umount /media/usbthumb
```

The command is spelled `umount`, not `unmount`. Unmount removable storage before unplugging it to reduce the risk of data loss.

## 9. Drivers and Hardware Support (12.9)

A **driver** is software that allows the operating system to communicate with a device. Linux drivers may be compiled into the kernel, loaded as kernel modules, or supported by user-space software interacting with kernel interfaces. Compatibility should be checked against the intended Linux distribution, particularly for unusual or very new devices.

## 10. Video Devices and Power Supplies (12.10–12.11)

Video hardware provides output to monitors and requires compatible software support. Common connectors include **VGA** (analog), **DVI**, **HDMI**, and **DisplayPort**. Available display resolutions depend on the hardware and software combination. Many Linux servers are administered without a graphical desktop.

A **power supply unit (PSU)** converts **AC** input to **DC** outputs, including common rails such as **3.3 V**, **5 V**, and **12 V**. Poor power quality or a failing PSU can cause instability or hardware damage. Laptops can temporarily rely on their batteries when external power is interrupted.

## 11. Practical Lab — Read-only Hardware Report

The companion script [`code/hardware-report.sh`](code/hardware-report.sh) gathers information from the commands introduced in this chapter, with an additional `lsblk` summary for readable disk information.

```bash
cd modules/12-understanding-computer-hardware
chmod +x code/hardware-report.sh
./code/hardware-report.sh
./code/hardware-report.sh hardware-report.txt
```

The optional filename saves the report to a **new** file. The script refuses to overwrite an existing file. It reports unavailable commands instead of failing silently and does not use `sudo` or modify partitions.

Sample report sections:

```text
LINUX HARDWARE REPORT
===== System architecture (arch) =====
===== CPU information (lscpu) =====
===== Memory and swap (free -h) =====
===== Disks and partitions (lsblk) =====
===== PCI devices (lspci) =====
===== USB devices (lsusb) =====
===== Notes =====
```

Outputs vary with hardware, permissions, virtualization, and installed utilities. The script does not directly test PSU voltage or inspect video cable types.

## 12. Chapter Quiz Review

| # | Correct answer(s) | Key idea |
|---|---|---|
| 1 | True | 64-bit systems can address more memory than 32-bit systems |
| 2 | 1, 3, 4 | Swap is disk-backed and helps when physical RAM is low |
| 3 | PCI; USB | Common buses |
| 4 | Partition | Logical division of a disk |
| 5 | GPT; MBR | Partition-table formats |
| 6 | `/dev/hda` | Historical first IDE disk name |
| 7 | Less heat; low power consumption; faster boot | Common SSD advantages |
| 8 | Drivers | Software connecting hardware and the OS |
| 9 | `cfdisk`; `fdisk`; `sfdisk` | Course's traditional MBR tool family |
| 10 | `sgdisk`; `cgdisk`; `gdisk` | GPT-oriented tool family |

## 13. Quick Reference

```bash
arch                      # architecture
lscpu                     # CPU details
free -h                   # RAM and swap
lspci                     # PCI inventory
lsusb                     # USB inventory
ls /dev/sd*               # matching device files
lsblk                     # disks and partitions
sudo fdisk -l /dev/sda     # inspect disk partition table
umount /media/usbthumb    # unmount removable media
```

## References and Attribution

- [Cisco Networking Academy](https://www.netacad.com/)
- [Network Development Group](https://www.netdevgroup.com/)
- [LPI Linux Essentials](https://www.lpi.org/our-certifications/linux-essentials-overview/)

This repository contains independently written personal notes and examples. Official course content remains the property of its respective rights holders; this is not an official course publication.
