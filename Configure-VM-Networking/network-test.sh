#!/bin/bash

echo "=== VM Networking Lab Verification ==="

# Test 1: Check VMs are running
echo "1. Checking VM status..."
oc get vms -n vm-networking-lab
oc get vmis -n vm-networking-lab

# Test 2: Verify network policies
echo "2. Checking network policies..."
oc get networkpolicies -n vm-networking-lab

# Test 3: Check network attachment definitions
echo "3. Checking network attachment definitions..."
oc get network-attachment-definitions -n vm-networking-lab

# Test 4: Verify VM network interfaces
echo "4. Checking VM network interfaces..."
for vm in vm1-static vm2-static; do
    echo "Checking $vm network configuration..."
    oc describe vmi $vm -n vm-networking-lab | grep -A 10 "Networks:"
done

echo "=== Verification Complete ==="
