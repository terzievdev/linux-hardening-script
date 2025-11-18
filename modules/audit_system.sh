#!/bin/bash
source ./utils/colors.sh
source ./utils/report_gen.sh

audit_system() {
    log_info "Starting System Audit..."
    echo "<h2>System Configuration</h2>" >> "$REPORT_FILE"

    # Check OS Version
    if [ -f /etc/os-release ]; then
        os_name=$(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)
        log_info "OS Detected: $os_name"
        add_to_report "INFO" "OS Detected: $os_name"
    else
        log_warn "Cannot detect OS version."
        add_to_report "WARN" "Cannot detect OS version."
    fi

    # Check IP Forwarding (Should be 0 for servers usually)
    ip_fwd=$(sysctl net.ipv4.ip_forward | awk '{print $3}')
    if [ "$ip_fwd" -eq 0 ]; then
        log_pass "IP Forwarding is disabled."
        add_to_report "PASS" "IP Forwarding is disabled (Correct)."
    else
        log_fail "IP Forwarding is ENABLED! (Risk)"
        add_to_report "FAIL" "IP Forwarding is ENABLED. Set net.ipv4.ip_forward = 0"
    fi
}
