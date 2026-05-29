#!/bin/bash
# ==============================================================================
# Script Name: sample_telemetry.sh
# Purpose: Samples live IOPS metrics of local underlying disk media.
# ==============================================================================

echo "======================================================="
echo "      LIVE PERFORMANCE INDICATOR TELEMETRY             "
echo "======================================================="

echo "[*] Capturing top 10 localized drive execution streams..."
echo "-------------------------------------------------------"

# Captures drive operation tracking statistics, passing output safely via head limits
isi statistics drive | head -n 12

echo "-------------------------------------------------------"
echo "[+] Live sampling pass executed successfully."
echo "======================================================="
