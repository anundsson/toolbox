# Gatekeeper Quickstart

This folder contains instructions for installing Open Policy Agent (OPA) Gatekeeper, an admission controller for policy enforcement.

## Installation (Helm)

1. Add the Helm repo:

   ```sh
   helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts
   helm repo update
   ```

2. Install Gatekeeper:

   ```sh
   helm install gatekeeper gatekeeper/gatekeeper \
     --namespace gatekeeper-system \
     --create-namespace \
     --values values.yaml
   ```

## Resources

- [Gatekeeper Documentation](https://open-policy-agent.github.io/gatekeeper/website/docs/)
