#!/bin/bash

# Kubernetes Multi-Tenancy Platform Installation Script
# This script bootstraps the entire platform by installing ArgoCD,
# which then manages the deployment of all other components

set -e

echo "==== Kubernetes Multi-Tenancy Platform Installation ===="
echo "This script will install ArgoCD and bootstrap all platform components"

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "Error: kubectl is not installed or not in the PATH"
    exit 1
fi

# Check if the cluster is accessible
if ! kubectl get nodes &> /dev/null; then
    echo "Error: Cannot connect to Kubernetes cluster. Please check your kubeconfig."
    exit 1
fi

echo "✓ Kubernetes cluster is accessible"

# Create ArgoCD namespace if it doesn't exist
if ! kubectl get namespace argocd &> /dev/null; then
    echo "Creating argocd namespace..."
    kubectl create namespace argocd
else
    echo "✓ Namespace argocd already exists"
fi

# Apply the bootstrap application
echo "Applying bootstrap application to install ArgoCD..."
kubectl apply -f bootstrap.yaml

echo "Waiting for ArgoCD to become ready..."
# Wait for ArgoCD server pod to be ready
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=300s

echo "✓ ArgoCD is now installed and configured!"
echo "✓ The platform components will now be deployed automatically by ArgoCD"

# Get the ArgoCD admin password
ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo ""
echo "==== Next Steps ===="
echo "1. Access the ArgoCD UI by running:"
echo "   kubectl port-forward svc/argocd-server -n argocd 8080:443"
echo ""
echo "2. Login with:"
echo "   Username: admin"
echo "   Password: $ARGOCD_PASSWORD"
echo ""
echo "3. Monitor the deployment of platform components in the ArgoCD UI"
echo ""
echo "See INSTALL.md for more detailed instructions and next steps"
echo "==============================================="
