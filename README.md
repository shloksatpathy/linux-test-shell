# lnx-toolkit

A collection of bash scripts for gathering and analyzing Linux system information.

## Overview

lnx-toolkit provides simple, yet effective shell scripts for system monitoring and disk usage analysis. Generate comprehensive reports on your Linux system's hardware, performance, and storage utilization with a single command.

## Scripts

### system_info.sh

Comprehensive system information reporter that captures detailed details about your Linux system.

**Features:**
- Hostname information
- Memory and RAM status
- System uptime
- Disk usage across all mounted filesystems
- CPU specifications
- OS information and kernel details
- Network interface configuration
- Running process count
- System load averages
- Kernel version

**Usage:**
```bash
./scripts/system_info.sh
```

**Output:**
Generates a `system_info.txt` file in the current directory with all system information. Output is also displayed to stdout.

---

### disk_report.sh

Advanced disk usage analyzer with customizable reporting options.

**Features:**
- Human-readable and byte-level reporting
- Disk usage for specific paths
- Customizable threshold-based highlighting
- Top 10 directories by size
- Color-coded disk usage warnings (yellow for >80% usage)
- Summary statistics (total, used, available space)

**Usage:**
```bash
./scripts/disk_report.sh [options]
```

**Options:**
```
-p, --path PATH      Show disk usage for specific path (default: /)
-h, --human          Use human-readable format (default)
-b, --bytes          Show size in bytes
--threshold PCT      Highlight partitions above percentage threshold
--help               Show help message
```

**Examples:**
```bash
# Default report for root filesystem
./scripts/disk_report.sh

# Report for home directory in human-readable format
./scripts/disk_report.sh --path /home

# Report with bytes and 75% threshold highlighting
./scripts/disk_report.sh --bytes --threshold 75

# Report for /var directory
./scripts/disk_report.sh -p /var
```

**Output:**
- Partition details with color-coded usage levels
- Top 10 largest directories in the target path
- Summary of total, used, and available space

---

## Requirements

- Bash 4.0+
- Standard Linux utilities: `df`, `du`, `free`, `ps`, `hostname`, `lscpu`, `uname`, `ip`

## Getting Started

1. Clone or download the repository:
   ```bash
   git clone <repository-url> lnx-toolkit
   cd lnx-toolkit
   ```

2. Make scripts executable:
   ```bash
   chmod +x scripts/*.sh
   ```

3. Run a script:
   ```bash
   ./scripts/system_info.sh
   # or
   ./scripts/disk_report.sh --help
   ```

## Color Output

The disk_report.sh script uses color-coded output to highlight disk usage:
- **Green**: Normal usage (< 80%)
- **Yellow**: Warning level (80-99%)
- **Red**: Critical level (≥ threshold, if specified)

## Tips

- Run `system_info.sh` periodically to track system resource trends
- Use `disk_report.sh` with different paths to identify storage bottlenecks
- Combine with cron for automated, scheduled reporting
- Redirect output to files for archival and comparison

## License

[Add your license here]

## Author

Shlok Satpathy
