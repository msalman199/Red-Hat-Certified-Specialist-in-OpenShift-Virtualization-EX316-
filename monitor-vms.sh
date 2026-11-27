#!/bin/bash
echo "Starting VM monitoring..."
while true; do
    echo "=== $(date) ==="
    echo "VM Status:"
    kubectl get vmi -o wide
    echo ""
    echo "Node Status:"
    kubectl get nodes
    echo ""
    echo "Migration Status:"
    kubectl get vmim 2>/dev/null || echo "No active migrations"
    echo "================================"
    sleep 10
done
