#!/bin/bash

echo "=== OpenShift Virtualization Status Check ==="
echo

echo "1. Checking HyperConverged status:"
oc get hco -n openshift-cnv
echo

echo "2. Checking operator CSV status:"
oc get csv -n openshift-cnv
echo

echo "3. Checking core component status:"
echo "KubeVirt:"
oc get kubevirt -n openshift-cnv
echo "CDI:"
oc get cdi -n openshift-cnv
echo "SSP:"
oc get ssp -n openshift-cnv
echo "NetworkAddonsConfig:"
oc get networkaddonsconfig -n openshift-cnv
echo

echo "4. Checking pod status in openshift-cnv:"
oc get pods -n openshift-cnv
echo

echo "5. Checking if virtualization is ready:"
if oc get hco -n openshift-cnv kubevirt-hyperconverged -o jsonpath='{.status.conditions[?(@.type=="Available")].status}' | grep -q "True"; then
    echo "✓ OpenShift Virtualization is READY"
else
    echo "✗ OpenShift Virtualization is NOT READY"
fi
