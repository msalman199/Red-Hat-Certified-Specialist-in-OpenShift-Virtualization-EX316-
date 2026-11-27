#!/bin/bash

VM_NAME=${1:-migration-test-vm}
NAMESPACE=${2:-default}

echo "Performance Test for VM: $VM_NAME"
echo "=================================="

echo "Testing VM responsiveness..."
start_time=$(date +%s%N)
virtctl ssh fedora@$VM_NAME -n $NAMESPACE --command="echo 'VM Response Test'" 2>/dev/null
end_time=$(date +%s%N)
response_time=$(( (end_time - start_time) / 1000000 ))
echo "VM response time: ${response_time}ms"

echo ""
echo "Checking VM resource usage..."
oc top pod -l kubevirt.io/vm=$VM_NAME -n $NAMESPACE

echo ""
echo "Verifying VM network performance..."
virtctl ssh fedora@$VM_NAME -n $NAMESPACE --command="curl -s -w 'Total time: %{time_total}s\n' -o /dev/null http://httpbin.org/get" 2>/dev/null || echo "Network test skipped (VM may not have curl installed)"
