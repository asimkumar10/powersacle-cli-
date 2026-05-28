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

### Module 1: CLI Basics & General Cluster Info
* **`isi --help`** or **`isi -h`**
  * *Description:* Displays the primary core OneFS command structure, listing all top-level subcommands and standard execution syntax options.
* **`isi_for_array "isi devices drive list \| grep -w da1"`**
  * *Description:* Cluster-wide parallel executive tool. Fires the wrapped command across every single connected node simultaneously. The `-w` switch forces an exact matching filter for the boot/journal drive string.

### Module 5: Role-Based Access Control (RBAC & ZRBAC)
* **`isi auth roles modify ZoneAdmin --add-user=<username> --zone=<zone_name>`**
  * *Description:* Exercises Zone-based Role-Based Access Control (ZRBAC) properties. Grants administrative dominion over isolated data sets strictly bounded inside a single specific Access Zone layer.


