#!/bin/bash

REPORT_FILE="./output/audit_report_$(date +%F_%H-%M).html"

init_report() {
    mkdir -p ./output
    echo "<html><head><title>Security Audit Report</title>" > "$REPORT_FILE"
    echo "<style>body{font-family:Arial; padding:20px;} .fail{color:red;} .pass{color:green;} .warn{color:orange;} h2{border-bottom:1px solid #ccc;}</style>" >> "$REPORT_FILE"
    echo "</head><body>" >> "$REPORT_FILE"
    echo "<h1🛡inux Security Audit Report</h1>" >> "$REPORT_FILE"
    echo "<p>Generated on: $(date)</p>" >> "$REPORT_FILE"
    echo "<hr>" >> "$REPORT_FILE"
}

add_to_report() {
    local type=$1
    local message=$2
    local css_class="info"
    
    if [ "$type" == "FAIL" ]; then css_class="fail"; fi
    if [ "$type" == "PASS" ]; then css_class="pass"; fi
    if [ "$type" == "WARN" ]; then css_class="warn"; fi
    
    echo "<div class='${css_class}'><strong>[${type}]</strong> ${message}</div>" >> "$REPORT_FILE"
}

close_report() {
    echo "</body></html>" >> "$REPORT_FILE"
    echo "$REPORT_FILE"
}
