#!/bin/bash
SOURCE_NODE=$1
if [ -z "$SOURCE_NODE" ]; then
    echo "Usage: $0 <source-node-name>"
    exit 1
fi

echo "Monitoring VM migration from node: $SOURCE_NODE"
echo "=============================================="

# Get initial VM list
INITIAL_VMS=$(oc get vmi -A --field-selector spec.nodeName=$SOURCE_NODE --no-headers -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name | tr ' ' ':')

if [ -z "$INITIAL_VMS" ]; then
    echo "No VMs found on source node"
    exit 0
fi

echo "VMs to migrate:"
echo "$INITIAL_VMS" | tr ':' ' '
echo ""

while true; do
    echo "$(date): Checking migration status..."
    
    for vm_info in $INITIAL_VMS; do
        NAMESPACE=$(echo $vm_info | cut -d':' -f1)
        VM_NAME=$(echo $vm_info | cut -d':' -f2)
        
        # Check current VM location
        CURRENT_NODE=$(oc get vmi $VM_NAME -n $NAMESPACE -o jsonpath='{.status.nodeName}' 2>/dev/null)
        PHASE=$(oc get vmi $VM_NAME -n $NAMESPACE -o jsonpath='{.status.phase}' 2>/dev/null)
        
        if [ "$CURRENT_NODE" != "$SOURCE_NODE" ]; then
            echo "✓ VM $NAMESPACE/$VM_NAME migrated to: $CURRENT_NODE (Phase: $PHASE)"
        else
            echo "⏳ VM $NAMESPACE/$VM_NAME still on: $CURRENT_NODE (Phase: $PHASE)"
        fi
    done
    
    # Check if any VMs remain on source node
    REMAINING=$(oc get vmi -A --field-selector spec.nodeName=$SOURCE_NODE --no-headers 2>/dev/null | wc -l)
    
    if [ "$REMAINING" -eq 0 ]; then
        echo ""
        echo "✅ All VMs successfully migrated from $SOURCE_NODE"
        break
    fi
    
    echo "Remaining VMs on source node: $REMAINING"
    echo "------------------------"
    sleep 15
done
