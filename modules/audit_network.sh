#!/bin/bash
source ./utils/colors.sh
source ./utils/report_gen.sh

audit_network() {
    log_info "Starting Network Audit..."
    echo "<h2>Network Security</h2>" >> "$REPORT_FILE"

    # Check Firewall Status (UFW)
    if command -v ufw >/dev/null; then
        ufw_status=$(sudo ufw status | grep "Status: active")
        if [ -n "$ufw_status" ]; then
            log_pass "UFW Firewall is ACTIVE."
            add_to_report "PASS" "UFW Firewall is ACTIVE."
        else
            log_fail "UFW Firewall is INACTIVE."
            add_to_report "FAIL" "UFW Firewall is INACTIVE."
        fi
    else
        log_warn "UFW not installed. Skipping UFW check."
        add_to_report "WARN" "UFW is not installed."
    fi

    # List open ports
    open_ports=$(ss -tuln | grep LISTEN)
    log_info "Scanning open ports..."
    add_to_report "INFO" "Open Ports Detected:<br><pre>$open_ports</pre>"
}
