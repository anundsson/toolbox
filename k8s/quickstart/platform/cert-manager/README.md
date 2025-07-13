# Cert Manager Quickstart

This folder contains instructions for installing cert-manager, which provides automated certificate management in Kubernetes.

## Installation (Helm)

1. Add the Helm repo:

   ```sh
   helm repo add jetstack https://charts.jetstack.io
   helm repo update
   ```

2. Install cert-manager:

   ```sh
   helm install cert-manager jetstack/cert-manager \
     --namespace cert-manager \
     --create-namespace \
     --version v1.14.3 \
     --set installCRDs=true \
     --values values.yaml
   ```

## Resources

- [cert-manager Documentation](https://cert-manager.io/docs/)
