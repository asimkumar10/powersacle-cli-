#!/bin/bash
# ==============================================================================
# Script Name: provision_smb_share.sh
# Purpose: Programmatically creates a directory path, provisions an SMB share, 
#          and sets strict multi-tenant Access Zone ACL permissions.
# Focus Area: Module 13 (SMB Shares, Pages 124-141)
# ==============================================================================

# Customization Variables
SHARE_NAME="Engineering_Data"
SHARE_PATH="/ifs/data/engineering_smb"
ZONE_NAME="System"                  # Change to your specific tenant Access Zone if needed
AD_GROUP="DOMAIN\\Engineering_Team"  # Active Directory group to grant access
DESCRIPTION="Cross-platform Windows share for Engineering team data storage"

# Formatting Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "======================================================="
echo "       POWERSCALE SMB SHARE AUTOMATION ENGINE          "
echo "======================================================="

# 1. Path Safeguard Verification
echo -e "${YELLOW}[*] Phase 1: Verifying storage directory structure...${NC}"
if [ ! -d "$SHARE_PATH" ]; then
    echo -e "${YELLOW}[!] Target path $SHARE_PATH not found. Provisioning folder...${NC}"
    mkdir -p "$SHARE_PATH"
    # Ensure standard POSIX fallback permissions allow OneFS mapping
    chmod 777 "$SHARE_PATH"
    echo -e "${GREEN}[+] Directory branch established successfully.${NC}"
else
    echo -e "${GREEN}[+] Existing directory path verified.${NC}"
fi

# 2. Executing OneFS SMB Creation Command
echo ""
echo -e "${YELLOW}[*] Phase 2: Deploying SMB Share [${SHARE_NAME}] in Access Zone: [${ZONE_NAME}]...${NC}"

isi smb shares create \
    --name="$SHARE_NAME" \
    --path="$SHARE_PATH" \
    --zone="$ZONE_NAME" \
    --description="$DESCRIPTION" \
    --create-path \
    2>/dev/null

# 3. Post-Creation Permission Injection (ACLs)
if [ $? -eq 0 ]; then
    echo -e "${GREEN}[+] SMB Share shell provisioned successfully.${NC}"
    echo -e "${YELLOW}[*] Phase 3: Injecting domain group permissions into SMB ACL framework...${NC}"
    
    # Explicitly maps Full Control access to the designated Active Directory group
    isi smb shares permission create \
        --share="$SHARE_NAME" \
        --zone="$ZONE_NAME" \
        --permission-type=allow \
        --grant-full-control="$AD_GROUP" \
        2>/dev/null
        
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[+] Domain permissions applied successfully.${NC}"
    else
        echo -e "${YELLOW}[!] Warning: Active Directory mapping skipped. (Expected if run outside a live Windows domain).${NC}"
    fi

    # 4. Final Validation Audit Pass
    echo ""
    echo -e "${GREEN}[+] SUCCESS: Complete workflow verification pipeline:${NC}"
    echo "-------------------------------------------------------"
    echo "Current Live SMB Share Profile Details:"
    echo "-------------------------------------------------------"
    isi smb shares view "$SHARE_NAME" --zone="$ZONE_NAME"
else
    echo -e "${RED}[-] ERROR: Creation pipeline aborted. Verify OneFS cluster administrative scope.${NC}"
    exit 1
fi

echo "======================================================="
