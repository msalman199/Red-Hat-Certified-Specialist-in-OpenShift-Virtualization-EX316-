#!/bin/bash
set -euo pipefail

NAMESPACE="vm-templates"

# get_vm_resources reports scheduling and resource usage for one VM.
get_vm_resources() {
    local vm_name=$1
    echo "VM: $vm_name"

    if oc get vmi $vm_name -n $NAMESPACE >/dev/null 2>&1; then
        # TODO 1: print the node name the VMI is running on
        #         (path: .status.nodeName)
        echo "  Node: <TODO>"

        # TODO 2: print the VMI phase
        #         (path: .status.phase)
        echo "  Phase: <TODO>"

        # TODO 3: find the virt-launcher pod name for this VM using the
        #         label selector kubevirt.io/domain=$vm_name, then use
        #         "oc top pod <pod> -n $NAMESPACE --no-headers" to extract
        #         the CPU (column 2) and memory (column 3) usage.
        local pod_name
        pod_name=$(oc get pods -n $NAMESPACE -l kubevirt.io/domain=$vm_name -o jsonpath='{.items[0].metadata.name}' 2>/dev/null || true)
        if [ -n "$pod_name" ]; then
            echo "  Pod: $pod_name"
            echo "  CPU Usage: <TODO>"
            echo "  Memory Usage: <TODO>"
        fi
    else
        echo "  Status: VMI not found or not running"
    fi
    echo
}

echo "=== VM Performance Monitoring ==="
echo

# TODO 4: call get_vm_resources for all five deployed VMs
