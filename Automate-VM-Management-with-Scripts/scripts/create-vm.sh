#!/bin/bash

# VM Creation Automation Script
# Usage: ./create-vm.sh <vm-name> [cpu-cores] [memory] [namespace]

set -e

source "$(dirname "$0")/../config/vm-defaults.conf"

log_message() {
    mkdir -p "$LOG_DIR"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_DIR/vm-creation.log"
}

validate_input() {
    if [[ -z "$1" ]]; then
        echo "Error: VM name is required"
        echo "Usage: $0 <vm-name> [cpu-cores] [memory] [namespace]"
        exit 1
    fi
}

check_vm_exists() {
    local vm_name=$1
    local namespace=$2

    if oc get vm "$vm_name" -n "$namespace" &>/dev/null; then
        log_message "ERROR: VM $vm_name already exists in namespace $namespace"
        exit 1
    fi
}

create_vm() {
    local vm_name=$1
    local cpu_cores=$2
    local memory=$3
    local namespace=$4

    log_message "Creating VM: $vm_name with $cpu_cores CPU, $memory memory"

    oc create namespace "$namespace" --dry-run=client -o yaml | oc apply -f - >/dev/null

    cat > "/tmp/${vm_name}-vm.yaml" << VMEOF
apiVersion: kubevirt.io/v1
kind: VirtualMachine
metadata:
  name: $vm_name
  namespace: $namespace
  labels:
    app: automated-vm
    created-by: automation-script
spec:
  running: false
  template:
    metadata:
      labels:
        kubevirt.io/vm: $vm_name
    spec:
      domain:
        cpu:
          cores: $cpu_cores
        resources:
          requests:
            memory: $memory
        devices:
          disks:
          - name: containerdisk
            disk:
              bus: virtio
          - name: cloudinitdisk
            disk:
              bus: virtio
          interfaces:
          - name: default
            masquerade: {}
      networks:
      - name: default
        pod: {}
      volumes:
      - name: containerdisk
        containerDisk:
          image: quay.io/kubevirt/fedora-cloud-container-disk-demo
      - name: cloudinitdisk
        cloudInitNoCloud:
          userData: |
            #cloud-config
            password: fedora
            chpasswd: { expire: False }
            ssh_pwauth: True
VMEOF

    oc apply -f "/tmp/${vm_name}-vm.yaml"
    rm "/tmp/${vm_name}-vm.yaml"

    log_message "VM $vm_name created successfully in namespace $namespace"
}

start_vm() {
    local vm_name=$1
    local namespace=$2

    log_message "Starting VM: $vm_name"
    oc patch vm "$vm_name" -n "$namespace" --type merge -p '{"spec":{"running":true}}'

    log_message "Waiting for VM to be ready..."
    oc wait --for=condition=Ready vmi "$vm_name" -n "$namespace" --timeout=300s

    log_message "VM $vm_name is now running"
}

main() {
    VM_NAME=$1
    CPU_CORES=${2:-$DEFAULT_CPU_CORES}
    MEMORY=${3:-$DEFAULT_MEMORY}
    NAMESPACE=${4:-$DEFAULT_NAMESPACE}

    validate_input "$VM_NAME"

    log_message "Starting VM creation process for $VM_NAME"

    check_vm_exists "$VM_NAME" "$NAMESPACE"
    create_vm "$VM_NAME" "$CPU_CORES" "$MEMORY" "$NAMESPACE"
    start_vm "$VM_NAME" "$NAMESPACE"

    log_message "VM creation process completed successfully"
}

main "$@"
