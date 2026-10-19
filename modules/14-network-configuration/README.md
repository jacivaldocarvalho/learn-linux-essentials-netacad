# Module 14 — Network Configuration

Personal study notes for **Cisco Networking Academy / NDG Linux Essentials**, Chapter 14. Original explanations and command examples for review; not a reproduction of the course material.

## 1. Exam Objectives

**LPI Linux Essentials — Objective 4.4: Your Computer on the Network**  
**Weight:** 2  
**Scope:** Query essential networking configuration and understand the basic requirements for a computer on a Local Area Network (LAN).

**Key knowledge areas:** Internet, networks, routers, DNS client configuration, and querying network configuration.

| Command / file | Purpose |
|---|---|
| `ip addr show` | Display interface addresses and status |
| `ip route show` | Display the IP routing table |
| `ping` | Test ICMP reachability |
| `ss` | Inspect sockets and listening ports |
| `dig`, `host` | Query DNS records |
| `ssh` | Log in to a remote host securely |
| `/etc/hosts` | Local hostname-to-address mappings |
| `/etc/resolv.conf` | Resolver nameserver settings |
| `/etc/nsswitch.conf` | Name-service lookup sources and order |
| `ifconfig`, `route`, `netstat` | Traditional networking tools |

## 2. Basic Network Terminology (14.1–14.3)

A **host** is a device that communicates over a network. A **network** connects two or more hosts, while the **Internet** connects many networks worldwide. A **LAN** is a local network. **Wi-Fi** is a wireless networking technology, and **Ethernet** is common on wired LANs.

A **server** offers a service; a **client** requests it. A **router** forwards traffic between networks, and a **default gateway** is the next hop used when no more specific route matches.

| Term | Meaning |
|---|---|
| Packet | Unit of network data carrying addressing and payload information |
| IP address | Logical address assigned to a network interface |
| Netmask | Distinguishes network bits from host bits in an IPv4 address |
| Hostname | Human-readable name of a host |
| URL | Address identifying a resource, including a scheme and usually a host |
| DHCP | Automatically supplies network settings to clients |
| DNS | Resolves domain names into IP addresses and provides other records |
| TCP/IP | Protocol suite used for network communication |

Typical communication path:

```text
Laptop (client) -- Wi-Fi/LAN --> Router (gateway) --> Internet --> Web server
                           DNS lookup: example.com -> IP address
```

**Exam note:** An IP packet contains **source** and **destination** IP addresses, not a router name or a disk partition.

## 3. IPv4, IPv6, Masks, and NAT (14.4)

**IPv4** addresses are 32 bits long, written as four decimal octets from 0 to 255, such as `192.168.10.120`. **IPv6** addresses are 128 bits long, written in hexadecimal groups, such as `2001:db8:85a3:42:1000:8a2e:370:7334`.

| Property | IPv4 | IPv6 |
|---|---|---|
| Address length | 32 bits | 128 bits |
| Example | `192.168.1.20` | `2001:db8::20` |
| Typical notation | Dotted decimal | Colon-separated hexadecimal |
| Example prefix | `/24` | `/64` |

For `192.168.1.20/24`, the first 24 bits represent the network; the network address is `192.168.1.0` and the broadcast address is `192.168.1.255`. **NAT** can allow multiple private IPv4 hosts to share a public IPv4 address. IPv6 greatly expands address space; it does not automatically make every connection faster.

**Exam note:** `192.105.10.10` and `10.33.55.77` are syntactically valid IPv4 addresses. `192.301.25.25` has an out-of-range octet; `192.105.10.10.2` has too many octets.

## 4. Configuring Network Devices (14.5)

Network interfaces may be **wired** or **wireless** and may use **DHCP** or a **static** configuration. DHCP can provide an IP address, prefix/netmask, gateway, and DNS servers; a static setup requires the administrator to supply the relevant values.

The chapter demonstrates the historical CentOS/RHEL interface file `/etc/sysconfig/network-scripts/ifcfg-eth0`:

```ini
DEVICE=eth0
BOOTPROTO=dhcp
ONBOOT=yes
```

A static example in that older format:

```ini
DEVICE=eth0
BOOTPROTO=none
ONBOOT=yes
IPADDR=192.168.1.10
PREFIX=24
GATEWAY=192.168.1.1
DNS1=192.168.1.2
```

**Important:** These are historical examples from the course, not universal instructions for modern Linux distributions. Current systems may use NetworkManager, Netplan, systemd-networkd, or other managers. Do not restart networking on a remote machine without planning for loss of connectivity.

### 4.1. Name Resolution Configuration (14.5.1.3–14.5.1.4)

| File | Responsibility |
|---|---|
| `/etc/hosts` | Local mappings such as `127.0.0.1 localhost` |
| `/etc/resolv.conf` | DNS resolver settings such as `nameserver 192.168.1.1` |
| `/etc/nsswitch.conf` | Lookup order, e.g., `hosts: files dns` |

```bash
cat /etc/hosts
cat /etc/resolv.conf
grep '^hosts:' /etc/nsswitch.conf
```

With `hosts: files dns`, local host mappings are checked before DNS. A local match may override a DNS result. The resolver configuration file is often generated automatically; avoid editing it without understanding the network manager in use.

