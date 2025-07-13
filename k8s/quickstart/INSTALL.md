# Kubernetes Multi-Tenancy Quickstart Installation Guide

This guide provides detailed instructions for setting up a multi-tenancy Kubernetes cluster using ArgoCD to deploy all components via GitOps.

## Prerequisites

- Kubernetes cluster (1.21+)
- kubectl configured to access your cluster
- helm (v3.8+)

## Installation Process

### 1. Bootstrap ArgoCD

The entire platform can be installed with just a single bootstrap command:

```bash
# Apply the bootstrap application that will install ArgoCD and configure everything else
kubectl apply -f https://raw.githubusercontent.com/anundsson/toolbox/main/k8s/quickstart/bootstrap.yaml
```

This bootstrap application will:
1. Install ArgoCD in the argocd namespace
2. Configure ArgoCD with proper settings for GitOps
3. Apply the ApplicationSet that deploys all platform components

### 2. Access ArgoCD UI

```bash
# Port forward to access the ArgoCD UI
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Open [https://localhost:8080](https://localhost:8080) in your browser.

Default login:
- Username: `admin`
- Password: Get it with:
  ```bash
  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
  ```

### 3. Deploy the ApplicationSet Controller

The ApplicationSet will automatically create all required Application resources to deploy the platform components.

Create a file named `platform-applicationset.yaml`:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: platform-components
  namespace: argocd
spec:
  generators:
  - list:
      elements:
      - name: kyverno
        path: platform/kyverno
        namespace: kyverno
      - name: gatekeeper
        path: platform/gatekeeper
        namespace: gatekeeper-system
        optional: true  # Skip if not needed (alternative to Kyverno)
      - name: external-secrets
        path: platform/external-secrets
        namespace: external-secrets
      - name: vault
        path: platform/vault
        namespace: vault
      - name: cert-manager
        path: platform/cert-manager
        namespace: cert-manager
      - name: kube-prometheus-stack
        path: platform/kube-prometheus-stack
        namespace: monitoring
      - name: keda
        path: platform/keda
        namespace: keda
      - name: istio
        path: platform/istio
        namespace: istio-system
  template:
    metadata:
      name: '{{name}}'
      namespace: argocd
    spec:
      project: default
      source:
        repoURL: https://github.com/anundsson/toolbox.git
        targetRevision: main
        path: '{{path}}'
      destination:
        server: https://kubernetes.default.svc
        namespace: '{{namespace}}'
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
        retry:
          limit: 5
          backoff:
            duration: 5s
            factor: 2
            maxDuration: 3m
```

Apply the ApplicationSet:

```bash
kubectl apply -f platform-applicationset.yaml
```

### 4. Monitor Deployment Progress

You can monitor the deployment progress through the ArgoCD UI or using kubectl:

```bash
# Check all applications
kubectl get applications -n argocd

# Check status of a specific component (e.g. cert-manager)
kubectl get application cert-manager -n argocd -o jsonpath='{.status.sync.status}'
```

## Deployment Order & Dependencies

The platform components will deploy in this order, with proper dependency management:

1. Security components (Kyverno/Gatekeeper)
2. Secrets management (External Secrets, Vault)
3. Certificate management (cert-manager)
4. Service mesh (Istio)
5. Monitoring stack (Prometheus, Grafana)
6. Autoscaling (KEDA)

## Accessing Services

### Grafana
```bash
kubectl port-forward svc/kube-prometheus-stack-grafana -n monitoring 3000:80
```
Username: admin
Password: Check the Grafana admin secret

### Istio Ingress Gateway
```bash
# Get External IP
kubectl get svc istio-ingressgateway -n istio-system
```

### Vault
```bash
kubectl port-forward svc/vault -n vault 8200:8200
```

## Next Steps

1. Create tenant namespaces with appropriate labels
2. Set up network policies for tenant isolation
3. Configure resource quotas for each tenant
4. Set up RBAC for tenant administrators

See the [multi-tenancy README](/Users/andre/repos/work/anundio/toolbox/k8s/quickstart/multi-tenancy/README.md) for detailed instructions.

## Values Configuration

All values used for deployment are stored in the GitHub repository at:
https://github.com/anundsson/toolbox/tree/main/k8s/quickstart/platform

You can customize these values by forking the repository and modifying the values.yaml files in each component's directory.
