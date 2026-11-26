#!/bin/bash

echo "=== Lab 3 Validation Script ==="
echo "Checking VMI deployment and configuration..."

# Function to check VMI status
check_vmi() {
    local vmi_name=$1
    local expected_status="Running"
    
    echo -n "Checking VMI $vmi_name: "
    status=$(oc get vmi $vmi_name -o jsonpath='{.status.phase}' 2>/dev/null)
    
    if [ "$status" = "$expected_status" ]; then
        echo "✓ PASS (Status: $status)"
        return 0
    else
        echo "✗ FAIL (Status: $status, Expected: $expected_status)"
        return 1
    fi
}

# Function to check resource allocation
check_resources() {
    local vmi_name=$1
    local expected_cpu=$2
    local expected_memory=$3
    
    echo -n "Checking $vmi_name resources: "
    cpu=$(oc get vmi $vmi_name -o jsonpath='{.spec.domain.cpu.cores}' 2>/dev/null)
    memory=$(oc get vmi $vmi_name -o jsonpath='{.spec.domain.memory.guest}' 2>/dev/null)
    
    if [ "$cpu" = "$expected_cpu" ] && [ "$memory" = "$expected_memory" ]; then
        echo "✓ PASS (CPU: $cpu, Memory: $memory)"
        return 0
    else
        echo "✗ FAIL (CPU: $cpu/$expected_cpu, Memory: $memory/$expected_memory)"
        return 1
    fi
}

# Validation tests
echo -e "\n1. Basic VMI Tests:"
check_vmi "basic-vmi"
check_resources "basic-vmi" "1" "1Gi"

echo -e "\n2. CPU-Optimized VMI Tests:"
check_vmi "cpu-optimized-vmi"
check_resources "cpu-optimized-vmi" "2" "2Gi"

echo -e "\n3. Storage VMI Tests:"
check_vmi "storage-vmi"
echo -n "Checking PVC: "
pvc_status=$(oc get pvc vmi-disk-pvc -o jsonpath='{.status.phase}' 2>/dev/null)
if [ "$pvc_status" = "Bound" ]; then
    echo "✓ PASS (PVC Status: $pvc_status)"
else
    echo "✗ FAIL (PVC Status: $pvc_status)"
fi

echo -e "\n4. Memory-Optimized VMI Tests:"
check_vmi "memory-optimized-vmi"
check_resources "memory-optimized-vmi" "1" "4Gi"

echo -e "\n5. Secure VMI Tests:"
check_vmi "secure-vmi"

echo -e "\n6. Resource Quota Tests:"
echo -n "Checking resource quota: "
quota_status=$(oc get quota vmi-quota -o jsonpath='{.status}' 2>/dev/null)
if [ ! -z "$quota_status" ]; then
    echo "✓ PASS (Quota configured)"
else
    echo "✗ FAIL (Quota not found)"
fi

echo -e "\n=== Validation Complete ==="
