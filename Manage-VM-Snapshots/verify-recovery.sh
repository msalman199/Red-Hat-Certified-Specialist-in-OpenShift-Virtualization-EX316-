#!/bin/bash

VM_NAME="test-vm"
VM_IP="vm-ip-address"  # Replace with actual IP

echo "=== VM Recovery Verification ==="
echo "VM Status: $(sudo virsh list | grep $VM_NAME | awk '{print $3}')"
echo "Current Snapshot: $(sudo virsh snapshot-current $VM_NAME --name 2>/dev/null || echo 'None')"

# Wait for VM to be accessible
echo "Waiting for VM to be accessible..."
timeout=120
while ! ping -c 1 "$VM_IP" >/dev/null 2>&1 && [ $timeout -gt 0 ]; do
    sleep 2
    timeout=$((timeout-2))
done

if [ $timeout -gt 0 ]; then
    echo "VM is accessible via network"
    echo "Verifying file system state..."
    ssh -o ConnectTimeout=10 user@"$VM_IP" "ls -la /tmp/ | head -10"
else
    echo "VM is not accessible via network"
fi
