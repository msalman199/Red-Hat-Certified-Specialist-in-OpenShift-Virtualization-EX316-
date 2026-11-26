#!/bin/bash

VM_NAME=${1:-comprehensive-vm}

echo "=== Virtual Machine Resource Hierarchy ==="
echo "VM Name: $VM_NAME"
echo

echo "1. Virtual Machine (VM):"
oc get vm $VM_NAME -o custom-columns=NAME:.metadata.name,RUNNING:.spec.running,AGE:.metadata.creationTimestamp --no-headers 2>/dev/null || echo "   VM not found"

echo
echo "2. Virtual Machine Instance (VMI):"
oc get vmi $VM_NAME -o custom-columns=NAME:.metadata.name,PHASE:.status.phase,NODE:.status.nodeName,AGE:.metadata.creationTimestamp --no-headers 2>/dev/null || echo "   VMI not running"

echo
echo "3. Virt-Launcher Pod:"
LAUNCHER_POD=$(oc get pods -l kubevirt.io/vm=$VM_NAME -o jsonpath='{.items[0].metadata.name}' 2>/dev/null)
if [ ! -z "$LAUNCHER_POD" ]; then
    oc get pod $LAUNCHER_POD -o custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName,AGE:.metadata.creationTimestamp --no-headers
else
    echo "   Launcher pod not found"
fi

echo
echo "4. Related Services:"
oc get svc -l kubevirt.io/vm=$VM_NAME --no-headers 2>/dev/null || echo "   No services found"

echo
echo "=== Resource Details ==="
if [ ! -z "$LAUNCHER_POD" ]; then
    echo "Pod Resource Usage:"
    oc top pod $LAUNCHER_POD 2>/dev/null || echo "   Metrics not available"
fi
