#!/bin/bash

# VM Scaling Automation Script
# Usage: ./scale-vm.sh <vm-name> [--cpu <cores>] [--memory <size>] [--namespace <ns>]

set -e

source "$(dirname "$0")/../config/vm-defaults.conf"

log_message() {
    mkdir -p "$LOG_DIR"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_DIR/vm-scaling.log"
}

validate_input() {
    if [[ -z "$1" ]]; then
        echo "Error: VM name is required"
        echo "Usage: $0 <vm-name> [--cpu <cores>] [--memory <size>] [--namespace <ns>]"
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

is_vm_running() {
    local vm_name=$1
    local namespace=$2
    oc get vmi "$vm_name" -n "$namespace" &>/dev/null
}

scale_cpu() {
    local vm_name=$1
    local namespace=$2
    local new_cpu=$3
    log_message "Scaling CPU to $new_cpu cores"
    oc patch vm "$vm_name" -n "$namespace" --type merge \
        -p "{\"spec\":{\"template\":{\"spec\":{\"domain\":{\"cpu\":{\"cores\":$new_cpu}}}}}}"
}

scale_memory() {
    local vm_name=$1
    local namespace=$2
    local new_memory=$3
    log_message "Scaling memory to $new_memory"
    oc patch vm "$vm_name" -n "$namespace" --type merge \
        -p "{\"spec\":{\"template\":{\"spec\":{\"domain\":{\"resources\":{\"requests\":{\"memory\":\"$new_memory\"}}}}}}}"
}

restart_vm_if_running() {
    local vm_name=$1
    local namespace=$2

    if is_vm_running "$vm_name" "$namespace"; then
        log_message "VM is running. Restarting to apply changes..."
        oc patch vm "$vm_name" -n "$namespace" --type merge -p '{"spec":{"running":false}}'
        while oc get vmi "$vm_name" -n "$namespace" &>/dev/null; do
            sleep 5
        done
        oc patch vm "$vm_name" -n "$namespace" --type merge -p '{"spec":{"running":true}}'
        oc wait --for=condition=Ready vmi "$vm_name" -n "$namespace" --timeout=300s
        log_message "VM restarted successfully"
    else
        log_message "VM is not running. Changes will take effect on next start."
    fi
}

main() {
    VM_NAME=$1
    NAMESPACE=$DEFAULT_NAMESPACE
    NEW_CPU=""
    NEW_MEMORY=""

    validate_input "$VM_NAME"
    shift

    while [[ $# -gt 0 ]]; do
        case $1 in
            --cpu) NEW_CPU=$2; shift 2 ;;
            --memory) NEW_MEMORY=$2; shift 2 ;;
            --namespace) NAMESPACE=$2; shift 2 ;;
            *) echo "Unknown option: $1"; exit 1 ;;
        esac
    done

    if [[ -z "$NEW_CPU" && -z "$NEW_MEMORY" ]]; then
        echo "Error: At least one scaling option (--cpu or --memory) must be provided"
        exit 1
    fi

    log_message "Starting VM scaling process for $VM_NAME"
    check_vm_exists "$VM_NAME" "$NAMESPACE"

    [[ -n "$NEW_CPU" ]] && scale_cpu "$VM_NAME" "$NAMESPACE" "$NEW_CPU"
    [[ -n "$NEW_MEMORY" ]] && scale_memory "$VM_NAME" "$NAMESPACE" "$NEW_MEMORY"

    restart_vm_if_running "$VM_NAME" "$NAMESPACE"

    log_message "VM scaling process completed successfully"
}

main "$@"
