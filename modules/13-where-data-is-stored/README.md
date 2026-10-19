# Module 13 — Where Data Is Stored

Personal study notes for **Cisco Networking Academy / NDG Linux Essentials**, Chapter 13. Original explanatory notes, not a reproduction of the course material.

## 1. Exam Objectives

**LPI Linux Essentials — Objective 4.3: Where Data Is Stored**  
**Weight:** 3  
**Scope:** Where different kinds of information are stored on Linux systems.

**Key knowledge areas:** programs and configuration, processes, memory addresses, system messaging, and logging.

| Tool or location | Purpose |
|---|---|
| `/proc` | Virtual filesystem exposing processes and kernel state |
| `/sys` | Virtual filesystem exposing devices and kernel interfaces |
| `/dev` | Special device files |
| `/etc` | System-wide configuration |
| `/var/log` | Common location for system logs |
| `ps`, `pstree`, `top` | Process snapshots, hierarchy, and live monitoring |
| `free` | RAM and swap statistics |
| `dmesg` | Kernel ring-buffer messages |
| `journalctl` | Read systemd journal entries |

## 2. GNU/Linux, the Kernel, and Virtual Filesystems (13.1–13.2)

The Linux **kernel** manages processes, memory, networking, devices, and system calls. GNU tools and other userspace software provide commands and applications around the kernel. Programs request kernel services through system calls.

`/proc` and `/sys` are **pseudo-filesystems**: their contents are exposed dynamically by the kernel rather than stored as ordinary disk files. `/dev` contains special files representing devices.

```bash
ls /proc
cat /proc/cmdline
cat /proc/meminfo
cat /proc/modules
ls /sys
ls /dev
```

| `/proc` path | Meaning |
|---|---|
| `/proc/<PID>/` | Information about a currently existing process |
| `/proc/cmdline` | Kernel boot arguments |
| `/proc/meminfo` | Detailed memory statistics |
| `/proc/modules` | Loaded kernel modules |
| `/proc/loadavg` | Load averages and task counts |
| `/proc/sys/kernel/pid_max` | Maximum configurable PID range |

Some `/proc/sys` entries can change kernel behavior. For example:

```bash
cat /proc/sys/net/ipv4/icmp_echo_ignore_all
```

`0` means ICMP Echo requests are not globally ignored; `1` means they are ignored. Writing to this interface requires appropriate privileges and typically changes runtime state only. The course introduces `/etc/sysctl.conf` for persistent settings; distributions may also use `/etc/sysctl.d/*.conf`. **Do not change networking parameters merely to complete the reading exercise.**

## 3. Process Hierarchy and Identification (13.2.1)

A process has a **PID**; its parent's identifier is its **PPID**. The init system has **PID 1**. On many current Linux distributions, PID 1 is `systemd`; older systems commonly used System V `init`. Child processes can create further children.

```bash
ps -p 1 -f
ls /proc/1
pstree
cat /proc/sys/kernel/pid_max
```

Example hierarchy:

```text
init/systemd (PID 1)
└── login
    └── bash
        └── pstree
```

After PID values reach the configured limit, the kernel can reuse available values. PIDs are not permanent identifiers for programs across restarts.

## 4. Process Snapshots with `ps` (13.2.2)

`ps` prints a snapshot at execution time. By default, it usually displays processes associated with the current terminal; `ps` itself may appear in the result.

```bash
ps
ps --forest
ps aux | head
ps -ef | head
ps -ef | grep firefox
ps -u root
ps aux | less
```

| Column | Meaning |
|---|---|
| `PID` | Process ID |
| `PPID` | Parent process ID (notably in `ps -ef`) |
| `TTY` | Controlling terminal, if any |
| `%CPU` | CPU usage statistic |
| `%MEM` | Memory usage percentage |
| `TIME` | Accumulated CPU time |
| `COMMAND` / `CMD` | Command or executable |

`ps aux` uses BSD-style options, while `ps -ef` uses UNIX-style options. `head`, `grep`, and `less` help handle long output. A `grep` pipeline may also show the `grep` process itself.

## 5. Live Monitoring with `top` (13.2.3)

`top` refreshes CPU, memory, process, and load information periodically.

```bash
top
uptime
cat /proc/loadavg
```

| Interactive key | Action |
|---|---|
| `q` | Quit |
| `h` or `?` | Help |
| `k` | Send a signal to a selected PID |
| `r` | Renice a selected PID |

`SIGKILL` (signal 9) forcibly terminates a process; it does not allow normal cleanup. Nice values usually range from **-20** (higher scheduling priority) to **19** (lower scheduling priority). Raising priority generally requires privileges.

### Load averages

The three values report averages over **1, 5, and 15 minutes**, in that order.

```text
0.12 0.46 0.25 1/254 3052
```

In `/proc/loadavg`, the fourth field describes runnable scheduling entities versus the total; the fifth is the most recently allocated PID. A load average of `1.0` is **not** universally full system load: CPU capacity depends on the number of available cores. Linux load average also includes tasks waiting in uninterruptible sleep, so it is not identical to CPU utilization.

