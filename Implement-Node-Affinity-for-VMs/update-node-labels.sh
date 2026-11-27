#!/bin/bash

# Script to update node labels based on resource usage
echo "Monitoring node resources and updating labels..."

for node in $(kubectl get nodes -o jsonpath='{.items[*].metadata.name}'); do
    echo "Processing node: $node"
    
    # Get memory usage percentage
    memory_usage=$(kubectl top node $node --no-headers | awk '{print $4}' | sed 's/%//')
    
    # Update labels based on memory usage
    if [ "$memory_usage" -lt 50 ]; then
        kubectl label nodes $node memory-pressure=low --overwrite
        echo "  Set memory-pressure=low for $node (usage: ${memory_usage}%)"
    elif [ "$memory_usage" -lt 80 ]; then
        kubectl label nodes $node memory-pressure=medium --overwrite
        echo "  Set memory-pressure=medium for $node (usage: ${memory_usage}%)"
    else
        kubectl label nodes $node memory-pressure=high --overwrite
        echo "  Set memory-pressure=high for $node (usage: ${memory_usage}%)"
    fi
done

echo "Node label updates completed."
