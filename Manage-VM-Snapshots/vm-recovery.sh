#!/bin/bash

VM_NAME="test-vm"
SNAPSHOT_NAME="$1"

if [ -z "$SNAPSHOT_NAME" ]; then
    echo "Usage: $0 <snapshot-name>"
    echo "Available snapshots:"
    sudo virsh snapshot-list "$VM_NAME" --name
    exit 1
fi

echo "Starting recovery process for VM: $VM_NAME"
echo "Target snapshot: $SNAPSHOT_NAME"

# Check if VM is running
if sudo virsh list --state-running | grep -q "$VM_NAME"; then
    echo "Shutting down VM..."
    sudo virsh shutdown "$VM_NAME"
    
    # Wait for shutdown
    timeout=60
    while sudo virsh list --state-running | grep -q "$VM_NAME" && [ $timeout -gt 0 ]; do
        sleep 2
        timeout=$((timeout-2))
    done
    
    if [ $timeout -le 0 ]; then
        echo "Force stopping VM..."
        sudo virsh destroy "$VM_NAME"
    fi
fi

# Perform rollback
echo "Reverting to snapshot: $SNAPSHOT_NAME"
if sudo virsh snapshot-revert "$VM_NAME" "$SNAPSHOT_NAME"; then
    echo "Rollback successful!"
    echo "Starting VM..."
    sudo virsh start "$VM_NAME"
    echo "Recovery completed successfully!"
else
    echo "Rollback failed!"
    exit 1
fi