## 6. Memory Management and Inspection (13.3–13.3.1)

**Virtual addressing** allows each process to work with its own virtual address space. The kernel maps virtual memory to physical memory and enforces isolation. **User space** runs ordinary applications; **kernel space** runs privileged kernel code. Applications access kernel services through **system calls**.

**Swap** is disk-backed storage that can hold some memory pages. It is slower than RAM and is not the same concept as virtual addressing.

```bash
free
free -m
free -g
free -h
free -s 10   # Stop with Ctrl+C
cat /proc/meminfo
```

| Field | Interpretation |
|---|---|
| `total` | Total usable memory |
| `used` | Memory currently used according to the tool's accounting |
| `free` | Completely unused memory |
| `buff/cache` | Buffers and cache, much of which may be reclaimable |
| `available` | Estimate of memory available for new applications without swapping |
| `Swap` | Configured and used swap space |

Modern `free` versions normally report KiB by default, not raw bytes. The older course example with `-/+ buffers/cache` reflects an earlier output format. Very low available RAM and swap may lead to out-of-memory termination of processes.

## 7. Logging and Log Rotation (13.4)

Logs record kernel, service, authentication, and application events. They support troubleshooting and auditing.

| Service | Role |
|---|---|
| `syslogd` | Traditional syslog daemon |
| `klogd` | Traditional kernel message daemon |
| `rsyslogd` | More modern syslog implementation |
| `systemd-journald` | Journal service on systemd-based distributions |

`syslog` is also used as a general term for system logging. Different mechanisms may coexist.

| Common path | Typical content |
|---|---|
| `/var/log/boot.log` | Boot/service startup messages |
| `/var/log/cron` | Scheduled task logs |
| `/var/log/dmesg` | Saved kernel boot messages, where configured |
| `/var/log/maillog` | Mail service messages |
| `/var/log/messages` or `/var/log/syslog` | General system messages |
| `/var/log/secure` | Authentication/security events on some distributions |
| `/var/log/journal/` | Persistent systemd journal files, when enabled |
| `/var/log/Xorg.0.log` | X server messages, where applicable |

```bash
ls /var/log
journalctl
journalctl -b
file /var/log/wtmp
last
# lastb may require administrator privileges
```

Text logs can be read with `less` or `cat`, subject to permissions. Binary records such as `wtmp` and `btmp` need specialized readers (`last` and `lastb`). Journal files are generally binary, so use `journalctl` rather than `cat`.

**Log rotation** archives or renames older log files and starts new ones, commonly using numeric or date suffixes. Logs may be compressed or removed according to retention rules.

## 8. Kernel Messages with `dmesg` (13.5)

The kernel ring buffer contains kernel-generated messages, including device detection and driver events.

```bash
dmesg
dmesg | less
dmesg | grep -i usb
```

`grep -i` matches case-insensitively. Some distributions restrict `dmesg` to privileged users. The ring buffer has limited capacity and old messages can be overwritten; it is not a guaranteed permanent log.

**Exam distinction:** `dmesg` reads kernel messages; `journalctl` reads the systemd journal; `/var/log` holds many traditional log files.

## 9. Filesystem Hierarchy Standard (13.6)

The **Filesystem Hierarchy Standard (FHS)** gives Linux distributions guidelines for arranging system files. Directories may be classified as **shareable/not shareable** and **static/variable**.

| Category | Not shareable | Shareable |
|---|---|---|
| Variable | `/var/lock` | `/var/mail` |
| Static | `/etc` | `/opt` |

### Common top-level directories

| Path | Purpose |
|---|---|
| `/` | Root of the entire filesystem tree |
| `/bin` | Essential user commands |
| `/boot` | Bootloader and kernel-related boot files |
| `/dev` | Device nodes and special files |
| `/etc` | Host-specific configuration |
| `/home` | Regular user home directories |
| `/lib`, `/lib64` | Libraries needed by executables |
| `/media` | Removable media mounts |
| `/mnt` | Temporary manual mounts |
| `/opt` | Optional third-party software |
| `/proc` | Process/kernel pseudo-filesystem |
| `/root` | Home of the root account; **not** filesystem root |
| `/sbin` | Traditionally system administration commands |
| `/srv` | Data served by site-specific services |
| `/sys` | Hardware/kernel pseudo-filesystem |
| `/tmp` | Temporary files |
| `/usr` | Applications and shareable resources |
| `/var` | Variable data such as logs, cache, and spool files |

The course highlights four directory hierarchies: `/`, `/usr`, `/usr/local`, and `/var`. Some modern distributions merge `/bin` and `/sbin` into `/usr` through symbolic links; the conceptual FHS roles remain useful for the exam.

## 10. Programs, Configuration, and Libraries (13.6.1)

