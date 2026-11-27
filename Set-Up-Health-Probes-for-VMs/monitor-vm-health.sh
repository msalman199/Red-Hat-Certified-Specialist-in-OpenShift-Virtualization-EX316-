#!/bin/bash

VM_NAME="webserver-vm-full-probes"
NAMESPACE="vm-health-probes"

echo "=== VM Health Monitor ==="
echo "Monitoring VM: $VM_NAME in namespace: $NAMESPACE"
echo "Press Ctrl+C to stop"
echo

while true; do
    clear
    echo "=== VM Status at $(date) ==="
    
    # Get VM basic status
    echo "VM Status:"
    oc get vmi $VM_NAME -o custom-columns=NAME:.metadata.name,PHASE:.status.phase,READY:.status.conditions[?(@.type==\"Ready\")].status,AGE:.metadata.creationTimestamp
    
    echo
    echo "Probe Status:"
    # Check readiness probe
    READY_STATUS=$(oc get vmi $VM_NAME -o jsonpath='{.status.conditions[?(@.type=="Ready")].status}')
    echo "Readiness Probe: $READY_STATUS"
    
    # Get recent events
    echo
    echo "Recent Events:"
    oc get events --sort-by='.lastTimestamp' --field-selector involvedObject.name=$VM_NAME | tail -5
    
    sleep 10
done
