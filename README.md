# Linux Security Audit & Hardening System

## Overview
This project is a lightweight, modular Bash-based security auditing tool designed for Linux systems (Ubuntu/Debian/CentOS). It performs automated checks against common security best practices (loosely based on CIS Benchmarks) and generates an HTML compliance report.

## Features
- **System Reconnaissance:** OS version detection, kernel parameter checks (IP forwarding).
- **User Security:** Identifies UID 0 non-root users and accounts with empty passwords.
- **Network Security:** Validates UFW firewall status and scans open ports.
- **Filesystem Security:** Scans for insecure world-writable files in critical directories.
- **Reporting:** Automatically generates a styled HTML report with PASS/FAIL status.

## Prerequisites
- Linux OS (Ubuntu/Debian recommended)
- Root privileges (`sudo`)
- Bash shell
- Utilities: `awk`, `grep`, `ss`, `find`, `ufw`
