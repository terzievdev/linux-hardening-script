#!/bin/bash
source ./utils/colors.sh
source ./utils/report_gen.sh

audit_files() {
    log_info "Starting Filesystem Audit..."
    echo "<h2>Filesystem Security</h2>" >> "$REPORT_FILE"

    # Check for World Writable Files (Limit to /etc for speed in demo)
    log_info "Checking for world-writable files in /etc..."
    ww_files=$(find /etc -type f -perm -0002 -ls 2>/dev/null)

    if [ -z "$ww_files" ]; then
        log_pass "No world-writable files found in /etc."
        add_to_report "PASS" "No world-writable files in /etc."
    else
        log_warn "Found world-writable files in /etc!"
        add_to_report "WARN" "World-writable files found:<br><pre>$ww_files</pre>"
    fi
}
