#!/bin/bash
NODE=$1
if [ -z "$NODE" ]; then
    echo "Usage: $0 <node-name>"
    exit 1
fi

echo "Monitoring drain progress for node: $NODE"
echo "========================================"

while true; do
    echo "$(date): Checking node status..."
    
    # Check if node is unschedulable
    UNSCHEDULABLE=$(oc get node $NODE -o jsonpath='{.spec.unschedulable}')
    echo "Node unschedulable: $UNSCHEDULABLE"
    
    # Count remaining pods
    POD_COUNT=$(oc get pods -A --field-selector spec.nodeName=$NODE --no-headers 2>/dev/null | wc -l)
    echo "Remaining pods: $POD_COUNT"
    
    # Count remaining VMs
    VM_COUNT=$(oc get vmi -A --field-selector spec.nodeName=$NODE --no-headers 2>/dev/null | wc -l)
    echo "Remaining VMs: $VM_COUNT"
    
    if [ "$VM_COUNT" -eq 0 ] && [ "$POD_COUNT" -eq 0 ]; then
        echo "Node successfully drained!"
        break
    fi
    
    echo "Waiting 30 seconds..."
    echo "------------------------"
    sleep 30
done
