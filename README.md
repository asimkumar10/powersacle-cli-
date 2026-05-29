# Dell PowerScale OneFS Administration & CLI Reference Guide

Welcome to my comprehensive administration reference and command cheat sheet for Dell PowerScale (Isilon) OneFS. This repository aggregates core administrative workflows, syntax, and operational parameters utilized during cluster configuration, performance tuning, and data protection management. 

I built and maintained this framework while preparing for professional certification and refining my infrastructure automation skill set.

---

## 🛠️ Core Administrative Workflows

| Module | Core Functional Area | Focus Areas |
| :--- | :--- | :--- |
| **Modules 1–2** | CLI Basics & Config Console | Cluster-wide execution (`isi_for_array`), drive arrays, system states |
| **Modules 3–4** | Multi-Tenancy & Networking | Active Directory, LDAP, Access Zones, SmartConnect DNS |
| **Modules 5–6** | Identity & Security Architecture| RBAC/ZRBAC permissions, Unified On-Disk Identity (SIDs/UIDs) |
| **Modules 7–11** | Storage Protocols | Multi-protocol access, SMB Shares, NFS Exports, S3 Buckets |
| **Modules 12–13**| Tiered Storage Management | SmartPools backend hardware tiers, File Pool Policies |
| **Modules 14–18**| Data Protection & Compliance | SmartQuotas, SmartDedupe, SnapshotIQ, SyncIQ, SmartLock WORM |
| **Modules 19–20**| Cluster Health & Live Telemetry | Healthcheck evaluations, `isi statistics` real-time profiling |

---

## 💻 Complete Command Reference

# Module 1: CLI Basics & General Cluster Info

---

## `isi --help`
## `isi -h`

**Description:**  
Displays the primary OneFS command structure and available subcommands.

**Use Case:**  
Used when learning CLI syntax or exploring available commands.

---

## `man isi`

**Description:**  
Opens the manual page for the `isi` utility.

**Tips:**  
- Press `q` to exit
- Use `/keyword` to search

---

## `isi devices drive list | grep dev`

**Description:**  
Lists active drives attached to the local node.

**Breakdown:**
- `isi devices drive list` → Displays drives
- `grep dev` → Filters active device entries

---

## `isi_for_array "isi devices drive list | grep -w da1"`

**Description:**  
Runs the command across all nodes simultaneously.

**Important Flags:**
- `-w` → Exact word match
- `da1` → Specific boot/journal drive

**Exam Tip:**  
`isi_for_array` executes cluster-wide, unlike normal `isi` commands.

---


