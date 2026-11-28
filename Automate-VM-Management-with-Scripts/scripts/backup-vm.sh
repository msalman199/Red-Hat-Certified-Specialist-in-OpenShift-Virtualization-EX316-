#!/bin/bash

# VM Backup Automation Script
# Usage: ./backup-vm.sh <vm-name> [namespace] [retention-days]

set -e

source "$(dirname "$0")/../config/vm-defaults.conf"

log_message() {
    mkdir -p "$LOG_DIR"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_DIR/vm-backups.log"
}

validate_input() {
    if [[ -z "$1" ]]; then
        echo "Error: VM name is required"
        echo "Usage: $0 <vm-name> [namespace] [retention-days]"
        exit 1
    fi
}

check_vm_exists() {
    local vm_name=$1
    local namespace=$2
    if ! oc get vm "$vm_name" -n "$namespace" &>/dev/null; then
        log_message "ERROR: VM $vm_name does not exist in namespace $namespace"
        exit 1
    fi
}

backup_vm_config() {
    local vm_name=$1
    local namespace=$2
    local backup_dir=$3

    log_message "Backing up VM configuration for $vm_name"

    oc get vm "$vm_name" -n "$namespace" -o yaml > "$backup_dir/${vm_name}-vm.yaml"

    if oc get vmi "$vm_name" -n "$namespace" &>/dev/null; then
        oc get vmi "$vm_name" -n "$namespace" -o yaml > "$backup_dir/${vm_name}-vmi.yaml"
    fi

    oc get pvc -n "$namespace" -l "kubevirt.io/vm=$vm_name" -o yaml \
        > "$backup_dir/${vm_name}-pvcs.yaml" 2>/dev/null || true
    oc get secret -n "$namespace" -l "kubevirt.io/vm=$vm_name" -o yaml \
        > "$backup_dir/${vm_name}-secrets.yaml" 2>/dev/null || true
    oc get configmap -n "$namespace" -l "kubevirt.io/vm=$vm_name" -o yaml \
        > "$backup_dir/${vm_name}-configmaps.yaml" 2>/dev/null || true

    log_message "VM configuration backup completed"
}

backup_vm_metadata() {
    local vm_name=$1
    local namespace=$2
    local backup_dir=$3

    log_message "Creating metadata backup for $vm_name"

    cat > "$backup_dir/backup-metadata.json" << METAEOF
{
  "vm_name": "$vm_name",
  "namespace": "$namespace",
  "backup_date": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "created_by": "vm-backup-automation",
  "retention_days": $RETENTION_DAYS
}
METAEOF

    oc get vm "$vm_name" -n "$namespace" -o json | jq '{
        name: .metadata.name,
        namespace: .metadata.namespace,
        created: .metadata.creationTimestamp,
        running: .spec.running,
        cpu: .spec.template.spec.domain.cpu.cores,
        memory: .spec.template.spec.domain.resources.requests.memory
    }' > "$backup_dir/vm-status.json"

    log_message "Metadata backup completed"
}

compress_backup() {
    local backup_dir=$1
    local vm_name=$2
    local archive_name="${vm_name}-backup-$(date +%Y%m%d-%H%M%S).tar.gz"

    log_message "Compressing backup into $archive_name"

    tar -czf "$BACKUP_DIR/$archive_name" -C "$BACKUP_DIR" "$(basename "$backup_dir")"

    log_message "Backup compressed successfully: $BACKUP_DIR/$archive_name"
}

cleanup_old_backups() {
    local vm_name=$1
    local retention_days=$2

    log_message "Cleaning up backups older than $retention_days days for $vm_name"

    find "$BACKUP_DIR" -maxdepth 1 -name "${vm_name}-backup-*.tar.gz" -mtime "+$retention_days" -delete
    find "$BACKUP_DIR" -maxdepth 1 -name "${vm_name}-2*" -type d -mtime "+$retention_days" -exec rm -rf {} + 2>/dev/null || true

    log_message "Old backup cleanup completed"
}

main() {
    mkdir -p "$LOG_DIR" "$BACKUP_DIR"

    VM_NAME=$1
    NAMESPACE=${2:-$DEFAULT_NAMESPACE}
    RETENTION_DAYS=${3:-30}

    validate_input "$VM_NAME"

    BACKUP_DIR_VM="$BACKUP_DIR/${VM_NAME}-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR_VM"

    log_message "Starting backup process for VM $VM_NAME"

    check_vm_exists "$VM_NAME" "$NAMESPACE"

    backup_vm_metadata "$VM_NAME" "$NAMESPACE" "$BACKUP_DIR_VM"
    backup_vm_config "$VM_NAME" "$NAMESPACE" "$BACKUP_DIR_VM"
    compress_backup "$BACKUP_DIR_VM" "$VM_NAME"
    rm -rf "$BACKUP_DIR_VM"

    cleanup_old_backups "$VM_NAME" "$RETENTION_DAYS"

    log_message "Backup process completed successfully for $VM_NAME"
}

main "$@"
