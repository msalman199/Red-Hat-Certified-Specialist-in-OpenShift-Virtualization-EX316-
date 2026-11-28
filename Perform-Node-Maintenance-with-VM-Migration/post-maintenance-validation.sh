#!/bin/bash
MAINTENANCE_NODE=$1

echo "Post-Maintenance Cluster Validation"
echo "==================================="
echo "Validation Time: $(date)"
echo "Maintained Node: $MAINTENANCE_NODE"
echo ""

# Check cluster nodes
echo "1. CLUSTER NODE STATUS:"
echo "----------------------"
oc get nodes -o custom-columns=NAME:.metadata.name,STATUS:.status.conditions[-1].type,SCHEDULABLE:.spec.unschedulable,VERSION:.status.nodeInfo.kubeletVersion
echo ""

# Check VM distribution
echo "2. VM DISTRIBUTION:"
echo "------------------"
for node in $(oc get nodes --no-headers -o custom-columns=NAME:.metadata.name); do
    vm_count=$(oc get vmi -A --field-selector spec.nodeName=$node --no-headers 2>/dev/null | wc -l)
    echo "Node $node: $vm_count VMs"
done
echo ""

# Check all VMs are running
echo "3. VM STATUS SUMMARY:"
echo "--------------------"
TOTAL_VMS=$(oc get vm -A --no-headers | wc -l)
RUNNING_VMS=$(oc get vm -A --no-headers -o custom-columns=STATUS:.status.printableStatus | grep -c "Running")
STOPPED_VMS=$(oc get vm -A --no-headers -o custom-columns=STATUS:.status.printableStatus | grep -c "Stopped")

echo "Total VMs: $TOTAL_VMS"
echo "Running VMs: $RUNNING_VMS"
echo "Stopped VMs: $STOPPED_VMS"
echo ""

# Check for any failed migrations
echo "4. MIGRATION STATUS:"
echo "-------------------"
FAILED_MIGRATIONS=$(oc get vmim -A --no-headers -o custom-columns=PHASE:.status.phase 2>/dev/null | grep -c "Failed" || echo "0")
SUCCESSFUL_MIGRATIONS=$(oc get vmim -A --no-headers -o custom-columns=PHASE:.status.phase 2>/dev/null | grep -c "Succeeded" || echo "0")

echo "Failed migrations: $FAILED_MIGRATIONS"
echo "Successful migrations: $SUCCESSFUL_MIGRATIONS"
echo ""

# Overall health assessment
echo "5. OVERALL HEALTH ASSESSMENT:"
echo "-----------------------------"
if [ "$FAILED_MIGRATIONS" -eq 0 ] && [ "$RUNNING_VMS" -gt 0 ]; then
    echo "✅ Cluster health: GOOD"
    echo "✅ Node maintenance completed successfully"
    echo "✅ All VMs operational"
else
    echo "⚠️  Cluster health: NEEDS ATTENTION"
    echo "⚠️  Review failed migrations or VM issues"
fi

echo ""
echo "Validation completed at $(date)"
