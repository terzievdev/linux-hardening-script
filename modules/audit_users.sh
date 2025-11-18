#!/bin/bash
source ./utils/colors.sh
source ./utils/report_gen.sh

audit_users() {
    log_info "Starting User & Access Audit..."
    echo "<h2>User Security</h2>" >> "$REPORT_FILE"

    # Check for UID 0 non-root users
    log_info "Checking for non-root users with UID 0..."
    uid_zero=$(awk -F: '($3 == 0) {print $1}' /etc/passwd | grep -v '^root$')
    
    if [ -z "$uid_zero" ]; then
        log_pass "No non-root users with UID 0 found."
        add_to_report "PASS" "No non-root users with UID 0."
    else
        log_fail "Found non-root users with UID 0: $uid_zero"
        add_to_report "FAIL" "Critical: Non-root users with UID 0 found: $uid_zero"
    fi

    # Check for empty passwords
    log_info "Checking for empty password fields..."
    empty_pass=$(awk -F: '($2 == "" ) {print $1}' /etc/shadow)
    
    if [ -z "$empty_pass" ]; then
        log_pass "No accounts with empty passwords detected."
        add_to_report "PASS" "No empty passwords detected."
    else
        log_fail "Accounts with empty passwords: $empty_pass"
        add_to_report "FAIL" "Accounts with empty passwords found: $empty_pass"
    fi
}
