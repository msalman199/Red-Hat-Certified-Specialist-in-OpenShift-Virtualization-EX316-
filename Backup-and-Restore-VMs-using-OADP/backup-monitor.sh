#!/bin/bash

echo "=== OADP Backup Status Report ==="
echo "Date: $(date)"
echo

echo "=== Recent Backups ==="
oc get backup -n openshift-adp --sort-by=.metadata.creationTimestamp

echo
echo "=== Backup Storage Locations ==="
oc get backupstoragelocation -n openshift-adp

echo
echo "=== Failed Backups (if any) ==="
oc get backup -n openshift-adp -o json | jq -r '.items[] | select(.status.phase == "Failed") | .metadata.name'

echo
echo "=== Storage Usage ==="
oc get pvc -n openshift-adp
