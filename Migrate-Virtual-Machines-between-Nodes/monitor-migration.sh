#!/bin/bash

VM_NAME=${1:-migration-test-vm}
NAMESPACE=${2:-default}

echo "Monitoring migration for VM: $VM_NAME in namespace: $NAMESPACE"
echo "=================================================="

while true; do
    clear
    echo "Current time: $(date)"
    echo ""
    
    echo "VM Instance Status:"
    oc get vmi $VM_NAME -n $NAMESPACE -o wide 2>/dev/null || echo "VM not found"
    echo ""
    
    echo "Migration Status:"
    oc get vmim -n $NAMESPACE 2>/dev/null || echo "No migrations found"
    echo ""
    
    echo "Recent Events:"
    oc get events -n $NAMESPACE --sort-by='.lastTimestamp' | tail -5
    echo ""
    
    sleep 5
done
