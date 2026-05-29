#!/bin/bash
# ==============================================================================
# Script Name: provision_nfs_export.sh
# Purpose: Programmatically validates directory paths and provisions an NFS 
#          export inside a designated multi-tenant Access Zone container.
# Focus Area: Module 9 (NFS Exports, Pages 142-155)
# ==============================================================================

# Customization Variables
EXPORT_PATH="/ifs/data/engineering_shares"
ZONE_NAME="System"                    # Change if using a custom Access Zone tenant
ROOT_CLIENT_IP="192.168.1.50"         # Client IP requiring root administrative access
DESCRIPTION="Engineering Linux Share"

# Formatting Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "======================================================="
echo "       POWERSCALE NFS EXPORT AUTOMATION ENGINE        "
echo "======================================================="

# 1. Directory Verification Check
echo -e "${YELLOW}[*] Phase 1: Validating underlying storage path compatibility...${NC}"
if [ ! -d "$EXPORT_PATH" ]; then
    echo -e "${YELLOW}[!] Path $EXPORT_PATH does not exist. Creating directory branch...${NC}"
    # Creates the path and sets wide POSIX bits to ensure multi-protocol readability
    mkdir -p "$EXPORT_PATH"
    chmod 777 "$EXPORT_PATH"
    echo -e "${GREEN}[+] Path generated successfully.${NC}"
else
    echo -e "${GREEN}[+] Target path validated. Ready for export mounting.${NC}"
fi

# 2. Executing OneFS NFS Provisioning Command
echo ""
echo -e "${YELLOW}[*] Phase 2: Generating NFS Export in Zone: [${ZONE_NAME}]...${NC}"

isi nfs exports create \
    --paths="$EXPORT_PATH" \
    --zone="$ZONE_NAME" \
    --description="$DESCRIPTION" \
    --root-clients="$ROOT_CLIENT_IP" \
    2>/dev/null

# 3. Validation Pass
if [ $? -eq 0 ]; then
    echo -e "${GREEN}[+] SUCCESS: NFS Export successfully mapped to $EXPORT_PATH${NC}"
    echo "-------------------------------------------------------"
    echo "Current Live Export Configuration Profile:"
    echo "-------------------------------------------------------"
    # Queries the live configuration map using filters to confirm active settings
    isi nfs exports list --zone="$ZONE_NAME" | grep -E "ID|Paths"
else
    echo -e "${RED} [-] ERROR: Failed to create NFS export. Verify your OneFS cluster permission state.${NC}"
    exit 1
fi

echo "======================================================="
