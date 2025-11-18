#!/bin/bash

# Main Entry Point for Linux Security Audit

# Ensure running as root
if [ "$EUID" -ne 0 ]; then 
  echo -e "\033[0;31mPlease run as root (sudo).\033[0m"
  exit 1
fi

# Import Modules
source ./utils/colors.sh
source ./utils/report_gen.sh
source ./modules/audit_system.sh
source ./modules/audit_network.sh
source ./modules/audit_users.sh
source ./modules/audit_files.sh

clear
echo -e "${BLUE}=========================================${NC}"
echo -e "${YELLOW}   LINUX HARDENING & SECURITY AUDIT      ${NC}"
echo -e "${BLUE}=========================================${NC}"

init_report

# Run Checks
audit_system
audit_users
audit_network
audit_files

# Finalize
report_path=$(close_report)
echo -e "${BLUE}=========================================${NC}"
echo -e "${GREEN}Audit Complete!${NC}"
echo -e "${YELLOW}Report generated at: $report_path${NC}"
echo -e "${BLUE}=========================================${NC}"
