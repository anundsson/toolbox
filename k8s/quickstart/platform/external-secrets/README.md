# External Secrets Operator Quickstart

This folder contains instructions and manifests for installing External Secrets Operator (ESO) in your cluster.

## Installation (Helm)

1. Add the Helm repo:

   ```sh
   helm repo add external-secrets https://charts.external-secrets.io
   helm repo update
   ```

2. Install ESO:

   ```sh
   helm install external-secrets external-secrets/external-secrets -n external-secrets --create-namespace
   ```

## Resources
- [External Secrets Operator Docs](https://external-secrets.io/)