| Category | Typical locations |
|---|---|
| User commands | `/bin`, `/usr/bin`, `/usr/local/bin` |
| Administration commands | `/sbin`, `/usr/sbin`, `/usr/local/sbin` |
| Optional applications | `/opt/application/` |
| Distribution-independent local installs | `/usr/local/` |
| Shared application data | `/usr/share`, `/var/lib` |
| Documentation | `/usr/share/doc`, `/usr/share/man`, `/usr/share/info` |
| System-wide configuration | `/etc` |
| User-specific configuration | Hidden files or directories under `$HOME` |
| Libraries | `/lib`, `/lib64`, `/usr/lib`, `/usr/local/lib` |
| Variable data | `/var/log`, `/var/cache`, `/var/spool`, `/var/tmp` |

Shared libraries frequently have `.so` filenames (*shared objects*). Different library versions or CPU architectures may require distinct files.

```bash
echo "$PATH"
dpkg -L bash     # Debian-derived systems, when package is installed
rpm -ql bash    # RPM-based systems, when package is installed
```

The `PATH` variable lists directories searched for commands. A program outside those directories may require an explicit path. Package listing commands show which files belong to installed packages.

**Disk-space warning:** rapid growth under `/var` can exhaust a filesystem, particularly if `/var` shares the root filesystem.

## 11. Practice — Read-Only System Information Report

The companion script `code/system-information-report.sh` collects a short report of processes, CPU load, memory, filesystem locations, and available logging facilities. **It does not change system settings or kill processes**.

```bash
chmod +x code/system-information-report.sh
./code/system-information-report.sh
./code/system-information-report.sh > system-report.txt
```

The report depends on available commands and permissions. Review its contents before sharing: process listings, hostnames, and log-related information can reveal details about your environment. Avoid committing `system-report.txt` to a public repository.

## 12. Common Exam Traps

1. **`/` vs. `/root`:** `/` is the filesystem root; `/root` is the root user's home directory.
2. **`/proc` vs. `/sys` vs. `/dev`:** process/kernel data, device/kernel interfaces, and special device files, respectively.
3. **`ps` vs. `top`:** one-time process snapshot vs. updating monitor.
4. **PID vs. PPID:** process ID vs. parent process ID; the init process is PID **1**.
5. **Load average `1.0`:** not automatically full load on multicore systems.
6. **`free`:** memory statistics, not disk or CPU utilization.
7. **`/proc/sys` vs. `/etc/sysctl.conf`:** runtime kernel parameters vs. persistent configuration.
8. **`journald` vs. `journalctl`:** logging service vs. log-reading command.
9. **`/var`:** variable data; logs can consume substantial storage.
10. **Binary logs:** use `journalctl`, `last`, or `lastb` instead of assuming all logs are plain text.

## 13. Chapter Quiz Review

| # | Topic | Correct answer | Explanation |
|---|---|---|---|
| 1 | `dmesg` displays kernel messages | **True** | Reads messages from the kernel ring buffer. |
| 2 | Hardware-related pseudo-filesystems (choose two) | **`/proc`, `/sys`** | Expose kernel, process, and device information. |
| 3 | Init process PID | **1** | The system's init process occupies PID 1. |
| 4 | `top` load-average periods (choose three) | **1, 5, 15 minutes** | Standard load-average intervals. |
| 5 | `free` statistics | **Memory usage** | Displays RAM and swap statistics. |
| 6 | Load average 1.0 always means fully loaded | **False** | Depends on core count and workload. |
| 7 | Persistent `/proc/sys` configuration | **`/etc/sysctl.conf`** | Traditional persistent sysctl configuration file. |
| 8 | `/var` holds changing files | **True** | Stores variable data. |
| 9 | Logging daemon on systemd systems | **`journald`** | Systemd's journal service. |
| 10 | Root of filesystem | **`/`** | The top of the Linux directory hierarchy. |

## 14. Quick Reference

| Task | Command |
|---|---|
| Inspect kernel command line | `cat /proc/cmdline` |
| Inspect kernel modules | `cat /proc/modules` |
| Inspect PID 1 | `ps -p 1 -f` |
| Display process tree | `pstree` |
| List processes | `ps aux` or `ps -ef` |
| Filter processes | `ps -ef \| grep name` |
| Monitor processes | `top` |
| Check system load | `uptime` or `cat /proc/loadavg` |
| Check memory | `free -h` |
| Refresh memory every 10 seconds | `free -s 10` |
| Read kernel messages | `dmesg` |
| Find USB kernel messages | `dmesg \| grep -i usb` |
| Read systemd journal | `journalctl -b` |
| List log directory | `ls /var/log` |
| Identify binary file | `file /var/log/wtmp` |
| Check command search paths | `echo "$PATH"` |
| List Debian package files | `dpkg -L packagename` |
| List RPM package files | `rpm -ql packagename` |

---

**Study note:** Explanations are original paraphrases based on the Chapter 13 material supplied for study. Linux distributions and command versions may differ from course examples. This is an independent study resource, not official Cisco or LPI documentation.
