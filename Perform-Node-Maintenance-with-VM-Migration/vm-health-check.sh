#!/bin/bash
echo "VM Health Check Report"
echo "====================="
echo "Generated: $(date)"
echo ""

# Check all VMs
for vm in $(oc get vm -A --no-headers -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name | tr ' ' ':'); do
    NAMESPACE=$(echo $vm | cut -d':' -f1)
    VM_NAME=$(echo $vm | cut -d':' -f2)
    
    echo "Checking VM: $NAMESPACE/$VM_NAME"
    echo "--------------------------------"
    
    # Get VM status
    VM_STATUS=$(oc get vm $VM_NAME -n $NAMESPACE -o jsonpath='{.status.printableStatus}' 2>/dev/null)
    echo "VM Status: $VM_STATUS"
    
    # Get VMI status if running
    if [ "$VM_STATUS" = "Running" ]; then
        VMI_PHASE=$(oc get vmi $VM_NAME -n $NAMESPACE -o jsonpath='{.status.phase}' 2>/dev/null)
        VMI_NODE=$(oc get vmi $VM_NAME -n $NAMESPACE -o jsonpath='{.status.nodeName}' 2>/dev/null)
        VMI_READY=$(oc get vmi $VM_NAME -n $NAMESPACE -o jsonpath='{.status.conditions[?@.type=="Ready"].status}' 2>/dev/null)
        
        echo "VMI Phase: $VMI_PHASE"
        echo "Running on Node: $VMI_NODE"
        echo "Ready Status: $VMI_READY"
        
        # Check if VM has network connectivity
        VM_IP=$(oc get vmi $VM_NAME -n $NAMESPACE -o jsonpath='{.status.interfaces[0].ipAddress}' 2>/dev/null)
        if [ ! -z "$VM_IP" ]; then
            echo "VM IP Address: $VM_IP"
        fi
    fi
    
    echo ""
done

echo "Health Check Complete"
