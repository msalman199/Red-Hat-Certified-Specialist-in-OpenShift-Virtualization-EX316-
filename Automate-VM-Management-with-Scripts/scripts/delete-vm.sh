#!/bin/bash

# VM Deletion Automation Script
# Usage: ./delete-vm.sh <vm-name> [namespace] [--force]

set -e

source "$(dirname "$0")/../config/vm-defaults.conf"

log_message() {
    mkdir -p "$LOG_DIR"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_DIR/vm-deletion.log"
}

validate_input() {
    if [[ -z "$1" ]]; then
        echo "Error: VM name is required"
        echo "Usage: $0 <vm-name> [namespace] [--force]"
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

stop_vm() {
    local vm_name=$1
    local namespace=$2

    if oc get vmi "$vm_name" -n "$namespace" &>/dev/null; then
        log_message "Stopping VM: $vm_name"
        oc patch vm "$vm_name" -n "$namespace" --type merge -p '{"spec":{"running":false}}'
        while oc get vmi "$vm_name" -n "$namespace" &>/dev/null; do
            sleep 5
        done
        log_message "VM stopped successfully"
    else
        log_message "VM is not running"
    fi
}

delete_vm() {
    local vm_name=$1
    local namespace=$2
    log_message "Deleting VM: $vm_name"
    oc delete vm "$vm_name" -n "$namespace"
    log_message "VM $vm_name deleted successfully"
}

confirm_deletion() {
    local vm_name=$1
    local force=$2

    if [[ "$force" != "true" ]]; then
        echo -n "Are you sure you want to delete VM $vm_name? (y/N): "
        read -r confirmation
        if [[ "$confirmation" != "y" && "$confirmation" != "Y" ]]; then
            log_message "Deletion cancelled by user"
            exit 0
        fi
    fi
}

main() {
    VM_NAME=$1
    NAMESPACE=${2:-$DEFAULT_NAMESPACE}
    FORCE=false

    shift 2 2>/dev/null || shift $#
    while [[ $# -gt 0 ]]; do
        case $1 in
            --force) FORCE=true; shift ;;
            *) echo "Unknown option: $1"; exit 1 ;;
        esac
    done

    validate_input "$VM_NAME"

    log_message "Starting VM deletion process for $VM_NAME"
    check_vm_exists "$VM_NAME" "$NAMESPACE"
    confirm_deletion "$VM_NAME" "$FORCE"
    stop_vm "$VM_NAME" "$NAMESPACE"
    delete_vm "$VM_NAME" "$NAMESPACE"

    log_message "VM deletion process completed successfully"
}

main "$@"
