#!/bin/bash
# Wrapper script for cron-scheduled backups
cd "$HOME/vm-automation" || exit 1
./scripts/backup-vm.sh backup-test-vm vm-automation 30 >> "$HOME/vm-automation/logs/cron-backup.log" 2>&1
