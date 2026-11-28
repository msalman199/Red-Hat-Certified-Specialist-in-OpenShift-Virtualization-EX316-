#!/bin/bash
MAINTENANCE_NODE=$1
if [ -z "$MAINTENANCE_NODE" ]; then
    echo "Usage: $0 <maintenance-node-name>"
    exit 1
fi

# Function to display header
show_header() {
    clear
    echo "=========================================="
    echo "OpenShift Node Maintenance Monitor"
    echo "Node: $MAINTENANCE_NODE"
    echo "Time: $(date)"
    echo "=========================================="
    echo ""
}

# Function to show node status
show_node_status() {
    echo "NODE STATUS:"
    echo "------------"
    oc get node $MAINTENANCE_NODE -o custom-columns=NAME:.metadata.name,STATUS:.status.conditions[-1].type,SCHEDULABLE:.spec.unschedulable,READY:.status.conditions[?@.type==\"Ready\"].status
    echo ""
}

# Function to show VM status
show_vm_status() {
    echo "VIRTUAL MACHINE STATUS:"
    echo "----------------------"
    
    # VMs on maintenance node
    VMS_ON_NODE=$(oc get vmi -A --field-selector spec.nodeName=$MAINTENANCE_NODE --no-headers 2>/dev/null | wc -l)
    echo "VMs remaining on maintenance node: $VMS_ON_NODE"
    
    if [ "$VMS_ON_NODE" -gt 0 ]; then
        echo "VMs still on $MAINTENANCE_NODE:"
        oc get vmi -A --field-selector spec.nodeName=$MAINTENANCE_NODE -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name,PHASE:.status.phase,READY:.status.conditions[?@.type==\"Ready\"].status
    fi
    echo ""
    
    # All VMs status
    echo "All VMs in cluster:"
    oc get vmi -A -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name,PHASE:.status.phase,NODE:.status.nodeName,READY:.status.conditions[?@.type==\"Ready\"].status
    echo ""
}

# Function to show migration status
show_migration_status() {
    echo "MIGRATION STATUS:"
    echo "----------------"
    MIGRATIONS=$(oc get vmim -A --no-headers 2>/dev/null | wc -l)
    if [ "$MIGRATIONS" -gt 0 ]; then
        oc get vmim -A -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name,PHASE:.status.phase,SOURCE:.spec.vmiName
    else
        echo "No active migrations"
    fi
    echo ""
}

# Function to show pod status
show_pod_status() {
    echo "POD STATUS ON MAINTENANCE NODE:"
    echo "------------------------------"
    PODS_ON_NODE=$(oc get pods -A --field-selector spec.nodeName=$MAINTENANCE_NODE --no-headers 2>/dev/null | wc -l)
    echo "Pods remaining on maintenance node: $PODS_ON_NODE"
    
    if [ "$PODS_ON_NODE" -gt 0 ]; then
        echo "Pods still on $MAINTENANCE_NODE:"
        oc get pods -A --field-selector spec.nodeName=$MAINTENANCE_NODE -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name,STATUS:.status.phase
    fi
    echo ""
}

# Main monitoring loop
while true; do
    show_header
    show_node_status
    show_vm_status
    show_migration_status
    show_pod_status
    
    echo "Press Ctrl+C to exit monitoring"
    echo "Next update in 30 seconds..."
    sleep 30
done
