#!/bin/bash

# Kubernetes Multi-Tenancy Platform Uninstall Script
# This script removes all platform components and ArgoCD

set -e

echo "==== Kubernetes Multi-Tenancy Platform Uninstallation ===="
echo "This script will remove all platform components and ArgoCD"
echo ""
echo "WARNING: This will delete all resources managed by ArgoCD!"
echo "Press CTRL+C now to abort, or press ENTER to continue..."
read -r

# Delete the ApplicationSet to cascade delete all applications
if kubectl get applicationset platform-components -n argocd &> /dev/null; then
    echo "Removing platform components ApplicationSet..."
    kubectl delete applicationset platform-components -n argocd
    
    echo "Waiting for applications to be removed..."
    sleep 10
fi

# Delete ArgoCD bootstrap application
if kubectl get application argocd-bootstrap -n argocd &> /dev/null; then
    echo "Removing ArgoCD bootstrap application..."
    kubectl delete application argocd-bootstrap -n argocd
    
    echo "Waiting for ArgoCD to finish cleanup..."
    sleep 10
fi

# Remove namespaces for all platform components
for ns in argocd kyverno gatekeeper-system external-secrets vault cert-manager monitoring keda istio-system; do
    if kubectl get namespace $ns &> /dev/null; then
        echo "Removing namespace: $ns..."
        kubectl delete namespace $ns --wait=false
    fi
done

echo ""
echo "✓ Uninstallation commands have been issued"
echo "Note: Namespace termination may take some time to complete"
echo "You can check the status with: kubectl get namespaces"
echo "==============================================="
