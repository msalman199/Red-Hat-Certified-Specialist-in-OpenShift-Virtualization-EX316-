#!/bin/bash

SOURCE_NODE=${1}
TARGET_NODE=${2}

if [ -z "$SOURCE_NODE" ] || [ -z "$TARGET_NODE" ]; then
    echo "Usage: $0 <source-node> <target-node>"
    exit 1
fi

echo "Migrating all VMs from $SOURCE_NODE to $TARGET_NODE"

# Get all VMIs running on the source node
VMIS=$(oc get vmi -A -o jsonpath='{range .items[?(@.status.nodeName=="'$SOURCE_NODE'")]}{.metadata.namespace}{" "}{.metadata.name}{"\n"}{end}')

if [ -z "$VMIS" ]; then
    echo "No VMs found on node $SOURCE_NODE"
    exit 0
fi

echo "Found VMs to migrate:"
echo "$VMIS"
echo ""

# Migrate each VM
echo "$VMIS" | while read namespace vm_name; do
    if [ -n "$vm_name" ]; then
        echo "Migrating $vm_name in namespace $namespace..."
        cat << MIGRATION_EOF | oc apply -f -
apiVersion: kubevirt.io/v1
kind: VirtualMachineInstanceMigration
metadata:
  name: ${vm_name}-maintenance-migration
  namespace: $namespace
spec:
  vmiName: $vm_name
  nodeSelector:
    kubernetes.io/hostname: $TARGET_NODE
MIGRATION_EOF
        echo "Migration initiated for $vm_name"
        sleep 2
    fi
done

echo ""
echo "All migrations initiated. Monitor with: oc get vmim -A"
