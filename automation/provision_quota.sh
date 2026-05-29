#!/bin/bash
# ==============================================================================
# Script Name: provision_quota.sh
# Purpose: Programmatically validates target paths and provisions a SmartQuota
#          with explicit Hard limits, Advisory warnings, and container behaviors.
# Focus Area: Module 14 (SmartQuotas, Pages 233-260)
# ==============================================================================

# Customization Variables
QUOTA_PATH="/ifs/data/engineering_smb"   # Target path to apply constraints
QUOTA_TYPE="directory"                   # Types: directory, user, or group
HARD_LIMIT="10G"                         # Enforced hard boundary (e.g., 10G, 500M)
ADVISORY_LIMIT="8G"                      # Warning threshold for alerts

# Formatting Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "======================================================="
echo "       POWERSCALE SMARTQUOTA PROVISIONING ENGINE        "
echo "======================================================="

# 1. Path Prerequisite Validation
echo -e "${YELLOW}[*] Phase 1: Checking target path existence...${NC}"
if [ ! -d "$QUOTA_PATH" ]; then
    echo -e "${YELLOW}[!] Target directory $QUOTA_PATH missing. Creating directory...${NC}"
    mkdir -p "$QUOTA_PATH"
    chmod 777 "$QUOTA_PATH"
    echo -e "${GREEN}[+] Path generated successfully.${NC}"
else
    echo -e "${GREEN}[+] Target path verified.${NC}"
fi

# 2. Executing SmartQuota Creation
echo ""
echo -e "${YELLOW}[*] Phase 2: Applying ${QUOTA_TYPE} quota limits onto [${QUOTA_PATH}]...${NC}"
echo -e "    -> Hard Limit: ${HARD_LIMIT}"
echo -e "    -> Advisory Limit: ${ADVISORY_LIMIT}"

# The --container flag tells OneFS to report the quota size as the actual 
# total disk size to any operating systems mounting this specific path.
isi quota quotas create \
    --path="$QUOTA_PATH" \
    --type="$QUOTA_TYPE" \
    --hard="$HARD_LIMIT" \
    --advisory="$ADVISORY_LIMIT" \
    --container=true \
    2>/dev/null

# 3. Post-Execution Audit & Validation Pass
if [ $? -eq 0 ]; then
    echo -e "${GREEN}[+] SUCCESS: SmartQuota enforced successfully.${NC}"
    echo "-------------------------------------------------------"
    echo "Current Active Quota Tracking Matrix:"
    echo "-------------------------------------------------------"
    
    # Query the live quota engine filtering strictly for our new path
    isi quota quotas list --path="$QUOTA_PATH" --type="$QUOTA_TYPE"
else
    echo -e "${RED}[-] ERROR: Failed to instantiate SmartQuota policy. Check OneFS license state.${NC}"
    exit 1
fi

echo "======================================================="
