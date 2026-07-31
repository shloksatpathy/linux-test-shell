#!/bin/bash

LOGFILE="system_info.txt"

# Initialize log file with timestamp
{
    echo "==============================================="
    echo "System Information Report"
    echo "Generated: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "==============================================="
    echo ""
} | tee "$LOGFILE"

# Hostname
{
    echo "--- HOSTNAME ---"
    hostname
    echo ""
} | tee -a "$LOGFILE"

# Memory Status
{
    echo "--- MEMORY STATUS ---"
    free
    echo ""
} | tee -a "$LOGFILE"

# Uptime
{
    echo "--- UPTIME ---"
    uptime
    echo ""
} | tee -a "$LOGFILE"

# Disk Usage
{
    echo "--- DISK USAGE ---"
    df -h
    echo ""
} | tee -a "$LOGFILE"

# CPU Information
{
    echo "--- CPU INFORMATION ---"
    lscpu
    echo ""
} | tee -a "$LOGFILE"

# OS Information
{
    echo "--- OS INFORMATION ---"
    uname -a
    echo ""
} | tee -a "$LOGFILE"

# Network Interfaces
{
    echo "--- NETWORK INTERFACES ---"
    ip addr show
    echo ""
} | tee -a "$LOGFILE"

# Process Count
{
    echo "--- PROCESS COUNT ---"
    echo "Total processes: $(ps aux | wc -l)"
    echo ""
} | tee -a "$LOGFILE"

# System Load Average
{
    echo "--- SYSTEM LOAD AVERAGE ---"
    cat /proc/loadavg
    echo ""
} | tee -a "$LOGFILE"

# Kernel Information
{
    echo "--- KERNEL VERSION ---"
    cat /proc/version
    echo ""
} | tee -a "$LOGFILE"

# Completion message
{
    echo "==============================================="
    echo "Report saved to: $(pwd)/$LOGFILE"
    echo "==============================================="
} | tee -a "$LOGFILE"

