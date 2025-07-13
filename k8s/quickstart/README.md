# Kubernetes Quickstart Guide

This quickstart provides essential tools and manifests to bootstrap a local Kubernetes environment, including ArgoCD for GitOps workflows. All resources are organized for clarity and ease of use.

## Structure

- `argocd/` — ArgoCD installation manifests, applications, and instructions
- `external-secrets/` — External Secrets Operator Helm install and docs
- `admission-controller/` — Kyverno (admission controller) Helm install and docs
- `cert-manager/` — Certificate management with values and docs
- `monitoring/` — Prometheus & Grafana stack with values and docs
- `gatekeeper/` — OPA Gatekeeper policies and configuration
- `keda/` — Kubernetes Event-driven Autoscaling setup
- `vault/` — HashiCorp Vault for advanced secrets management
- `multi-tenancy/` — Multi-tenancy examples and configuration
- `helm/` — Helm install and usage docs
- `tools.md` — Other essential tools (metrics-server, ingress-nginx, etc.)
- `README.md` — This guide
- Additional folders for other tools can be added as needed

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (for local clusters)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [kind](https://kind.sigs.k8s.io/) (for local multi-node clusters)
- [Helm](https://helm.sh/docs/intro/install/) (for installing charts)

## Getting Started

### 1. Create a Local Kubernetes Cluster with Kind

```sh
kind create cluster --config ../kind-3-node-config.yaml
```

### 2. Install ArgoCD (GitOps)

Apply the ArgoCD manifests:

```sh
kubectl apply -n argocd -f quickstart/argocd/install.yaml
```

### 3. Access ArgoCD UI

Port-forward the ArgoCD server:

```sh
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Then open [https://localhost:8080](https://localhost:8080) in your browser.

Default login:

- Username: `admin`
- Password: Run:

  ```sh
  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
  ```

### 4. Install Essential Tools with Helm

See each tool's folder for Helm install instructions:

- External Secrets Operator: `quickstart/external-secrets/README.md`
- Admission Controller (Kyverno): `quickstart/admission-controller/README.md`
- Helm usage: `quickstart/helm/README.md`

### 5. Multi-Tenancy Setup

- Use namespaces to isolate tenants.
- Use Kyverno for policy enforcement.
- Use External Secrets Operator for secure secret management per tenant.
- Use ArgoCD Applications to deploy tenant-specific resources and tooling.

See `quickstart/argocd/applications/README.md` for examples of deploying tools via ArgoCD.

## Next Steps

- Add more tools (e.g., metrics-server, ingress-nginx, cert-manager, kube-prometheus-stack, Grafana, Loki, Open Policy Agent, KEDA, etc.) in their own folders
- Use ArgoCD Applications to automate installation of all tooling
- Customize manifests and Helm values for your multi-tenancy needs
- Contribute by adding new tools, improving docs, or sharing best practices

---
For more details, see documentation in each tool's folder.