## 5. Inspecting Interfaces: `ifconfig` vs. `ip` (14.6.1–14.6.2)

`ifconfig` is a traditional command; `ip` is the modern tool from the iproute2 suite.

```bash
ifconfig             # May not be installed
ip addr show
ip -4 addr show
ip -6 addr show
ip link show
```

Example fields in `ip addr show`:

```text
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
    link/ether 00:11:22:33:44:55
    inet 192.168.1.20/24 scope global eth0
```

`inet` denotes IPv4, `inet6` IPv6, and `lo` is the loopback interface (typically `127.0.0.1` and `::1`). Interface names differ by system.

## 6. Routing: `route` vs. `ip route` (14.6.3)

```bash
route -n             # Legacy, may not be installed
ip route show
```

Example:

```text
default via 192.168.1.1 dev eth0
192.168.1.0/24 dev eth0 scope link
```

The `default` route directs traffic for destinations not matched by a more specific route. `via` indicates the next-hop gateway. In `route -n`, `0.0.0.0` represents the default destination.

## 7. Testing Connectivity with `ping` (14.6.4)

```bash
ping -c 4 192.168.1.1
ping -c 4 example.com
```

`-c 4` sends four requests. Review response times and packet-loss statistics. A successful hostname ping also indicates that name resolution worked for that attempt. A failed ping does **not** conclusively prove the host is down: ICMP may be blocked or filtered.

## 8. Connections and Listening Ports: `netstat` vs. `ss` (14.6.5–14.6.6)

```bash
netstat -i           # Legacy: interface statistics
netstat -r           # Legacy: routing table
netstat -tln         # Legacy: TCP listening sockets, numeric
ss                  # Socket information
ss -s               # Socket summary
ss -tln             # TCP listening sockets, numeric
ss -tuln            # TCP and UDP listening sockets, numeric
```

| Option | Meaning |
|---|---|
| `-t` | TCP |
| `-u` | UDP |
| `-l` | Listening sockets |
| `-n` | Numeric addresses and ports (no name lookup) |
| `-s` (`ss`) | Summary statistics |

In `ss`, `Local Address:Port` identifies the local socket endpoint; `Peer Address:Port` identifies the remote endpoint. `LISTEN` indicates a socket is accepting connection attempts, not necessarily that external access is permitted by firewalls.

**Exam note:** `netstat -n` displays addresses and ports as **numbers rather than names**.

## 9. DNS Diagnostics: `dig` and `host` (14.6.7–14.6.8)

```bash
dig example.com
dig +short example.com
host example.com
host 8.8.8.8
host -t SOA example.com
host -t CNAME example.com
```

`dig` gives detailed DNS query information, including answers and the responding DNS server. `host` provides straightforward forward, reverse, and record-type lookups. Both commands may require an additional package depending on the distribution.

**Important:** A DNS timeout means a query did not receive a response; it does not necessarily mean that the requested domain has no DNS records.

## 10. Remote Access with SSH (14.6.9–14.6.9.1)

SSH creates an encrypted remote login session:

```bash
ssh nick@server1
ssh bob@192.168.1.50
exit
```

The syntax is `ssh username@hostname`. The SSH server typically listens on TCP port 22. When connecting for the first time, verify the server's **host key fingerprint** through a trusted channel before accepting it. If the stored key later changes, investigate the warning before updating `~/.ssh/known_hosts`. A changed key can indicate a legitimate server rebuild or an impersonation attempt.

**Exam note:** SSH uses host key fingerprints; `dig` performs DNS queries and does not use SSH fingerprints.

## 11. Read-Only Practice Lab

The companion script in [`code/network-diagnostics.sh`](code/network-diagnostics.sh) prints local interface addresses, routing, resolver settings, socket summaries, and optional DNS/connectivity checks. It does not change network settings.

```bash
bash code/network-diagnostics.sh
bash code/network-diagnostics.sh --online
```

The `--online` mode additionally queries `example.com` and sends four ICMP requests. Some commands may be absent in minimal environments; the script reports this without attempting installation.

## 12. Chapter 14 Knowledge Check — Answer Key

| Question | Correct answer | Reason |
|---|---|---|
| 1 | Destination IP; Source IP | Both addresses are carried by IP packets |
| 2 | TCP/IP | Protocol suite defining network communication |
| 3 | `192.105.10.10`; `10.33.55.77` | Each has four valid IPv4 octets |
| 4 | `ifconfig` | Displays interface configuration (legacy command) |
| 5 | `ssh` | Secure remote login |
| 6 | `-n` | Numeric output in `netstat` |
| 7 | `ssh nick@server1` | Correct user/host syntax |
| 8 | False | SSH, not `dig`, uses host key fingerprints |
| 9 | False | DHCP configuration uses `BOOTPROTO=dhcp`, not `none` |
| 10 | `/etc/resolv.conf` | Lists configured DNS resolver nameservers |



---

**Study note:** Explanations are original paraphrases based on the Chapter 13 material supplied for study. Linux distributions and command versions may differ from course examples. This is an independent study resource, not official Cisco or LPI documentation.
