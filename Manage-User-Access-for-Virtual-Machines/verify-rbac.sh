#!/bin/bash

echo "=== RBAC Verification Script ==="
echo

# Test Admin User
echo "Testing VM Administrator permissions:"
kubectl auth can-i create vm --as=system:serviceaccount:vm-lab:vm-admin-user -n vm-lab
kubectl auth can-i delete vm --as=system:serviceaccount:vm-lab:vm-admin-user -n vm-lab
kubectl auth can-i get vm --as=system:serviceaccount:vm-lab:vm-admin-user -n vm-lab
echo

# Test Operator User
echo "Testing VM Operator permissions:"
kubectl auth can-i create vm --as=system:serviceaccount:vm-lab:vm-operator-user -n vm-lab
kubectl auth can-i delete vm --as=system:serviceaccount:vm-lab:vm-operator-user -n vm-lab
kubectl auth can-i get vm --as=system:serviceaccount:vm-lab:vm-operator-user -n vm-lab
echo

# Test Viewer User
echo "Testing VM Viewer permissions:"
kubectl auth can-i create vm --as=system:serviceaccount:vm-lab:vm-viewer-user -n vm-lab
kubectl auth can-i delete vm --as=system:serviceaccount:vm-lab:vm-viewer-user -n vm-lab
kubectl auth can-i get vm --as=system:serviceaccount:vm-lab:vm-viewer-user -n vm-lab
echo

echo "=== Verification Complete ==="
