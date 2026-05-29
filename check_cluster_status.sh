#!/bin/bash

# ==============================================================================
# Script Name: check_cluster_status.sh
# Description: Automates baseline PowerScale OneFS cluster status checks 
#              utilizing foundational CLI commands from Modules 1-2.
# Use Case:    Exam Prep / Automated Component Auditing
# ==============================================================================

# Text Formatting Constants
GREEN='\033[0;32m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

echo -e "${BLUE}${BOLD}=======================================================${NC}"
echo -e "${BLUE}${BOLD}          POWERSCALE CLUSTER STATUS CHECK              ${NC}"
echo -e "${BLUE}${BOLD}=======================================================${NC}"
echo ""

# 1. Local Node Storage Drive Landscape
echo -e "${GREEN}${BOLD}[1/3] Fetching Active Drive Landscape (Local Node)...${NC}"
echo "-------------------------------------------------------"
# Filters out empty drive slots to show only active, attached media devices
isi devices drive list | grep dev
echo ""

# 2. Parallel Cluster-wide Validation
echo -e "${GREEN}${BOLD}[2/3] Verifying Boot/Journal Drive (da1) Status Across Array...${NC}"
echo "-------------------------------------------------------"
# Executes concurrently across all backend connected nodes via internal network
isi_for_array "isi devices drive list | grep -w da1"
echo ""

# 3. Storage Media Telemetry Performance
echo -e "${GREEN}${BOLD}[3/3] Sampling Live Local Drive IOPS Performance...${NC}"
echo "-------------------------------------------------------"
# Displays the top 10 performance indicators for underlying physical disks
isi statistics drive | head -n 12
echo ""

echo -e "${BLUE}${BOLD}=======================================================${NC}"
echo -e "${BLUE}${BOLD}                STATUS CHECK COMPLETE                  ${NC}"
echo -e "${BLUE}${BOLD}=======================================================${NC}"
