#!/bin/bash

echo "=== VMI Status Overview ==="
oc get vmi -o custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.status.nodeName,IP:.status.interfaces[0].ipAddress

echo -e "\n=== VMI Resource Usage ==="
for vmi in $(oc get vmi -o jsonpath='{.items[*].metadata.name}'); do
    echo "VMI: $vmi"
    pod=$(oc get pods -l kubevirt.io/created-by=$vmi -o jsonpath='{.items[0].metadata.name}')
    if [ ! -z "$pod" ]; then
        oc top pod $pod 2>/dev/null || echo "  Resource metrics not available"
    fi
    echo ""
done

echo "=== Recent VMI Events ==="
oc get events --field-selector involvedObject.kind=VirtualMachineInstance --sort-by='.lastTimestamp' | tail -10
