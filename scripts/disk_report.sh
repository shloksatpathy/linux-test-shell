#!/bin/bash

# disk_report.sh - Generate disk usage report
# Usage: ./disk_report.sh [options]
# Options:
#   -p, --path PATH      Show disk usage for specific path (default: /)
#   -h, --human          Use human-readable format (default)
#   -b, --bytes          Show size in bytes
#   --threshold PCT      Highlight partitions above percentage threshold
#   --help               Show this help message

set -euo pipefail

HUMAN_READABLE=true
THRESHOLD=0
TARGET_PATH="/"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -p|--path)
            TARGET_PATH="$2"
            shift 2
            ;;
        -h|--human)
            HUMAN_READABLE=true
            shift
            ;;
        -b|--bytes)
            HUMAN_READABLE=false
            shift
            ;;
        --threshold)
            THRESHOLD="$2"
            shift 2
            ;;
        --help)
            head -n 13 "$0" | tail -n 10
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            exit 1
            ;;
    esac
done

# Color codes
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

print_header() {
    echo ""
    echo "===== DISK USAGE REPORT ====="
    echo "Generated: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "System: $(uname -s) $(uname -r)"
    echo ""
}

print_partition_info() {
    echo "--- Partition Details ---"
    if [ "$HUMAN_READABLE" = true ]; then
        df -h | head -1
        df -h | tail -n +2 | while IFS= read -r line; do
            usage=$(echo "$line" | awk '{print $5}' | sed 's/%//')
            if [ "$THRESHOLD" -gt 0 ] && [ "$usage" -ge "$THRESHOLD" ]; then
                echo -e "${RED}$line${NC}"
            elif [ "$usage" -gt 80 ]; then
                echo -e "${YELLOW}$line${NC}"
            else
                echo "$line"
            fi
        done
    else
        df | head -1
        df | tail -n +2 | while IFS= read -r line; do
            echo "$line"
        done
    fi
}

print_directory_info() {
    local path="$1"

    if [ ! -e "$path" ]; then
        echo "Error: Path does not exist: $path" >&2
        return 1
    fi

    echo ""
    echo "--- Top 10 Directories in $path ---"

    if [ "$HUMAN_READABLE" = true ]; then
        du -sh "$path"/* 2>/dev/null | sort -rh | head -10 || true
    else
        du -sb "$path"/* 2>/dev/null | sort -rn | head -10 || true
    fi
}

print_summary() {
    echo ""
    echo "--- Summary ---"
    total=$(df "$TARGET_PATH" | tail -1 | awk '{print $2}')
    used=$(df "$TARGET_PATH" | tail -1 | awk '{print $3}')
    avail=$(df "$TARGET_PATH" | tail -1 | awk '{print $4}')

    if [ "$HUMAN_READABLE" = true ]; then
        total=$(numfmt --to=iec "$total" 2>/dev/null || echo "${total}K")
        used=$(numfmt --to=iec "$used" 2>/dev/null || echo "${used}K")
        avail=$(numfmt --to=iec "$avail" 2>/dev/null || echo "${avail}K")
    fi

    echo "Total: $total"
    echo "Used: $used"
    echo "Available: $avail"
}

# Main execution
print_header
print_partition_info
print_directory_info "$TARGET_PATH"
print_summary

exit 0
