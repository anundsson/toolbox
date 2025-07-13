# Admission Controller Quickstart

This folder contains instructions for installing Kyverno, a popular Kubernetes admission controller for policy management.

## Installation (Helm)

1. Add the Helm repo:

   ```sh
   helm repo add kyverno https://kyverno.github.io/kyverno/
   helm repo update
   ```

2. Install Kyverno:

   ```sh
   helm install kyverno kyverno/kyverno -n kyverno --create-namespace
   ```

## Resources
- [Kyverno Documentation](https://kyverno.io/)
