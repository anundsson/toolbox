# Service Mesh & Ingress Controller

This directory contains Istio service mesh configuration for a multi-tenancy Kubernetes cluster.

## Components

- **Istio Base** - CRDs and base components
- **Istiod** - Control plane
- **Istio Gateway** - Ingress gateway for external traffic

## Installation

1. Add the Istio Helm repository:

   ```sh
   helm repo add istio https://istio-release.storage.googleapis.com/charts
   helm repo update
   ```

2. Install Istio Base (CRDs):

   ```sh
   helm install istio-base istio/base -n istio-system --create-namespace
   ```

3. Install Istiod (Control Plane):

   ```sh
   helm install istiod istio/istiod -n istio-system --wait
   ```

4. Install Ingress Gateway:

   ```sh
   helm install istio-ingress istio/gateway -n istio-system
   ```

## Multi-Tenancy Configuration

Istio provides fine-grained traffic management that can be used for tenant isolation:

- Each tenant can have its own namespace with sidecars injected
- AuthorizationPolicies restrict communication between tenants
- Gateway resources can route traffic to specific tenants

### Example Authorization Policy

```yaml
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: tenant-isolation
  namespace: tenant-a
spec:
  action: ALLOW
  rules:
  - from:
    - source:
        namespaces: ["tenant-a", "istio-system"]
```

## Resources

- [Istio Documentation](https://istio.io/latest/docs/)
- [Multi-tenancy in Istio](https://istio.io/latest/docs/ops/deployment/deployment-models/#multiple-tenants)
