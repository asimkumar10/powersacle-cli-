#!/bin/bash
# ==============================================================================
# Script Name: discover_drives.sh
# Purpose: Programmatically inventories active block devices on the local node.
# ==============================================================================

set -e

echo "======================================================="
echo "        POWERSCALE SYSTEM DRIVE INVENTORY               "
echo "======================================================="

echo "[*] Auditing active blocks on the local device array..."
# Executes storage engine lookups and strips out empty slots using grep matching
isi devices drive list | grep -E "dev|Lnn" || echo "[-] No matching disk devices found."

echo ""
echo "[*] Evaluating storage block device mapping sizes..."
# Shows structural raw devices matching typical OneFS localized storage descriptors
df -h | grep -E "Filesystem|/ifs"

echo "======================================================="
