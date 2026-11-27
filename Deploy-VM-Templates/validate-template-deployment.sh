#!/bin/bash
set -uo pipefail

NAMESPACE="vm-templates"
PASSED=0
FAILED=0

# validate_vm checks one VM against its expected template label and running state.
validate_vm() {
    local vm_name=$1
    local expected_template=$2

    echo "Validating VM: $vm_name"

    # TODO 1: check the VM exists with "oc get vm $vm_name -n $NAMESPACE >/dev/null 2>&1"
    #         if it does not exist, print a failure message, increment FAILED, and return.

    # TODO 2: read the actual template label
    #         (path: .metadata.labels.template) and compare it to $expected_template.
    #         Print PASS/FAIL and increment PASSED or FAILED accordingly.

    # TODO 3: read the VM status (.status.printableStatus) and check it equals "Running".
    #         Print PASS/FAIL and increment PASSED or FAILED accordingly.

    # TODO 4: if status is Running, also confirm a matching VMI exists
    #         ("oc get vmi $vm_name -n $NAMESPACE"). Print PASS/FAIL and update counters.

    echo
}

echo "=== Template Deployment Validation ==="
echo

validate_vm "basic-vm-01" "basic-vm"
validate_vm "basic-vm-02" "basic-vm"
validate_vm "basic-vm-03" "basic-vm"
validate_vm "advanced-vm-01" "advanced-vm"
validate_vm "postgres-vm-01" "database-vm"

echo "Validating Persistent Volume Claims:"
# TODO 5: for each PVC in (advanced-vm-01-disk, postgres-vm-01-db-disk, postgres-vm-01-log-disk),
#         check it exists and that .status.phase equals "Bound". Update PASSED/FAILED.

echo
echo "=== Validation Summary ==="
echo "Passed: $PASSED"
echo "Failed: $FAILED"

if [ "$FAILED" -eq 0 ]; then
    echo "All validations passed."
    exit 0
else
    echo "Some validations failed. Review the output above."
    exit 1
fi
