#!/bin/bash

echo "=== Node Affinity Lab Summary ==="
echo ""

echo "Nodes and their labels:"
kubectl get nodes --show-labels | grep -E "(NAME|workload-type|memory-size|cpu-type)"
echo ""

echo "Running VMs and their node placement:"
for vm in $(kubectl get vmi -o jsonpath='{.items[*].metadata.name}'); do
    node=$(kubectl get vmi $vm -o jsonpath='{.status.nodeName}')
    echo "VM: $vm -> Node: $node"
done
echo ""

echo "Node resource usage:"
kubectl top nodes
echo ""

echo "Recent scheduling events:"
kubectl get events --sort-by='.lastTimestamp' | grep -i schedule | tail -5
