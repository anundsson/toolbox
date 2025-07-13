# Platform Components

This directory contains platform-level components that form the foundation of a multi-tenancy Kubernetes cluster.

## Components

- **GitOps** - `argo-cd` for GitOps workflow management
- **Security** - Admission controllers (`kyverno`, `gatekeeper`)
- **Secrets Management** - `external-secrets` and `vault` for secure secrets management
- **Monitoring** - `kube-prometheus-stack` for observability
- **Certificates** - `cert-manager` for certificate automation
- **Autoscaling** - `keda` for event-driven autoscaling
- **Service Mesh & Ingress** - `istio` for traffic management and ingress

## Directory Structure

Each application has its own directory named exactly after the application:

- `argo-cd/` - ArgoCD configuration and applications
- `kyverno/` - Kyverno policies and configuration
- `gatekeeper/` - OPA Gatekeeper constraints and configuration
- `external-secrets/` - External Secrets Operator setup
- `vault/` - HashiCorp Vault configuration
- `cert-manager/` - Certificate management configuration
- `kube-prometheus-stack/` - Monitoring stack setup
- `keda/` - KEDA autoscaling configuration
- `istio/` - Istio service mesh configuration

Each directory contains:

- values.yaml (configuration values)
- README.md (documentation)
- Additional configuration files and examples

## Deployment

These components should be installed before tenant workloads. The recommended order is:

1. ArgoCD (GitOps)
2. Security components (Kyverno, Gatekeeper)
3. Secrets management (External Secrets, Vault)
4. Certificates management (cert-manager)
5. Istio Service Mesh & Ingress
6. Monitoring stack
7. Autoscaling (KEDA)
