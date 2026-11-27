#!/bin/bash
set -euo pipefail

NAMESPACE="vm-templates"

# get_vm_specs prints the key configuration fields for a single VM.
# TODO 1: Use "oc get vm <name> -n $NAMESPACE -o jsonpath=..." to print:
#         - CPU cores            (path: .spec.template.spec.domain.cpu.cores)
#         - Memory               (path: .spec.template.spec.domain.memory.guest)
#         - Template label       (path: .metadata.labels.template)
#         - Current status       (path: .status.printableStatus)
get_vm_specs() {
    local vm_name=$1
    echo "VM: $vm_name"
    # TODO 1: replace the placeholders below with real oc jsonpath commands
    echo "  CPU Cores: <TODO>"
    echo "  Memory: <TODO>"
    echo "  Template: <TODO>"
    echo "  Status: <TODO>"
    echo
}

echo "=== VM Configuration Consistency Check ==="
echo

echo "Basic Template VMs:"
# TODO 2: call get_vm_specs for basic-vm-01, basic-vm-02, basic-vm-03

echo "Advanced Template VMs:"
# TODO 3: call get_vm_specs for advanced-vm-01

echo "Database Template VMs:"
# TODO 4: call get_vm_specs for postgres-vm-01
