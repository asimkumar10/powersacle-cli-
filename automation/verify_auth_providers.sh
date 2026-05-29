#!/bin/bash
# ==============================================================================
# Script Name: verify_auth_providers.sh
# Purpose: Audits configured external directory maps (LDAP/ADS) across the cluster.
# ==============================================================================

echo "======================================================="
echo "      IDENTITY MANAGEMENT ARCHITECTURE AUDIT           "
echo "======================================================="

echo "[*] Checking registered Active Directory Spaces..."
# Queries global system configuration boundaries for domain controller records
isi auth ads list 2>/dev/null || echo "[-] No Active Directory mappings registered in this context."

echo ""
echo "[*] Checking LDAP Provider Maps..."
# Pulls structural configuration records for LDAP integration boundaries
isi auth ldap list 2>/dev/null || echo "[-] No LDAP directory infrastructure paths configured."

echo "======================================================="
