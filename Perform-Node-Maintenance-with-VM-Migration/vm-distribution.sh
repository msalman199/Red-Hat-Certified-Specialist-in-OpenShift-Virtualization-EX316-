#!/bin/bash
echo "VM Distribution Across Nodes:"
echo "=============================="
for node in $(oc get nodes --no-headers -o custom-columns=NAME:.metadata.name); do
    echo "Node: $node"
    oc get vmi -A --field-selector spec.nodeName=$node --no-headers -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name 2>/dev/null || echo "  No VMs running"
    echo ""
done
